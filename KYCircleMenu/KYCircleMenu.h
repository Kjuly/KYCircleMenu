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

- (id)initWithButtonCount:(NSInteger)buttonCount     // count of buttons around
                 menuSize:(CGFloat)menuSize          // size of menu
               buttonSize:(CGFloat)buttonSize        // size of buttons around
         centerButtonSize:(CGFloat)centerButtonSize; // size of center button

- (void)runButtonActions:(id)sender;
- (void)pushViewController:(id)viewController;
//- (void)checkDeviceSystemFor:(id)viewController;
- (void)openCenterMenuView;
- (void)recoverToNormalStatus;

@end
