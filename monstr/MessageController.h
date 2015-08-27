//
//  MessageController.h
//  Monstr
//
//  Created by Rosstin Murphy on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameField;
- (IBAction)doneButtonAction:(id)sender;

@end
