//
//  WinScreenController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "WinScreenController.h"
#import "ProfileStack.h"
#import "Config.h"

@implementation WinScreenController

- (void)viewDidLoad {
    [super viewDidLoad];

    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager resetAll];
    sharedManager.firstTime = true;
    
    UIColor *borderAndTextColor = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 0.9];
    UIColor *backgroundColor = [UIColor colorWithRed: 0.1 green: 0.7 blue: 0.9 alpha: 0.19 ];
    
    _creditsButton.layer.cornerRadius = STANDARD_BUTTON_CORNER_RADIUS;
    _creditsButton.layer.borderWidth = 2;
    _creditsButton.layer.borderColor = borderAndTextColor.CGColor;
    _creditsButton.backgroundColor = backgroundColor;
    [_creditsButton setTitleColor: borderAndTextColor forState:UIControlStateNormal];
    
    _startOverButton.layer.cornerRadius = STANDARD_BUTTON_CORNER_RADIUS;
    _startOverButton.layer.borderWidth = 2;
    _startOverButton.layer.borderColor = borderAndTextColor.CGColor;
    _startOverButton.backgroundColor = backgroundColor;
    [_startOverButton setTitleColor: borderAndTextColor forState:UIControlStateNormal];
}


- (IBAction)startOver:(id)sender {
    //NSLog(@"start over!");
    [self performSegueWithIdentifier:@"SegueToTitleFromWin" sender:self];
}


@end
