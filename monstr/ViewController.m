//
//  ViewController.m
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#import "ViewController.h"
#import "DraggableViewBackground.h"
#import "Profile.h"
#import "ProfileStack.h"

@interface ViewController ()
@end

@implementation ViewController


- (void)tapped:(UIView *)card {
    //SOME LOGIC HERE-- we can set the profile the player is looking at or something here, somehow get that info to the next view
    
    [self performSegueWithIdentifier:@"SegueToProfile" sender:self];
}

- (void)rightSwiped:(UIView *)card {
    //SOME LOGIC HERE-- we can set the profile the player is looking at or something here, somehow get that info to the next view
    
    [self performSegueWithIdentifier:@"SegueToProfileWithRightSwipe" sender:self];
}


- (void)returnToTitle:(UIView *)card {
    //TODO SEGUE TO REFLECTION SCREEN INSTEAD
    [self performSegueWithIdentifier:@"SegueToReflection" sender:self];
}

- (void)messageUser:(UIView *)card {
    [self performSegueWithIdentifier:@"SegueToMessage" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];
    
    draggableBackground.delegate = self;
}

//- (void)viewDidAppear:(BOOL)animated
//{}

//- (void) viewWillDisappear:(BOOL)animated
//{ NSLog(@"disappearing...");}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SegueToProfile"])
    {
        NSLog(@"SegueToProfile");
        [self.navigationController setNavigationBarHidden:NO];

    }
    else if ([[segue identifier] isEqualToString:@"SegueToProfileWithRightSwipe"])
    {
        NSLog(@"SegueToProfileWithRightSwipe");
        [self.navigationController setNavigationBarHidden:NO];
    }
    else{
        //NSLog(@"NOT not hiding nav bar");
    }
}


@end
