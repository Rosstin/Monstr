//
//  DraggableViewBackground.m
//  testing swiping
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "DraggableViewBackground.h"
#import "ProfileStack.h"
#import "Profile.h"

@implementation DraggableViewBackground{
    //NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last //handled globally now
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@synthesize delegate;

@synthesize todayCards;

//@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        
        //exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
        
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        
        ProfileStack *sharedManager = [ProfileStack sharedManager];
        sharedManager.cardsLoadedIndexGlobal = 0;
        sharedManager.cardBeingViewedByPlayer = 0;
        
        [self loadCards];
    }
    
    return self;
}

-(void) tapDetected{
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startSound];
    
    self.outtaLikesWindow.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"mm1.png"],
                                         [UIImage imageNamed:@"mm2.png"],
                                         [UIImage imageNamed:@"mm1.png"],
                                         [UIImage imageNamed:@"mm3.png"], nil];
    self.outtaLikesWindow.animationRepeatCount = 0;
    NSTimeInterval interval = 0.1;
    self.outtaLikesWindow.animationDuration = interval;
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(stopAnimating)
                                   userInfo:nil
                                    repeats:NO];
    
    [self.outtaLikesWindow startAnimating];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected2)];
    singleTap.numberOfTapsRequired = 1;
    [self.outtaLikesWindow setUserInteractionEnabled:YES];
    [self.outtaLikesWindow addGestureRecognizer:singleTap];
}

-(void) stopAnimating{
    NSLog(@"stopAnimating");
    
    [self.outtaLikesWindow.layer removeAllAnimations];
    self.outtaLikesWindow.image = [UIImage imageNamed:@"p1.png"];
    
    //self.outtaLikesWindow.frame = [[self.outtaLikesWindow.layer presentationLayer] frame];
}

-(void) tapDetected2{
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    [sharedManager startSound];

    [self returnToTitle];
}

//%%% sets up the extra buttons on the screen
-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors

    //UIImage *image = [UIImage imageNamed:@"l1"];
    int width = 1048.0/3.9;
    int height = 1197.0/3.9;
    
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-width/2,self.center.y-height/2,width,height)];
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"ll1.png"],
                                         [UIImage imageNamed:@"ll2.png"],
                                         [UIImage imageNamed:@"ll3.png"],
                                         [UIImage imageNamed:@"ll2.png"], nil];
    animatedImageView.animationRepeatCount = 0;
    NSTimeInterval interval = 5.0;
    animatedImageView.animationDuration = interval;
    [animatedImageView startAnimating];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [animatedImageView setUserInteractionEnabled:YES];
    [animatedImageView addGestureRecognizer:singleTap];
    
    [self addSubview:animatedImageView];

    self.outtaLikesWindow = animatedImageView;
    
    //TODO CHANGE THE VIEW IMAGE HERE
    
    // dont put all those buttons
    
    //menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, 22, 15)];
    //[menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    //messageButton = [[UIButton alloc]initWithFrame:CGRectMake(284, 34, 18, 18)];
    //[messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    //xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 485, 59, 59)];
    //[xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    //[xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    //checkButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 485, 59, 59)];
    //[checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    //[checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:menuButton];
    //[self addSubview:messageButton];
    //[self addSubview:xButton];
    //[self addSubview:checkButton];
}

//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    
    
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];

    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    NSNumber *indexOfThisProfile = [sharedManager.profileIndicesForToday objectAtIndex:index];
    
    Profile *profileBeingLoadedRightNow = [sharedManager.allProfiles objectAtIndex:indexOfThisProfile.intValue];
    
    draggableView.information.text = profileBeingLoadedRightNow.profileName;

    draggableView.delegate = self;
    
    draggableView.profileView.imageView.image = [UIImage imageNamed:profileBeingLoadedRightNow.profileImageName];
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    if([sharedManager.profileIndicesForToday count] > 0) {
        NSInteger numLoadedCardsCap =(([sharedManager.profileIndicesForToday count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[sharedManager.profileIndicesForToday count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[sharedManager.profileIndicesForToday count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            
            ProfileStack *sharedManager = [ProfileStack sharedManager];
            [sharedManager incrementCardsLoadedIndexGlobal];
        }
    }
}

//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    sharedManager.cardBeingViewedByPlayer++; // we always increment this regardless
    
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (sharedManager.cardsLoadedIndexGlobal < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex: sharedManager.cardsLoadedIndexGlobal]];
        [sharedManager incrementCardsLoadedIndexGlobal];
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    else if(sharedManager.cardsLoadedIndexGlobal == [allCards count]) {
        //NSLog(@"LAST CARD!");
        [sharedManager incrementCardsLoadedIndexGlobal];
    }
    else{
        NSLog(@"LAST CARD SWIPED!");
        //[self returnToTitle];
    }
}

//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{

    NSLog(@"the user accepted the profile, and now we GO TO THEIR PROFILE instead of directly messaging them");
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    sharedManager.thisIsTheLastCard = FALSE;
 
    sharedManager.profileWeWantUserToSeeRightNow = sharedManager.profileUserIsLookingAtIndexNumber;
    
    sharedManager.cardBeingViewedByPlayer++; // we always increment this regardless //don't increment because we chose to look at the card so we're stuck there now
    
    //since they were accepted, remove them permanently from the pool
        
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (sharedManager.cardsLoadedIndexGlobal < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex: sharedManager.cardsLoadedIndexGlobal ]];
        [sharedManager incrementCardsLoadedIndexGlobal];
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    else if(sharedManager.cardsLoadedIndexGlobal == [allCards count]) {
        //NSLog(@"LAST CARD!");
        [sharedManager incrementCardsLoadedIndexGlobal];
    }
    // since you accepted, we're messaging them anyway
    else{
        sharedManager.thisIsTheLastCard = TRUE;
    //    //NSLog(@"LAST CARD SWIPED!");
    //    [self returnToTitle];
    }
    
    [delegate rightSwiped:self];


}

-(void)returnToTitle 
{
    [delegate returnToTitle:self];
}

-(void)messageUser
{
    [delegate messageUser:self];
}

-(void)cardTapped:(UIView *)card
{
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    sharedManager.profileWeWantUserToSeeRightNow = sharedManager.profileUserIsLookingAtIndexNumber;
    
    sharedManager.thisIsTheLastCard = FALSE;
    
    [delegate tapped:self];
    
    // now to pass info to the card
    
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
