KYCircleMenu
============

A circle menu with toggling animation. And you can customize the number of buttons between (1 ~ 6).

![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_1.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_2.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_3.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_4.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_5.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_6.png)

# Usage

### Designated Initializer

Use the designated initializer below to initialize the circle menu:

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

### Button Action

Override the `-runButtonActions:` message to customize your button action:

    - (void)runButtonActions:(id)sender {
      [super runButtonActions:sender];
  
      // Do buttons' action appropriately by |[sender tag]|
      // ...
    }

Tags are defined like below:

    TAG:        1       1   2      1   2     1   2     1 2 3     1 2 3
               \|/       \|/        \|/       \|/       \|/       \|/
    COUNT: 1) --|--  2) --|--   3) --|--  4) --|--  5) --|--  6) --|--
               /|\       /|\        /|\       /|\       /|\       /|\
    TAG:                             3       3   4     4   5     4 5 6

### Navigation Bar

The default case is that the navigation bar is only shown in child views. If you want it to be shown with the circle menu together, add the macro below

    #define KY_CIRCLEMENU_WITH_NAVIGATIONBAR 1

to your __constatns.h__ or __config.h__, or any other files that are imported in your __\<Project\>-Prefix.pch__.

---
# License

This code is distributed under the terms and conditions of the MIT license.

