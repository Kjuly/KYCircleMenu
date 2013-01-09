//
//  KYCircleMenu.m
//  KYCircleMenu
//
//  Created by Kaijie Yu on 2/1/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "KYCircleMenu.h"

@interface KYCircleMenu () {
 @private
  NSInteger buttonCount_;
  CGRect    buttonOriginFrame_;
}

- (void)_releaseSubviews;
- (void)_toggleCircleMenu:(id)sender;
- (void)_closeCenterMenuView:(NSNotification *)notification;
- (void)_computeAndSetButtonLayoutWithTriangleHypotenuse:(CGFloat)triangleHypotenuse;
- (void)_setButtonWithTag:(NSInteger)buttonTag origin:(CGPoint)origin;

@end


// Basic configuration for the Circle Menu
static CGFloat menuSize_,         // size of menu
               buttonSize_,       // size of buttons around
               centerButtonSize_; // size of center button


@implementation KYCircleMenu

@synthesize centerMenu     = centerMenu_;
@synthesize isOpening      = isOpening_;
@synthesize isInProcessing = isInProcessing_;
@synthesize isClosed       = isClosed_;

@synthesize mainButton = mainButton_;

-(void)dealloc {
  // Release subvies & remove notification observer
  [self _releaseSubviews];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kKYNCircleMenuCloseCenterMenu object:nil];
  [super dealloc];
}

- (void)_releaseSubviews {
  self.centerMenu = nil;
  self.mainButton = nil;
}

- (id)initWithButtonCount:(NSInteger)buttonCount
                 menuSize:(CGFloat)menuSize
               buttonSize:(CGFloat)buttonSize
         centerButtonSize:(CGFloat)centerButtonSize {
  if (self = [self init]) {
    buttonCount_      = buttonCount; // Min: 1, Max: 6
    menuSize_         = menuSize;
    buttonSize_       = buttonSize;
    centerButtonSize_ = centerButtonSize;
  }
  return self;
}

