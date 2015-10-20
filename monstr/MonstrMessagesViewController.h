//
//  MonstrMessagesViewController.h
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "JSQMessages.h"

#import "DemoModelData.h"
#import "NSUserDefaults+DemoSettings.h"

#import "JSQMessagesViewController.h"

#import "JSQMessagesComposerTextView.h"

#import "ProfileStack.h"

@class MonstrMessagesViewController;

@protocol JSQMonstrViewControllerDelegate <NSObject>

- (void)didDismissJSQMonstrViewController:(MonstrMessagesViewController *)vc;

@end


@interface MonstrMessagesViewController : JSQMessagesViewController <UIActionSheetDelegate>//, JSQMessagesComposerTextViewPasteDelegate>

@property (weak, nonatomic) id<JSQMonstrViewControllerDelegate> delegateModal;

@property (strong, nonatomic) DemoModelData *demoData;

@property UIImageView *messageMessage;

@property NSTimer *monsterMessageTimer;

@property BOOL youWereBlocked;

-(void) receiveMessagePressed:(UIBarButtonItem *)sender;

-(void)closePressed:(UIBarButtonItem *)sender;


@end
