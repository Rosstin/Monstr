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

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSLog(@"handleTap");
    [self performSegueWithIdentifier:@"SegueToLoginFromReflection" sender:self];
}

@end
