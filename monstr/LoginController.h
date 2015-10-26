//
//  LoginController.h
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *tappingArrow;

@property (weak, nonatomic) IBOutlet UIImageView *rainyIntro;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginWithButton;

- (IBAction)handleTap:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UITextView *introText;

@property (strong, nonatomic) NSTimer *arrowBlinkTimer;

@end
