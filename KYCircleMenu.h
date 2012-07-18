//
//  KYCircleMenu.h
//  KYCircleMenu
//
//  Created by Kaijie Yu on 2/1/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

// View Constants
#define kKYCenterMainButtonSize 64.0f
#define kKYCenterMenuSize       305.0f
#define kKYCenterMenuButtonSize 64.0f

// For |centerMainButton_| status
typedef enum {
  kCenterMainButtonStatusNormal = 0,
  kCenterMainButtonStatusAtBottom,
  kCenterMainButtonStatusPokemonAppeared
}CenterMainButtonStatus;

// Notification Name
#define kKYNCloseCenterMenu              @"KYNCloseCenterMenu"
#define kKYNChangeCenterMainButtonStatus @"KYNChangeCenterMainButtonStatus"

@interface KYCircleMenu : UIViewController {
  UIView * centerMenu_;
  BOOL      isOpening_;
  BOOL isInProcessing_;
}

@property (nonatomic, retain) UIView * centerMenu;
@property (nonatomic, assign) BOOL     isOpening;
@property (nonatomic, assign) BOOL     isInProcessing;

- (id)initWithButtonCount:(NSInteger)buttonCount;
- (void)runButtonActions:(id)sender;
- (void)pushViewController:(id)viewController;
//- (void)checkDeviceSystemFor:(id)viewController;
- (void)openCenterMenuView;
- (void)changeCenterMainButtonStatusToMove:(CenterMainButtonStatus)centerMainButtonStatus;

@end