- (id)init {
  self = [super init];
  if (self) {
    isInProcessing_ = NO;
    isOpening_      = NO;
    isClosed_       = YES;
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
  UIView * view = [[UIView alloc] init];
  CGFloat viewHeight = (self.navigationController ? kKYViewHeight - kKYNavigationBarHeight :kKYViewHeight);
  [view setFrame:(CGRect){CGPointZero, {kKYViewWidth, viewHeight}}];
  self.view = view;
  [view release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGFloat viewHeight = CGRectGetHeight(self.view.frame);
  CGFloat viewWidth  = CGRectGetWidth(self.view.frame);
  
  // Center Menu View
  CGRect centerMenuFrame =
    CGRectMake((viewWidth - menuSize_) / 2, (viewHeight - menuSize_) / 2, menuSize_, menuSize_);
  UIView * centerMenu = [[UIView alloc] initWithFrame:centerMenuFrame];
  [centerMenu setAlpha:0.f];
  self.centerMenu = centerMenu;
  [centerMenu release];
  [self.view addSubview:self.centerMenu];
  
  // Add buttons to |ballMenu_|, set it's origin frame to center
  buttonOriginFrame_ = CGRectMake((menuSize_ - centerButtonSize_) / 2,
                                  (menuSize_ - centerButtonSize_) / 2,
                                  centerButtonSize_,
                                  centerButtonSize_);
  for (int i = 1; i <= buttonCount_; ++i) {
    UIButton * button = [[UIButton alloc] initWithFrame:buttonOriginFrame_];
    [button setOpaque:NO];
    [button setTag:i];
    [button addTarget:self action:@selector(runButtonActions:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerMenu addSubview:button];
    [button release];
  }
  
  // Main Button
  CGRect mainButtonFrame =
    CGRectMake((CGRectGetWidth(self.view.frame) - centerButtonSize_) / 2.f,
               (CGRectGetHeight(self.view.frame) - centerButtonSize_) / 2.f,
               centerButtonSize_, centerButtonSize_);
  mainButton_ = [[UIButton alloc] initWithFrame:mainButtonFrame];
  [mainButton_ setBackgroundImage:[UIImage imageNamed:kKYICircleMenuMainButtonBackground]
                         forState:UIControlStateNormal];
  [mainButton_ setImage:[UIImage imageNamed:kKYICircleMenuMainButtonNormal]
               forState:UIControlStateNormal];
  [mainButton_ addTarget:self
                  action:@selector(_toggleCircleMenu:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:mainButton_];
  
  // Add Observer for close self
  // If |centerMainButton_| post cancel notification, do it
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(_closeCenterMenuView:)
                                               name:kKYNCircleMenuCloseCenterMenu
                                             object:nil];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  [self _releaseSubviews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Publich Button Action

// Run action depend on button, it'll be implemented by subclass
- (void)runButtonActions:(id)sender {
  // Close center menu
  [self _closeCenterMenuView:nil];
  
  // Set |mainButton_|'s image to selecetd ones
  [mainButton_ setImage:[[sender imageView] image]
               forState:UIControlStateNormal];
}

// Push View Controller
- (void)pushViewController:(id)viewController {
  [UIView animateWithDuration:.3f
                        delay:0.f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     // Slide away buttons in center view & hide them
                     [self _computeAndSetButtonLayoutWithTriangleHypotenuse:300.f];
                     [self.centerMenu setAlpha:0.f];
                     
                     // Show Navigation Bar
                     [self.navigationController setNavigationBarHidden:NO];
                     CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
                     if (navigationBarFrame.origin.y < 0) {
                       navigationBarFrame.origin.y = 0;
                       [self.navigationController.navigationBar setFrame:navigationBarFrame];
                     }
                   }
                   completion:^(BOOL finished) {
                     [self.navigationController pushViewController:viewController animated:YES];
                   }];
}

/*/ Check device's system, it it's lower than iOS5.0, methods like |viewWillAppear:| will not be called
// So, manually send them
- (void)checkDeviceSystemFor:(id)viewController {
  if (SYSTEM_VERSION_LESS_THAN(@"5.0"))
    [viewController viewWillAppear:YES];
}*/

// Open center menu view
- (void)openCenterMenuView {
  if (isOpening_)
    return;
  isInProcessing_ = YES;
  // Show buttons with animation
  [UIView animateWithDuration:.3f
                        delay:0.f
                      options:UIViewAnimationCurveEaseInOut
                   animations:^{
                     [self.centerMenu setAlpha:1.f];
                     // Compute buttons' frame and set for them, based on |buttonCount|
                     [self _computeAndSetButtonLayoutWithTriangleHypotenuse:125.f];
                   }
                   completion:^(BOOL finished) {
                     [UIView animateWithDuration:.1f
                                           delay:0.f
                                         options:UIViewAnimationCurveEaseInOut
                                      animations:^{
                                        [self _computeAndSetButtonLayoutWithTriangleHypotenuse:112.f];
                                      }
                                      completion:^(BOOL finished) {
                                        isOpening_ = YES;
                                        isClosed_ = NO;
                                        isInProcessing_ = NO;
                                      }];
                   }];
}

// Recover to normal status
- (void)recoverToNormalStatus {
  [UIView animateWithDuration:.3f
                        delay:0.f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     // Show buttons & slide in to center
                     [self.centerMenu setAlpha:1.f];
                     [self _computeAndSetButtonLayoutWithTriangleHypotenuse:100.f];
                   }
                   completion:^(BOOL finished) {
                     [UIView animateWithDuration:.1f
                                           delay:0.f
                                         options:UIViewAnimationOptionCurveEaseInOut
                                      animations:^{
                                        [self _computeAndSetButtonLayoutWithTriangleHypotenuse:112.f];
                                      }
                                      completion:nil];
                   }];
}

#pragma mark - Private Methods

// Toggle Circle Menu
- (void)_toggleCircleMenu:(id)sender {
  if (isClosed_) [self openCenterMenuView];
  else           [self _closeCenterMenuView:nil];
}

// Close center menu view
- (void)_closeCenterMenuView:(NSNotification *)notification {
  if (isClosed_)
    return;
  isInProcessing_ = YES;
  // Hide buttons with animation
  [UIView animateWithDuration:.3f
                        delay:0.f
                      options:UIViewAnimationCurveEaseIn
                   animations:^{
                     for (UIButton * button in [self.centerMenu subviews])
                       [button setFrame:buttonOriginFrame_];
                     [self.centerMenu setAlpha:0.f];
                   }
                   completion:^(BOOL finished) {
                     /*
                     if (self.navigationController)
                       [self.navigationController.view removeFromSuperview];
//                       [self.navigationController removeFromParentViewController];
                     else
                       [self.view removeFromSuperview];
//                       [self removeFromParentViewController];
                      */
                     isClosed_       = YES;
                     isOpening_      = NO;
                     isInProcessing_ = NO;
                   }];
}

// Compute buttons' layout based on |buttonCount|
- (void)_computeAndSetButtonLayoutWithTriangleHypotenuse:(CGFloat)triangleHypotenuse {
  //
  //  Triangle Values for Buttons' Position
  // 
  //      /|      a: triangleA = c * cos(x)
  //   c / | b    b: triangleB = c * sin(x)
  //    /)x|      c: triangleHypotenuse
  //   -----      x: degree
  //     a
  //
  CGFloat centerBallMenuHalfSize = menuSize_         / 2.f;
  CGFloat buttonRadius           = centerButtonSize_ / 2.f;
  if (! triangleHypotenuse) triangleHypotenuse = 112.f; // Distance to Ball Center
  
  //
  //      o       o   o      o   o     o   o     o o o     o o o
  //     \|/       \|/        \|/       \|/       \|/       \|/
  //  1 --|--   2 --|--    3 --|--   4 --|--   5 --|--   6 --|--
  //     /|\       /|\        /|\       /|\       /|\       /|\
  //                           o       o   o     o   o     o o o
  //
  switch (buttonCount_) {
    case 1:
      [self _setButtonWithTag:1 origin:CGPointMake(centerBallMenuHalfSize - buttonRadius,
                                                  centerBallMenuHalfSize - triangleHypotenuse - buttonRadius)];
      break;
      
    case 2: {
      CGFloat degree    = M_PI / 4.0f; // = 45 * M_PI / 180
      CGFloat triangleB = triangleHypotenuse * sinf(degree);
      CGFloat negativeValue = centerBallMenuHalfSize - triangleB - buttonRadius;
      CGFloat positiveValue = centerBallMenuHalfSize + triangleB - buttonRadius;
      [self _setButtonWithTag:1 origin:CGPointMake(negativeValue, negativeValue)];
      [self _setButtonWithTag:2 origin:CGPointMake(positiveValue, negativeValue)];
      break;
    }
      
    case 3: {
      // = 360.0f / self.buttonCount * M_PI / 180.0f;
      // E.g: if |buttonCount_ = 6|, then |degree = 60.0f * M_PI / 180.0f|;
      // CGFloat degree = 2 * M_PI / self.buttonCount;
      //
      CGFloat degree    = M_PI / 3.0f; // = 60 * M_PI / 180
      CGFloat triangleA = triangleHypotenuse * cosf(degree);
      CGFloat triangleB = triangleHypotenuse * sinf(degree);
      [self _setButtonWithTag:1 origin:CGPointMake(centerBallMenuHalfSize - triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      [self _setButtonWithTag:2 origin:CGPointMake(centerBallMenuHalfSize + triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      [self _setButtonWithTag:3 origin:CGPointMake(centerBallMenuHalfSize - buttonRadius,
                                                  centerBallMenuHalfSize + triangleHypotenuse - buttonRadius)];
      break;
    }
      
    case 4: {
      CGFloat degree    = M_PI / 4.0f; // = 45 * M_PI / 180
      CGFloat triangleB = triangleHypotenuse * sinf(degree);
      CGFloat negativeValue = centerBallMenuHalfSize - triangleB - buttonRadius;
      CGFloat positiveValue = centerBallMenuHalfSize + triangleB - buttonRadius;
      [self _setButtonWithTag:1 origin:CGPointMake(negativeValue, negativeValue)];
      [self _setButtonWithTag:2 origin:CGPointMake(positiveValue, negativeValue)];
      [self _setButtonWithTag:3 origin:CGPointMake(negativeValue, positiveValue)];
      [self _setButtonWithTag:4 origin:CGPointMake(positiveValue, positiveValue)];
      break;
    }
      
    case 5: {
      CGFloat degree    = M_PI / 2.5f; // = 72 * M_PI / 180
      CGFloat triangleA = triangleHypotenuse * cosf(degree);
      CGFloat triangleB = triangleHypotenuse * sinf(degree);
      [self _setButtonWithTag:1 origin:CGPointMake(centerBallMenuHalfSize - triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      [self _setButtonWithTag:2 origin:CGPointMake(centerBallMenuHalfSize - buttonRadius,
                                                  centerBallMenuHalfSize - triangleHypotenuse - buttonRadius)];
      [self _setButtonWithTag:3 origin:CGPointMake(centerBallMenuHalfSize + triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      
      degree    = M_PI / 5.0f;  // = 36 * M_PI / 180
      triangleA = triangleHypotenuse * cosf(degree);
      triangleB = triangleHypotenuse * sinf(degree);
      [self _setButtonWithTag:4 origin:CGPointMake(centerBallMenuHalfSize - triangleB - buttonRadius,
                                                  centerBallMenuHalfSize + triangleA - buttonRadius)];
      [self _setButtonWithTag:5 origin:CGPointMake(centerBallMenuHalfSize + triangleB - buttonRadius,
                                                  centerBallMenuHalfSize + triangleA - buttonRadius)];
      break;
    }
      
    case 6: {
      CGFloat degree    = M_PI / 3.0f; // = 60 * M_PI / 180
      CGFloat triangleA = triangleHypotenuse * cosf(degree);
      CGFloat triangleB = triangleHypotenuse * sinf(degree);
      [self _setButtonWithTag:1 origin:CGPointMake(centerBallMenuHalfSize - triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      [self _setButtonWithTag:2 origin:CGPointMake(centerBallMenuHalfSize - buttonRadius,
                                                  centerBallMenuHalfSize - triangleHypotenuse - buttonRadius)];
      [self _setButtonWithTag:3 origin:CGPointMake(centerBallMenuHalfSize + triangleB - buttonRadius,
                                                  centerBallMenuHalfSize - triangleA - buttonRadius)];
      [self _setButtonWithTag:4 origin:CGPointMake(centerBallMenuHalfSize - triangleB - buttonRadius,
                                                  centerBallMenuHalfSize + triangleA - buttonRadius)];
      [self _setButtonWithTag:5 origin:CGPointMake(centerBallMenuHalfSize - buttonRadius,
                                                  centerBallMenuHalfSize + triangleHypotenuse - buttonRadius)];
      [self _setButtonWithTag:6 origin:CGPointMake(centerBallMenuHalfSize + triangleB - buttonRadius,
                                                  centerBallMenuHalfSize + triangleA - buttonRadius)];
      break;
    }
      
    default:
      break;
  }
}

// Set Frame for button with special tag
- (void)_setButtonWithTag:(NSInteger)buttonTag origin:(CGPoint)origin {
  UIButton * button = (UIButton *)[self.centerMenu viewWithTag:buttonTag];
  [button setFrame:CGRectMake(origin.x, origin.y, centerButtonSize_, centerButtonSize_)];
  button = nil;
}

@end
