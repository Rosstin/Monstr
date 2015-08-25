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


@interface ViewController ()
@end

@implementation ViewController


- (void)tapped:(UIView *)card {
    [self performSegueWithIdentifier:@"SegueToProfile" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];
    
    draggableBackground.delegate = self;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self performSegueWithIdentifier:@"test" sender:self];
}

- (void)doSegue
{
    NSLog(@"doSegue");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    /*
    if ([[segue identifier] isEqualToString:@"SegueToProfile"])
    {
        NSLog(@"if ([[segue identifier] isEqualToString:@SegueToProfile])");
    }
    */
}


@end
