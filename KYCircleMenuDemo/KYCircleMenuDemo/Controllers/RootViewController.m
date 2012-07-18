//
//  RootViewController.m
//  KYCircleMenuDemo
//
//  Created by Kjuly on 7/18/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "RootViewController.h"

#import "CircleMenuViewController.h"

@interface RootViewController () {
 @private
  UINavigationController   * navigationController_;
  CircleMenuViewController * circleMenuViewController_;
}

@property (nonatomic, retain) UINavigationController   * navigationController;
@property (nonatomic, retain) CircleMenuViewController * circleMenuViewController;

@end

@implementation RootViewController

@synthesize navigationController     = navigationController_;
@synthesize circleMenuViewController = circleMenuViewController_;

- (void)dealloc {
  self.navigationController     = nil;
  self.circleMenuViewController = nil;
  [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView {
  UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kKYViewWidth, kKYViewHeight)];
  self.view = view;
  [view release];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  // Circle Menu
  CircleMenuViewController * circleMenuViewController;
  circleMenuViewController = [[CircleMenuViewController alloc] initWithButtonCount:6];
  self.circleMenuViewController = circleMenuViewController;
  [circleMenuViewController release];
  
  // Navigation Controller
  navigationController_ = [UINavigationController alloc];
  [navigationController_ initWithRootViewController:self.circleMenuViewController];
  [self.view addSubview:self.circleMenuViewController.view];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
