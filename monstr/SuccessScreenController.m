//
//  SuccessScreenController.m
//  Monstr
//
//  Created by Rosstin Murphy on 10/19/15.
//  Copyright © 2015 Rosstin Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SuccessScreenController.h"
#import "ProfileStack.h"
#import "Config.h"

@implementation SuccessScreenController : UIViewController

- (void) viewDidLoad{
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager resetAll];
    sharedManager.firstTime = true;

    UIColor *borderAndTextColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.9];
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
    NSLog(@"startOver");
    [self performSegueWithIdentifier:@"SegueToTitleFromSuccess" sender:self];
}

@end
