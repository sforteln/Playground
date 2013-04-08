//
//  ViewController.m
//  SFProfileHeader
//
//  Created by Simon Fortelny on 4/6/13.
//  Copyright (c) 2013 Simon Fortelny. All rights reserved.
//

#import "ViewController.h"
#import "ProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
  ProfileViewController *profileViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  profileViewController = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil backgroundImageNamed:@"background.jpg" profileImageNamed:@"pixel.jpg"];
  [self addChildViewController:profileViewController];
  [profileViewController tableToObserve:self.table];
  [self.view addSubview:profileViewController.view];
  NSLog(@"test");
}

@end
