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
    NSLog(@"Logging in!");
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager generateDailyIndices];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager]; // force it to gen a winning profile

    _hintText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    
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
    [self.backgroundMusicPlayer stop];
}


- (void)startFirstTimeIntro {
    _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
    [_introText setFont:[UIFont boldSystemFontOfSize:18]];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"sfx/rain" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
    
    [self.backgroundMusicPlayer prepareToPlay];
    
    [self.backgroundMusicPlayer play];
    
    _introText.hidden = NO;
    _rainyIntro.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
