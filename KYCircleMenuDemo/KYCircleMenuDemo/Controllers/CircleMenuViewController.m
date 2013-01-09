//
//  CircleMenuViewController.m
//  KYCircleMenuDemo
//
//  Created by Kjuly on 7/18/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "CircleMenuViewController.h"

@interface CircleMenuViewController () {
 @private
  NSTimeInterval delayTimeForRecoveringToNormalStatus_;
}

@end

@implementation CircleMenuViewController

- (void)dealloc {
  [super dealloc];
}

- (id)init {
  if (self = [super init]) {
    [self setTitle:@"KYCircleMenu"];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // set delay time for recovering to normal status
  delayTimeForRecoveringToNormalStatus_ = (self.navigationController ? .3f : 0.f);
  
  // Modify Buttons' style in center menu view
  for (UIButton * button in [self.menu subviews])
    [button setAlpha:.95f];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if (! self.isClosed)
    // recover circle menu to normal status
    [self performSelector:@selector(recoverToNormalStatus)
               withObject:nil
               afterDelay:delayTimeForRecoveringToNormalStatus_];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - KYCircleMenu Button Action

// Run button action depend on their tags
//
//       1       1   2      1   2     1   2     1 2 3     1 2 3
//      \|/       \|/        \|/       \|/       \|/       \|/
//  1) --|--  2) --|--   3) --|--  4) --|--  5) --|--  6) --|--
//      /|\       /|\        /|\       /|\       /|\       /|\
//                            3       4   3     5   4     6 5 4
//
- (void)runButtonActions:(id)sender {
  [super runButtonActions:sender];
  
  // Configure new view & push it with custom |pushViewController:| method
  UIViewController * viewController = [[UIViewController alloc] init];
  [viewController.view setBackgroundColor:[UIColor blackColor]];
  [viewController setTitle:[NSString stringWithFormat:@"View %d", [sender tag]]];
  // Use KYCircleMenu's |-pushViewController:| to push vc
  [self pushViewController:viewController];
  [viewController release];
}

@end
