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
  CircleMenuViewController * circleMenuViewController_;
}

@property (nonatomic, retain) CircleMenuViewController * circleMenuViewController;

@end

@implementation RootViewController

@synthesize circleMenuViewController = circleMenuViewController_;

- (void)dealloc {
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
  UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kKYViewWidth, kKYViewHeigth)];
  [view setBackgroundColor:[UIColor grayColor]];
  self.view = view;
  [view release];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  CircleMenuViewController * circleMenuViewController;
  circleMenuViewController = [[CircleMenuViewController alloc] initWithButtonCount:6];
  self.circleMenuViewController = circleMenuViewController;
  [circleMenuViewController release];
  
  [self.view addSubview:self.circleMenuViewController.view];
  [self.circleMenuViewController openCenterMenuView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
