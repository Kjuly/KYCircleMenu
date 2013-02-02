//
//  AppDelegate.m
//  KYCircleMenuDemo
//
//  Created by Kjuly on 7/18/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "AppDelegate.h"

#import "CircleMenuViewController.h"

@implementation AppDelegate

- (void)dealloc {
  [_window release];
  [super dealloc];
}

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  // Override point for customization after application launch.
  
  // Setup circle menu with basic configuration
  CircleMenuViewController * circleMenuViewController;
  circleMenuViewController = [CircleMenuViewController alloc];
  [circleMenuViewController initWithButtonCount:kKYCCircleMenuButtonsCount
                                       menuSize:kKYCircleMenuSize
                                     buttonSize:kKYCircleMenuButtonSize
                          buttonImageNameFormat:kKYICircleMenuButtonImageNameFormat
                               centerButtonSize:kKYCircleMenuCenterButtonSize
                          centerButtonImageName:kKYICircleMenuCenterButton
                centerButtonBackgroundImageName:kKYICircleMenuCenterButtonBackground];
  // Navigation Controller
  UINavigationController * navigationController = [UINavigationController alloc];
  // Set the cricle menu vc as the root vc
  [navigationController initWithRootViewController:circleMenuViewController];
  [circleMenuViewController release];
  [navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
#ifndef KY_CIRCLEMENU_WITH_NAVIGATIONBAR
  [navigationController setNavigationBarHidden:YES];
#endif
  
  // Set navigation controller as the root vc
  [self.window setRootViewController:navigationController];
  [navigationController release];
  
  [self.window makeKeyAndVisible];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  return YES;
}

@end
