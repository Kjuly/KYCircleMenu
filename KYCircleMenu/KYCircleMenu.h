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

- (void)runButtonActions:(id)sender;
- (void)pushViewController:(id)viewController;
//- (void)checkDeviceSystemFor:(id)viewController;
- (void)openCenterMenuView;
- (void)recoverToNormalStatus;

@end
