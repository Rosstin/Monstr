//
//  WinScreenController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "WinScreenController.h"
#import "ProfileStack.h"

@implementation WinScreenController

- (IBAction)startOver:(id)sender {
    NSLog(@"start over!");
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager resetAll];
    [self performSegueWithIdentifier:@"SegueToTitleFromWin" sender:self];
}

@end
