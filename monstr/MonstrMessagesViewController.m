//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "MonstrMessagesViewController.h"

@implementation MonstrMessagesViewController

#pragma mark - View lifecycle

- (void) respondToTapGesture{
    NSLog(@"respondToTapGesture");
    [self hideMessageMessage];
}

- (void) hideMessageMessage{
    [UIView animateWithDuration:0.5 delay:0.1 options:0 animations:^{
        self.messageMessage.alpha = 0.0f;
    } completion:^(BOOL finished){
        self.messageMessage.hidden = YES;
        [self sendPlayerMessage];
    }];
}

/**
 *  Override point for customization.
 *
 *  Customize your view.
 *  Look at the properties on `JSQMessagesViewController` and `JSQMessagesCollectionView` to see what is possible.
 *
 *  Customize your layout.
 *  Look at the properties on `JSQMessagesCollectionViewFlowLayout` to see what is possible.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _youWereBlocked = NO;

    
    self.title = @"JSQMessages";
    
    int width = 2048.0/9.6;
    int height = 1676.0/9.6;
    
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(self.view.center.x-width/2),self.view.center.y-height/2,width,height)];
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"t1.png"],
                                         [UIImage imageNamed:@"t2.png"],
                                         [UIImage imageNamed:@"t1.png"],
                                         [UIImage imageNamed:@"t3.png"], nil];
    animatedImageView.animationRepeatCount = 0;
    NSTimeInterval interval = 5.0;
    animatedImageView.animationDuration = interval;
    [animatedImageView startAnimating];
    animatedImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    animatedImageView.layer.shadowOffset = CGSizeMake(1, 1);
    animatedImageView.layer.shadowOpacity = 0.2;
    animatedImageView.layer.shadowRadius = 3.0;
    animatedImageView.clipsToBounds = NO;
    
    [self.view addSubview:animatedImageView];
    
    self.messageMessage = animatedImageView;
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    Profile *myCurrentProfile = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];
    sharedManager.monsterSentMessage = TRUE;
    
    if(myCurrentProfile.profileName == sharedManager.profileWinner.profileName){
        NSLog(@"YOU WON! that was the profile you were looking for!!");
        sharedManager.winner = YES;
        [sharedManager startVictoryMusic];
    }
    
    SEL aSelector = @selector(respondToTapGesture);
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:aSelector];

    tapRecognizer.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    /**
     *  You MUST set your senderId and display name
     */
    self.senderId = kJSQDemoAvatarIdSquires;
    self.senderDisplayName = selfName;
    
    //self.inputToolbar.contentView.textView.pasteDelegate = self;
    
    /**
     *  Load up our fake data for the demo
     */
    self.demoData = [[DemoModelData alloc] init];
        
    
    /**
     *  You can set custom avatar sizes
     */
    if (![NSUserDefaults incomingAvatarSetting]) {
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero; //CGSizeMake(15,15);
    }
    
    if (![NSUserDefaults outgoingAvatarSetting]) {
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero; //CGSizeMake(15,15);
    }
    
    self.showLoadEarlierMessagesHeader = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage jsq_defaultTypingIndicatorImage]
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];
    
    /**
     *  Register custom menu actions for cells.
     */
    //[JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    //[UIMenuController sharedMenuController].menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Custom Action"
    //                                                                                  action:@selector(customAction:)] ];
    
    /**
     *  OPT-IN: allow cells to be deleted
     */
    //[JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
    /**
     *  Customize your toolbar buttons
     *
     *  self.inputToolbar.contentView.leftBarButtonItem = custom button or nil to remove
     *  self.inputToolbar.contentView.rightBarButtonItem = custom button or nil to remove
     */
    
    
    //DONT SHOW TOOLBAR
    self.inputToolbar.hidden = YES;
    
    /**
     *  Set a maximum height for the input toolbar
     *
     *  self.inputToolbar.maximumHeight = 150;
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.delegateModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(closePressed:)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /**
     *  Enable/disable springy bubbles, default is NO.
     *  You must set this from `viewDidAppear:`
     *  Note: this feature is mostly stable, but still experimental
     */
    self.collectionView.collectionViewLayout.springinessEnabled = [NSUserDefaults springinessSetting];
}



