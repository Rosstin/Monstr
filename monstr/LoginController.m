//
//  LoginController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LoginController.h"
#import "ProfileStack.h"
@import AVFoundation;

@implementation LoginController

- (IBAction)logIn:(id)sender {
    //NSLog(@"Logging in!");
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager generateDailyIndices];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginButton.layer.cornerRadius = 2;
    _loginButton.layer.borderWidth = 1;
    _loginButton.layer.borderColor = [UIColor colorWithRed: 0.1 green: 0.5 blue: 0.9 alpha: 0.8].CGColor;
    _loginButton.backgroundColor = [UIColor colorWithRed: 0.1 green: 0.5 blue: 0.9 alpha: 0.2 ];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager]; // force it to gen a winning profile

    _hintText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    _hintText.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:16];
    
    /*
    CGFloat fixedWidth = _hintText.frame.size.width;
    CGSize newSize = [_hintText sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _hintText.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _hintText.frame = newFrame;*/
    _hintText.scrollEnabled = NO;
    
    _memoryText.text = @"You think back to that unforgettable encounter at the bus stop...";
    _memoryText.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    
    /*
    CGFloat fixedWidth2 = _memoryText.frame.size.width;
    CGSize newSize2 = [_memoryText sizeThatFits:CGSizeMake(fixedWidth2, MAXFLOAT)];
    CGRect newFrame2 = _memoryText.frame;
    newFrame2.size = CGSizeMake(fmaxf(newSize2.width, fixedWidth2), newSize2.height);
    _memoryText.frame = newFrame2;*/
    _memoryText.scrollEnabled = NO;

    if(sharedManager.firstTime){    // if it's your first time show the intro
        //NSLog(@"It's my first time!");
        sharedManager.firstTime = NO;
        
        _rainyIntro.hidden = NO;
        
        //[self performSegueWithIdentifier:@"SegueToIntroFromLogin" sender:self];
        
        [self startFirstTimeIntro];
        
        
    }
    else{
        //NSLog(@"It's not my first time at login screen... don't show intro....");
        [self returnToRegularLoginScreen];
    }
    
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    //NSLog(@"handleTap in LoginController");
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    sharedManager.introTextIndex++;

    switch(sharedManager.introTextIndex)
    {
        case 0: //this should never happen, it's reset elsewhere
            _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 1:
            _introText.text = @"...when the bus pulls up and your whole life changes.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 2:
            _introText.text = @"The vehicle disgorges five or six hairy suburb schlubs, all boring fangs and forgettable fins.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 3:
            _introText.text = @"But the last person to step off the bus catches your eye like NO ONE ELSE EVER HAS.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 4:
            _introText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 5:
            _introText.text = @"If only you had time to stop, start a conversation, get a phone number... you work the whole day with shaking hands, trying to keep that enthralling profile in your mind. And when you get home, it's time to find that mysterious someone.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 6:
            _introText.text = @"It's time to do what all lonely, horny monsters do...";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 7:
            _introText.text = @"It's time to check Monstr.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        default:
            [self returnToRegularLoginScreen];
            break;
    }
    
    
    
}

- (void)returnToRegularLoginScreen {
    _introText.hidden = YES;
    _rainyIntro.hidden= YES;

    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startMainMusic];
}


- (void)startFirstTimeIntro {
    _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
    [_introText setFont:[UIFont boldSystemFontOfSize:18]];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startIntroMusic];
    
    _introText.hidden = NO;
    _rainyIntro.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
