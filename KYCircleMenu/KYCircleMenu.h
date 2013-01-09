//
//  KYCircleMenu.h
//  KYCircleMenu
//
//  Created by Kaijie Yu on 2/1/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

// The default case is that the navigation bar is only shown in child views.
// If it is needed to be shown with the circle menu together,
//   just copy this macro into your own config file & comment it out.
//
// #define KY_CIRCLEMENU_WITH_NAVIGATIONBAR 1

// Constants
#define kKYCircleMenuViewHeight CGRectGetHeight([UIScreen mainScreen].applicationFrame)
#define kKYCircleMenuViewWidth  CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define kKYCircleMenuNavigationBarHeight 44.f

// Notification to close the menu
#define kKYNCircleMenuClose @"KYNCircleMenuClose"


@interface KYCircleMenu : UIViewController {
  UIView   * menu_;
  UIButton * centerButton_;
  BOOL       isOpening_;
  BOOL       isInProcessing_;
  BOOL       isClosed_;
}

@property (nonatomic, retain) UIView   * menu;
@property (nonatomic, retain) UIButton * centerButton;
@property (nonatomic, assign) BOOL       isOpening;
@property (nonatomic, assign) BOOL       isInProcessing;
@property (nonatomic, assign) BOOL       isClosed;

// |buttonCount| : count of buttons around (1<= x <=6)
// |menuSize| : size of menu
// |buttonSize| : size of buttons around
// |buttonImageNameFormat| : name format for button image
// |centerButtonSize| : size of center button
// |centerButtonImageName| : name for center button image
// |centerButtonBackgroundImageName| : name for center button background image
- (id)      initWithButtonCount:(NSInteger)buttonCount
                       menuSize:(CGFloat)menuSize
                     buttonSize:(CGFloat)buttonSize
          buttonImageNameFormat:(NSString *)buttonImageNameFormat
               centerButtonSize:(CGFloat)centerButtonSize
          centerButtonImageName:(NSString *)centerButtonImageName
centerButtonBackgroundImageName:(NSString *)centerButtonBackgroundImageName;

// Run action for buttons around.
// Override this message to do custom jobs,
//   but with |[super runButtonActions:sender];| at top.
- (void)runButtonActions:(id)sender;

// Custom push message to manage menu & the child views well.
// When press a button, dispatch this message to swipe away the menu buttons,
//   and push the new view controller appropriately
- (void)pushViewController:(id)viewController;

// Open menu to show all buttons around
- (void)open;

// Recover all buttons to normal position
- (void)recoverToNormalStatus;

@end
