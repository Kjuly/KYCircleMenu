//
//  Constants.h
//  KYCircleMenuDemo
//
//  Created by Kaijie Yu on 6/24/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Basic Configuration - prefix: KYC

#define kKYCCircleMenuButtonsCount 6

#pragma mark - Key of Settings.bundle - prefix: KYS

#pragma mark - Key of Notification Name - prefix: KYN

#pragma mark - Image - prefix: KYI


#pragma mark -
#pragma mark - View  - prefix: KY

// App View Basic
#define kKYViewHeight CGRectGetHeight([UIScreen mainScreen].applicationFrame)
#define kKYViewWidth  CGRectGetWidth([UIScreen mainScreen].applicationFrame)

// Navigation Bar
#define kKYNavigationBarHeight 44.f

// Button Size
#define kKYButtonInMiniSize   16.f
#define kKYButtonInSmallSize  32.f
#define kKYButtonInNormalSize 64.f

#pragma mark - KYCircleMenu Configuration

// Circle Menu
#define kKYCircleMenuSize             305.f
#define kKYCircleMenuButtonSize       64.f
#define kKYCircleMenuCenterButtonSize 64.f

#define kKYICircleMenuCenterButton           @"KYICircleMenuCenterButton.png"
#define kKYICircleMenuCenterButtonBackground @"KYICircleMenuCenterButtonBackground.png"
#define kKYICircleMenuButtonImageNameFormat  @"KYICircleMenuButton%.2d.png" // %.2d: 1 - 6

@interface Constants : NSObject

@end
