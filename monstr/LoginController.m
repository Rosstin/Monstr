//
//  LoginController.m
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "LoginController.h"
#import "ProfileStack.h"

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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
