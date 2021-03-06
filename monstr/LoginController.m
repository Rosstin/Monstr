//
//  LoginController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LoginController.h"
#import "ProfileStack.h"
#import "Config.h"
@import AVFoundation;

@implementation LoginController

- (IBAction)logIn:(id)sender {
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startSound];
    [sharedManager startMainMusic];
    [sharedManager generateDailyIndices];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIColor *borderAndTextColor = [UIColor colorWithRed: 0.5 green: 0.1 blue: 0.5 alpha: 0.9];
    UIColor *backgroundColor = [UIColor colorWithRed: 0.1 green: 0.7 blue: 0.9 alpha: 0.19 ];
    
    _loginButton.layer.cornerRadius = STANDARD_BUTTON_CORNER_RADIUS;
    _loginButton.layer.borderWidth = 2;
    _loginButton.layer.borderColor = borderAndTextColor.CGColor;
    _loginButton.backgroundColor = backgroundColor;
    [_loginButton setTitleColor: borderAndTextColor forState:UIControlStateNormal];
    
    _loginWithButton.layer.cornerRadius = STANDARD_BUTTON_CORNER_RADIUS;
    _loginWithButton.layer.borderWidth = 2;
    _loginWithButton.layer.borderColor = borderAndTextColor.CGColor;
    _loginWithButton.backgroundColor = backgroundColor;
    [_loginWithButton setTitleColor: borderAndTextColor forState:UIControlStateNormal];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager]; // force it to gen a winning profile

    /*
    _hintText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    _hintText.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:16];
    */
    /*
    CGFloat fixedWidth = _hintText.frame.size.width;
    CGSize newSize = [_hintText sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _hintText.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _hintText.frame = newFrame;*/
    //_hintText.scrollEnabled = NO;
    
    //_memoryText.text = @"You think back to that unforgettable encounter at the bus stop...";
    //_memoryText.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    //_memoryText.scrollEnabled = NO;

    if(sharedManager.firstTime){   // if it's your first time show the intro
        sharedManager.firstTime = NO;
        
        [self startFirstTimeIntro];
    }
    else{ //NSLog(@"It's not my first time at login screen... don't show intro....");
        [self returnToRegularLoginScreen];
    }
    
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    sharedManager.introTextIndex++;
    
    [sharedManager sendSound];
    
    [self textFade];
    
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
            _introText.text = @" The vehicle disgorges five or six hairy suburb schlubs, all boring fangs and forgettable fins. But the last person to step off the bus catches your eye like NO ONE ELSE EVER HAS...";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 3:
            _introText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            //[self lightningFlash];
            break;
        case 4:
            _introText.text = @"If only you had time to stop, start a conversation, get a phone number... you work the whole day with shaking hands, trying to keep that enthralling profile in your mind. And when you get home, it's time to find that mysterious someone.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 5:
            _introText.text = @"It's time to do what all lonely, horny monsters do... It's time to check Monstr.";
            [_introText setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        case 6:
            [self returnToRegularLoginScreen];
            break;
        default:
            // do nothing
            break;
    }
    
}

- (void) startBlinkArrowTimer {
    _arrowBlinkTimer = [NSTimer scheduledTimerWithTimeInterval: TIMER_BLINK_IN_SECONDS target:self selector:@selector(tickBlinkArrow) userInfo:nil repeats:YES];
}

- (void) stopBlinkArrowTimer {
    [self invalidateBlinkArrowTimer];
}

- (void) invalidateBlinkArrowTimer{
    [_arrowBlinkTimer invalidate];
    _arrowBlinkTimer = nil;
}

- (void)tickBlinkArrow {
    [_tappingArrow setHidden:(!_tappingArrow.hidden)];
}

- (void)textFade{
    [_introText setAlpha:0.0f];
    
    [UIView animateWithDuration: TEXT_FADE_IN_SECONDS delay: 0.0f options: UIViewAnimationOptionCurveEaseIn animations:^{ [_introText setAlpha:1.f];
    } completion:^(BOOL finished){
    }];
}

- (void) textFadePlusShake {
    [_introText setAlpha:0.0f];
    
    [UIView animateWithDuration: TEXT_FADE_IN_SECONDS/2 delay: 0.0f options: UIViewAnimationOptionCurveEaseIn animations:^{ [_introText setAlpha:1.f];
    } completion:^(BOOL finished){
        [self textShake];
    }];
}

- (void)textShake{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.03];
    [animation setRepeatCount:8];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([_introText center].x - 1.0f, [_introText center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake([_introText center].x + 1.0f, [_introText center].y)]];
    [[_introText layer] addAnimation:animation forKey:@"position"];
}

- (void) lightningFlash{
    [_rainyIntro setAlpha:0.0f];
    
    [UIView animateWithDuration: LIGHTNING_FLASH_IN_SECONDS delay: 0.0f options: UIViewAnimationOptionCurveEaseIn animations:^{ [_rainyIntro setAlpha:1.f];
    } completion:^(BOOL finished){
    }];
}


- (void) hideIntroStuff {
    _introText.hidden = YES;
    _rainyIntro.hidden= YES;
    _tappingArrow.hidden = YES;
    _whiteBackground.hidden = YES;
    [self stopBlinkArrowTimer];
}

- (void) showIntroStuff {
    _introText.hidden = NO;
    _rainyIntro.hidden= NO;
    _tappingArrow.hidden = NO;
    _whiteBackground.hidden = NO;
    [self startBlinkArrowTimer];
}

- (void)returnToRegularLoginScreen {
    [self hideIntroStuff];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startTitleMusic];
}


- (void)startFirstTimeIntro {
    _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
    [_introText setFont:[UIFont boldSystemFontOfSize:18]];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startIntroMusic];
    
    [self showIntroStuff];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
