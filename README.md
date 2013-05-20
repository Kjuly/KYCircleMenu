KYCircleMenu
============

A circle menu with toggling animation. And you can customize the number of buttons between (1 ~ 6).

![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_1.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_2.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_3.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_4.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_5.png)
![](https://raw.github.com/Kjuly/KYCircleMenu/dev/DemoScreenshot/demo_screenshot_6.png)

This control is separated from [iPokeMon](https://github.com/Kjuly/iPokeMon) (a PokéMon game on iOS with Location Based Service), you can take a look at the demo video how cool it is!

<!-- MacBuildServer Install Button -->
<div class="macbuildserver-block">
    <a class="macbuildserver-button" href="http://macbuildserver.com/project/github/build/?xcode_project=KYCircleMenuDemo%2FKYCircleMenuDemo.xcodeproj&amp;target=KYCircleMenuDemo&amp;repo_url=git%3A%2F%2Fgithub.com%2FKjuly%2FKYCircleMenu.git&amp;build_conf=Release" target="_blank"><img src="http://com.macbuildserver.github.s3-website-us-east-1.amazonaws.com/button_up.png"/></a><br/><sup><a href="http://macbuildserver.com/github/opensource/" target="_blank">by MacBuildServer</a></sup>
</div>
<!-- MacBuildServer Install Button -->


- [Youtube](http://www.youtube.com/watch?v=otiBQnwdt0U) - 2012-05-09
- [Youku](http://v.youku.com/v_show/id_XNDA1MjExMDg4.html) - 2012-06-03 (Newer)

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

