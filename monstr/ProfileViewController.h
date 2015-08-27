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

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *profileText;

@end


