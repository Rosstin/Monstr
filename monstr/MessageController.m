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
}

@end