#pragma mark - Testing

- (void)pushMainViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:nc.topViewController animated:YES];
}


#pragma mark - Actions

- (void)receiveMessagePressed:(UIBarButtonItem *)sender
{
    NSLog(@"receiveMessagePressed");
    
    /**
     *  DEMO ONLY
     *
     *  The following is simply to simulate received messages for the demo.
     *  Do not actually do this.
     */
    
    
    /**
     *  Show the typing indicator to be shown
     */
    self.showTypingIndicator = !self.showTypingIndicator;
    
    /**
     *  Scroll to actually view the indicator
     */
    [self scrollToBottomAnimated:YES];
    
    /**
     *  Copy last sent message, this will be the new "received" message
     */
    JSQMessage *copyMessage = [[self.demoData.messages lastObject] copy];
    
    if (!copyMessage) {
        copyMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdJobs
                                          displayName:kJSQDemoAvatarDisplayNameJobs
                                                 text:@"First received!"];
    }
    
    /**
     *  Allow typing indicator to show
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *userIds = [[self.demoData.users allKeys] mutableCopy];
        [userIds removeObject:self.senderId];
        NSString *randomUserId = userIds[arc4random_uniform((int)[userIds count])];
        
        JSQMessage *newMessage = nil;
        id<JSQMessageMediaData> newMediaData = nil;
        id newMediaAttachmentCopy = nil;
        
        if (copyMessage.isMediaMessage) {
            /**
             *  Last message was a media message
             */
            id<JSQMessageMediaData> copyMediaData = copyMessage.media;
            
            if ([copyMediaData isKindOfClass:[JSQPhotoMediaItem class]]) {
                JSQPhotoMediaItem *photoItemCopy = [((JSQPhotoMediaItem *)copyMediaData) copy];
                photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [UIImage imageWithCGImage:photoItemCopy.image.CGImage];
                
                /**
                 *  Set image to nil to simulate "downloading" the image
                 *  and show the placeholder view
                 */
                photoItemCopy.image = nil;
                
                newMediaData = photoItemCopy;
            }
            else if ([copyMediaData isKindOfClass:[JSQLocationMediaItem class]]) {
                JSQLocationMediaItem *locationItemCopy = [((JSQLocationMediaItem *)copyMediaData) copy];
                locationItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [locationItemCopy.location copy];
                
                /**
                 *  Set location to nil to simulate "downloading" the location data
                 */
                locationItemCopy.location = nil;
                
                newMediaData = locationItemCopy;
            }
            else if ([copyMediaData isKindOfClass:[JSQVideoMediaItem class]]) {
                JSQVideoMediaItem *videoItemCopy = [((JSQVideoMediaItem *)copyMediaData) copy];
                videoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [videoItemCopy.fileURL copy];
                
                /**
                 *  Reset video item to simulate "downloading" the video
                 */
                videoItemCopy.fileURL = nil;
                videoItemCopy.isReadyToPlay = NO;
                
                newMediaData = videoItemCopy;
            }
            else {
                NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
            }
            
            newMessage = [JSQMessage messageWithSenderId:randomUserId
                                             displayName:self.demoData.users[randomUserId]
                                                   media:newMediaData];
        }
        else {
            /**
             *  Last message was a text message
             */
            newMessage = [JSQMessage messageWithSenderId:randomUserId
                                             displayName:self.demoData.users[randomUserId]
                                                    text:copyMessage.text];
        }
        
        /**
         *  Upon receiving a message, you should:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self.demoData.messages addObject:newMessage];
        [self finishReceivingMessageAnimated:YES];
        
        
        if (newMessage.isMediaMessage) {
            /**
             *  Simulate "downloading" media
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                /**
                 *  Media is "finished downloading", re-display visible cells
                 *
                 *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                 *
                 *  Reload the specific item, or simply call `reloadData`
                 */
                
                if ([newMediaData isKindOfClass:[JSQPhotoMediaItem class]]) {
                    ((JSQPhotoMediaItem *)newMediaData).image = newMediaAttachmentCopy;
                    [self.collectionView reloadData];
                }
                else if ([newMediaData isKindOfClass:[JSQLocationMediaItem class]]) {
                    [((JSQLocationMediaItem *)newMediaData)setLocation:newMediaAttachmentCopy withCompletionHandler:^{
                        [self.collectionView reloadData];
                    }];
                }
                else if ([newMediaData isKindOfClass:[JSQVideoMediaItem class]]) {
                    ((JSQVideoMediaItem *)newMediaData).fileURL = newMediaAttachmentCopy;
                    ((JSQVideoMediaItem *)newMediaData).isReadyToPlay = YES;
                    [self.collectionView reloadData];
                }
                else {
                    NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                }
                
            });
        }
        
    });
}

