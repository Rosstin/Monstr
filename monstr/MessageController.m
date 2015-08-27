//
//  MessageController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "MessageController.h"
#import "ProfileStack.h"

@implementation MessageController

- (void)viewDidLoad
{
    NSLog(@"VIEWDIDLOAD MESSAGECONTROLLER");
    [super viewDidLoad];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    _usernameField.text = sharedManager.profileUserIsLookingAt.profileName;
    
    if(sharedManager.profileUserIsLookingAt.profileName == sharedManager.profileWinner.profileName){
        NSLog(@"YOU WON! that was the profile you were looking for!!");
        sharedManager.winner = YES;
    }
}

- (IBAction)doneButtonAction:(id)sender {
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    if(sharedManager.winner){
        [self performSegueWithIdentifier:@"SegueToWinFromMessage" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"SegueToLoginFromMessage" sender:self];
    }
}

@end
