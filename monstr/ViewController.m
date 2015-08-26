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
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    Profile *currentProfile = [sharedManager.profilesForToday objectAtIndex: *(sharedManager.cardsLoadedIndexGlobal)];
    
    [self performSegueWithIdentifier:@"SegueToProfile" sender:self];
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
        //NSLog(@"not hiding nav bar");
        //NSLog(@"if ([[segue identifier] isEqualToString:@SegueToProfile])");
        [self.navigationController setNavigationBarHidden:NO];
    }
    else{
        //NSLog(@"NOT not hiding nav bar");
    }
}


@end