/*
- (void)closePressed:(UIBarButtonItem *)sender
{
    [self.delegateModal didDismissJSQDemoViewController:self];
}
 */




#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    NSLog(@"didPressSendButton");
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    
    [self sendPlayerMessage];
}



- (BOOL) nextMessageIsPlayerMessage{
    NSString *currentResponse = self.getCurrentResponse;
    
    if(currentResponse.length >= 2){
        currentResponse=[currentResponse substringToIndex:1];
    }
    else{
        NSLog(@"BAD DATA in this message!!");
        return true;
    }
    
    if([currentResponse isEqual: @"}"]){
        return true;
    }
    else{
        return false;
    }
}

- (BOOL) nextMessageIsMonsterMessage{
    NSString *currentResponse = self.getCurrentResponse;
    
    if(currentResponse.length >= 2){
        currentResponse=[currentResponse substringToIndex:1];
    }
    else{
        NSLog(@"BAD DATA in this message!!");
        return true;
    }
    
    
    if([currentResponse isEqual: @"{"]){
        return true;
    }
    else{
        return false;
    }
}




- (NSString *) getCurrentResponse{
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    Profile *myCurrentProfile = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];
    NSString *response;
    if(sharedManager.winner){
        response = myCurrentProfile.goodMessage;
    }
    else{
        response = myCurrentProfile.badMessage;
    }
    
    NSArray *responsesArray = [response componentsSeparatedByString:@"\n"];
    //NSLog(@"number of lines in array... %lu ", (unsigned long)responsesArray.count);
    NSString *currentResponse = [responsesArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    
    return currentResponse;
}

- (NSString *) getCurrentResponseAndRemoveTopResponse{
    
    NSString *currentResponse = self.getCurrentResponse;
    [self removeTopResponse];
    return currentResponse;
}

- (void) removeTopResponse{
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    Profile *myCurrentProfile = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];
    NSString *response;
    if(sharedManager.winner){
        response = myCurrentProfile.goodMessage;
    }
    else{
        response = myCurrentProfile.badMessage;
    }
    
    NSArray *responsesArray = [response componentsSeparatedByString:@"\n"];
    //NSLog(@"number of lines in array... %lu ", (unsigned long)responsesArray.count);
    NSString *textLessFirstLine = @"";
    NSUInteger count = [responsesArray count];
    if(responsesArray.count > 1){
        for(int i = 1; i < count; i++) { //don't re-add the first element
            if( (i+1) == count ){
                textLessFirstLine = [textLessFirstLine stringByAppendingString: responsesArray[i] ]; //don't append newline to last element
            }
            else{
                textLessFirstLine = [textLessFirstLine stringByAppendingString: [responsesArray[i] stringByAppendingString:@"\n"] ];
            }
        }
    } else {
        textLessFirstLine = @"......";
    }
    
    //REMOVES THE TOP RESPONSE
    if(sharedManager.winner){
        myCurrentProfile.goodMessage = textLessFirstLine;
    }
    else{
        myCurrentProfile.badMessage = textLessFirstLine;
    }
}

