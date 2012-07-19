//
//  KYCircleMenu.h
//  KYCircleMenu
//
//  Created by Kaijie Yu on 2/1/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

// View Constants
#define kKYCircleMenuMainButtonSize 64.f
#define kKYCircleMenuSize           305.f
#define kKYCircleMenuButtonSize     64.f

// Image Name
#define kKYICircleMainButtonNormal     @"KYICircleMainButtonNormal.png"
#define kKYICircleMainButtonBackground @"KYICircleMainButtonBackground.png"

// For |centerMainButton_| status
typedef enum {
  kCenterMainButtonStatusNormal = 0,
  kCenterMainButtonStatusAtBottom
}CenterMainButtonStatus;

// Notification Name
#define kKYNCloseCenterMenu              @"KYNCloseCenterMenu"
#define kKYNChangeCenterMainButtonStatus @"KYNChangeCenterMainButtonStatus"

@interface KYCircleMenu : UIViewController {
  UIView * centerMenu_;
  BOOL      isOpening_;
  BOOL isInProcessing_;
  BOOL      isClosed_;
}

@property (nonatomic, retain) UIView * centerMenu;
@property (nonatomic, assign) BOOL     isOpening;
@property (nonatomic, assign) BOOL     isInProcessing;
@property (nonatomic, assign) BOOL     isClosed;

- (id)initWithButtonCount:(NSInteger)buttonCount;
- (void)runButtonActions:(id)sender;
- (void)pushViewController:(id)viewController;
//- (void)checkDeviceSystemFor:(id)viewController;
- (void)openCenterMenuView;
- (void)recoverToNormalStatus;

@end
