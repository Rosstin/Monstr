//
//  ReflectionScreenController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Rosstin. All rights reserved.
//

#import "ReflectionScreenController.h"
#import "ProfileStack.h"
#import "Config.h"

@implementation ReflectionScreenController

- (void) viewDidLoad{
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    _hintText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    _hintText.font = [UIFont italicSystemFontOfSize:17.0];
     
    _hintText.scrollEnabled = NO;
    
    [self startBlinkArrowTimer];

}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSLog(@"handleTap");
    
    [self performSegueWithIdentifier:@"SegueToLoginFromReflection" sender:self];
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

@end