- (void) sendMonsterMessage{

    float r = arc4random_uniform(200);
    float time = 100 + r;
    time = time/100;
    
    // set a timer for sending a message back
    _monsterMessageTimer = [NSTimer scheduledTimerWithTimeInterval: time
                                     target:self
                                   selector:@selector(messageResponse:)
                                   userInfo:nil
                                    repeats:NO];
    
}

- (void)done:(NSTimer *)timer{
    [self doneFunction];
}

- (void) doneFunction{
    NSLog(@"doneFunction");
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    if(sharedManager.winner && !sharedManager.seguedToWin){
        NSLog(@"if(sharedManager.winner && !sharedManager.seguedToWin){");
        sharedManager.seguedToWin = YES;
        [self performSegueWithIdentifier:@"SegueToSuccessFromMessage" sender:self];
    }
    else{
        //TODO SEGUE right back to profiles
        ProfileStack *sharedManager = [ProfileStack sharedManager];
        [sharedManager generateDailyIndices];

        [self performSegueWithIdentifier:@"SegueToNavFromMessage" sender:self];
        
        //[self performSegueWithIdentifier:@"SegueToReflectionFromMessage" sender:self];

    }
}

-(void) sendPlayerMessage{
    
    [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    if(sharedManager.monsterSentMessage){
        
        NSString *currentResponse = self.getCurrentResponseAndRemoveTopResponse; //gets the thing that the player will say
        
        if ([currentResponse hasPrefix:@"}"] && [currentResponse length] > 1) {
            currentResponse = [currentResponse substringFromIndex:1];
        }
        
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:@"053496-4509-289"
                                                 senderDisplayName:@"Me"
                                                              date:[NSDate date]
                                                              text:currentResponse];
        
        [self.demoData.messages addObject:message];
        [self finishSendingMessageAnimated:YES];
        
        // YOU MUST REPEAT *IF* YOU FIND THE PLAYER CHARACTER }
        if(self.nextMessageIsPlayerMessage){
            //repeat this function
            float r = arc4random_uniform(100);
            float time = 100 + r;
            time = time/100;
            
            // set a timer for sending a message back
            [NSTimer scheduledTimerWithTimeInterval: time
                                             target:self
                                           selector:@selector(sendPlayerMessageAfterTimer:)
                                           userInfo:nil
                                            repeats:NO];
            
            
            // REPEAT AFTER A SHORT TIME!!! DON'T DO IT INSTANTLY! MAKE IT SHORT THOUGH
        }
        else{
            sharedManager.monsterSentMessage = FALSE;
            [self sendMonsterMessage];
        }
    }
    else{
        NSLog(@"monster hasnt sent their message yet... force it!");
        //TODO!!!! FORCE MESSAGE!!
        
        //cancel timer message
        [_monsterMessageTimer invalidate];
        [self monsterMessageFunction];
    }
}

- (void)sendPlayerMessageAfterTimer:(NSTimer *)timer{
    [self sendPlayerMessage];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"alertView.... buttonIndex is %ld", (long)buttonIndex);
    if (buttonIndex == 0) {
        [self doneFunction];
    }
}

- (void)messageResponse:(NSTimer *)timer{
    [self monsterMessageFunction];
}

