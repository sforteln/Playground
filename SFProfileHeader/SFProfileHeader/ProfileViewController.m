//
//  ProfileViewController.m
//  SFProfileHeader
//
//  Created by Simon Fortelny on 4/6/13.
//  Copyright (c) 2013 Simon Fortelny. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()

 

@end

@implementation ProfileViewController {
  UITableView *observedTableView;
  CGRect initialHeaderFrame;
  CGRect originalProfileFrame;
  

  NSString *backgroundImageName;
  NSString *profileImageName;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil backgroundImageNamed:(NSString *)backgroundImage profileImageNamed:(NSString *)profileImage;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      backgroundImageName=backgroundImage;
      profileImageName=profileImage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  initialHeaderFrame = self.background.frame;
  originalProfileFrame=self.profile.frame;
  self.background.image=[UIImage imageNamed:backgroundImageName];
  self.profile.image=[UIImage imageNamed:profileImageName];
  
}

-(void)tableToObserve:(UITableView *)table{
  observedTableView= table;
  [observedTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
  if(observedTableView){
    [observedTableView removeObserver:self forKeyPath:@"contentOffset"];
    observedTableView = nil;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //make the offset amount a positive number if the offset is moving downward
    float offsetAmount =0- [[change objectForKey:@"new"] CGPointValue].y;
    if(offsetAmount>0){
      //Adjust the header views height to mach the change in the tables views offset
      self.view.frame = CGRectMake(self.view.frame.origin.x,
                                   self.view.frame.origin.y,
                                   self.view.frame.size.width,
                                   initialHeaderFrame.size.height +(offsetAmount/2));
      //Adjust the header's background to reate zooming in effect
      self.background.frame = CGRectMake(initialHeaderFrame.origin.x-(offsetAmount/2),
                                         self.background.frame.origin.y,
                                         initialHeaderFrame.size.width +(offsetAmount),
                                         initialHeaderFrame.size.height +(offsetAmount/2));;

      //resize and mask the profile pic
      [self resizeProfileBy:offsetAmount/2];
      [self setMaskTo:self.profile withRadius:offsetAmount];

    }
    
}

-(void) resizeProfileBy:(float)amount{
  self.profile.frame = CGRectMake(originalProfileFrame.origin.x-(amount/2),
                          originalProfileFrame.origin.y-(amount/2),
                          originalProfileFrame.size.width + amount,
                          originalProfileFrame.size.height + amount);
}

-(void) setMaskTo:(UIView*)view withRadius:(float)radius
{
  UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                byRoundingCorners:UIRectCornerAllCorners
                                                      cornerRadii:CGSizeMake(radius, radius)];
  
  CAShapeLayer* shape = [[CAShapeLayer alloc] init];
  [shape setPath:rounded.CGPath];
  view.layer.mask = shape;
}

@end
