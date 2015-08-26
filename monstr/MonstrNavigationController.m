//
//  MonstrNavigationController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "MonstrNavigationController.h"
#import "ProfileView.h"

@interface MonstrNavigationController ()

@end

@implementation MonstrNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"MonstrNavigationController viewDidLoad");
    
    self.navigationBar.translucent = NO;
    
    //self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"wahahahahahaha"]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