- (void)monsterMessageFunction{
    [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    Profile *myCurrentProfile = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];
    NSString *response;
    if(sharedManager.winner){
        response = myCurrentProfile.goodMessage;
    }
    else{
        response = myCurrentProfile.badMessage;
    }
    
    if([response isEqualToString: @"......"] && !sharedManager.winner && (_youWereBlocked == NO)){
        NSLog(@"So-and-so has blocked you.");
        
        _youWereBlocked = YES;
        
        NSString *blockMessage = @"";
        
        blockMessage = [blockMessage stringByAppendingString:myCurrentProfile.profileName];
        blockMessage = [blockMessage stringByAppendingString:@" has blocked you."];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:blockMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"                                                                           otherButtonTitles:nil];
        alert.cancelButtonIndex = -1;
        
        [alert show];
        
        /*
        float r = arc4random_uniform(100);
        float time = 50 + r;
        time = time/100;
        
        // set a timer for being done
        [NSTimer scheduledTimerWithTimeInterval: time
                                         target:self
                                       selector:@selector(done:)
                                       userInfo:nil
                                        repeats:NO];*/
    }
    else if([response isEqualToString: @"......"]){
        
        float r = arc4random_uniform(100);
        float time = 50 + r;
        time = time/100;
        
        // set a timer for being done
        [NSTimer scheduledTimerWithTimeInterval: time
                                         target:self
                                       selector:@selector(done:)
                                       userInfo:nil
                                        repeats:NO];
        
    } else{
        NSString *currentResponse = self.getCurrentResponseAndRemoveTopResponse; //gets the thing that the player will say

        Profile *myCurrentProfile = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];

        if ([currentResponse hasPrefix:@"{"] && [currentResponse length] > 1) {
            currentResponse = [currentResponse substringFromIndex:1];
        }
        
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:dateId
                                                 senderDisplayName:myCurrentProfile.profileName
                                                              date:[NSDate date]
                                                              text:currentResponse];
        
        [self.demoData.messages addObject:message];
        [self finishSendingMessageAnimated:YES];
        
        // YOU MUST REPEAT *IF* YOU FIND THE MONSTER CHARACTER {
        // REPEAT AFTER A SHORT TIME!!! DON'T DO IT INSTANTLY! MAKE IT SHORT THOUGH
        if(self.nextMessageIsMonsterMessage){
            [self sendMonsterMessage];
        }
        else{
            sharedManager.monsterSentMessage = TRUE;
        }
    }
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Media messages"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Send photo", @"Send location", @"Send video", nil];
    
    [sheet showFromToolbar:self.inputToolbar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            [self.demoData addPhotoMediaMessage];
            break;
            
        case 1:
        {
            __weak UICollectionView *weakView = self.collectionView;
            
            [self.demoData addLocationMediaMessageCompletion:^{
                [weakView reloadData];
            }];
        }
            break;
            
        case 2:
            [self.demoData addVideoMediaMessage];
            break;
    }
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    [self finishSendingMessageAnimated:YES];
}



#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.demoData.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.demoData.messages removeObjectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     *
     *  Otherwise, return your previously created bubble image data objects.
     */
    
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.demoData.outgoingBubbleImageData;
    }
    
    return self.demoData.incomingBubbleImageData;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want avatars.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
     *
     *  It is possible to have only outgoing avatars or only incoming avatars, too.
     */
    
    /**
     *  Return your previously created avatar image data objects.
     *
     *  Note: these the avatars will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        if (![NSUserDefaults outgoingAvatarSetting]) {
            return nil;
        }
    }
    else {
        if (![NSUserDefaults incomingAvatarSetting]) {
            return nil;
        }
    }
    
    
    return [self.demoData.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.demoData.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.demoData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.demoData.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *msg = [self.demoData.messages objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage) {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}



#pragma mark - UICollectionView Delegate

#pragma mark - Custom menu items

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        return YES;
    }
    
    return [super collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        [self customAction:sender];
        return;
    }
    
    [super collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)customAction:(id)sender
{
    NSLog(@"Custom action received! Sender: %@", sender);
    
    [[[UIAlertView alloc] initWithTitle:@"Custom Action"
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil]
     show];
}



#pragma mark - JSQMessages collection view flow layout delegate

#pragma mark - Adjusting cell label heights

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.demoData.messages objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.demoData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
    [self sendPlayerMessage];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped avatar!");
    [self sendPlayerMessage];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped message bubble!");
    [self sendPlayerMessage];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
    [self sendPlayerMessage];
}

#pragma mark - JSQMessagesComposerTextViewPasteDelegate methods


- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender
{
    if ([UIPasteboard generalPasteboard].image) {
        // If there's an image in the pasteboard, construct a media item with that image and `send` it.
        JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [self.demoData.messages addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

@end
