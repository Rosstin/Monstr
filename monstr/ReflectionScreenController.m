//
//  ReflectionScreenController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Rosstin. All rights reserved.
//

#import "ReflectionScreenController.h"
#import "ProfileStack.h"

@implementation ReflectionScreenController

- (void) viewDidLoad{
    ProfileStack *sharedManager = [ProfileStack sharedManager]; // force it to gen a winning profile
    
    _hintText.text = [sharedManager.profileWinner.profileHint stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    _hintText.font = [UIFont italicSystemFontOfSize:17.0];
     
    _hintText.scrollEnabled = NO;

}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSLog(@"handleTap");
    [self performSegueWithIdentifier:@"SegueToLoginFromReflection" sender:self];
        //NSLog(@"handleTap in LoginController");
        //ProfileStack *sharedManager = [ProfileStack sharedManager];
        //sharedManager.introTextIndex++;
        /*
        switch(sharedManager.reflectionTextIndex)
        {
            case 0: //this should never happen, it's reset elsewhere
                _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
                [_introText setFont:[UIFont boldSystemFontOfSize:18]];
                break;
            case 1:
                _introText.text = @"...when the bus pulls up and your whole life changes.";
                [_introText setFont:[UIFont boldSystemFontOfSize:18]];
                break;
            case 7:
                _introText.text = @"It's time to check Monstr.";
                [_introText setFont:[UIFont boldSystemFontOfSize:18]];
                break;
            case 8:
                [self returnToRegularLoginScreen];
                break;
            default:
                // do nothing
                break;
        }
         */
}

@end
