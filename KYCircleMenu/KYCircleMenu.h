//
//  KYCircleMenu.h
//  KYCircleMenu
//
//  Created by Kaijie Yu on 2/1/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

// Notification Name - Prefix: kKYNCircleMenu
#define kKYNCircleMenuCloseCenterMenu @"KYNCircleMenuCloseCenterMenu"
//#define kKYCircleMenuNChangeCenterMainButtonStatus @"KYCircleMenuNChangeCenterMainButtonStatus"

// Image Name - Prefix: kKYI
#define kKYICircleMenuMainButtonNormal     @"KYICircleMenuMainButtonNormal.png"
#define kKYICircleMenuMainButtonBackground @"KYICircleMenuMainButtonBackground.png"

// View Constants - Prefix: kKY
#define kKYCircleMenuMainButtonSize 64.f
#define kKYCircleMenuSize           305.f
#define kKYCircleMenuButtonSize     64.f


@interface KYCircleMenu : UIViewController {
  UIButton * mainButton_;
  UIView   * centerMenu_;
  BOOL       isOpening_;
  BOOL       isInProcessing_;
  BOOL       isClosed_;
}

@property (nonatomic, retain) UIButton * mainButton;
@property (nonatomic, retain) UIView   * centerMenu;
@property (nonatomic, assign) BOOL       isOpening;
@property (nonatomic, assign) BOOL       isInProcessing;
@property (nonatomic, assign) BOOL       isClosed;

- (id)initWithButtonCount:(NSInteger)buttonCount;
- (void)runButtonActions:(id)sender;
- (void)pushViewController:(id)viewController;
//- (void)checkDeviceSystemFor:(id)viewController;
- (void)openCenterMenuView;
- (void)recoverToNormalStatus;

@end
