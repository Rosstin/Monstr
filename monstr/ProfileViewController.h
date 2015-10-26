//  ProfileViewController.h
//
//  Created by Rosstin.
//  Copyright (c) 2015 Rosstin.

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
{
    UIButton *messageButton;
}

-(void) addNavigationBarItem;

@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileDescription;
@property (weak, nonatomic) IBOutlet UILabel *profileText;
@property (weak, nonatomic) IBOutlet UIView *viewContainingContent;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewContainingView;

@property (weak, nonatomic) IBOutlet UIButton *messageUserButton;

@end


