//
//  ProfileViewController.h
//  SFProfileHeader
//
//  Created by Simon Fortelny on 4/6/13.
//  Copyright (c) 2013 Simon Fortelny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIImageView *background;
@property (nonatomic,strong) IBOutlet UIImageView *profile;

//You must use this initlizer for the class to workj correctly
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil backgroundImageNamed:(NSString *)backgroundImage profileImageNamed:(NSString *)profileImage;

-(void)tableToObserve:(UITableView *)table;


@end
