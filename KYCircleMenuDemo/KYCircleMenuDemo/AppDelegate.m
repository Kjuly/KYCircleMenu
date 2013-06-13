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
  
  // Navigation Controller
  UINavigationController * navigationController = [UINavigationController alloc];
  
  // Circle Menu
  CircleMenuViewController * circleMenuViewController;
  circleMenuViewController = [CircleMenuViewController alloc];
  // Set the cricle menu vc as the root vc
  (void)[navigationController initWithRootViewController:circleMenuViewController];
  [navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
  
  // Setup circle menu with basic configuration
  (void)[circleMenuViewController initWithButtonCount:kKYCCircleMenuButtonsCount
                                             menuSize:kKYCircleMenuSize
                                           buttonSize:kKYCircleMenuButtonSize
                                buttonImageNameFormat:kKYICircleMenuButtonImageNameFormat
                                     centerButtonSize:kKYCircleMenuCenterButtonSize
                                centerButtonImageName:kKYICircleMenuCenterButton
                      centerButtonBackgroundImageName:kKYICircleMenuCenterButtonBackground];
  [circleMenuViewController release];
  
  // Set navigation controller as the root vc
  [self.window setRootViewController:navigationController];
  [navigationController release];
  
  [self.window makeKeyAndVisible];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  return YES;
}

@end
