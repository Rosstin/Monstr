//
//  ProfileStack.h
//  testing swiping
//

#import <Foundation/Foundation.h>
#import "Profile.h"
@import AVFoundation;

@interface ProfileStack : NSObject

@property NSMutableArray *allProfiles;

@property NSMutableArray *profileIndicesForToday;
@property NSMutableArray *excludedProfileIndices;

@property NSInteger cardsLoadedIndexGlobal;
@property NSInteger cardBeingViewedByPlayer;

@property NSInteger winningProfileIndex;

@property BOOL winner;
@property BOOL firstTime;
@property BOOL thisIsTheLastCard;
@property NSInteger introTextIndex;

@property BOOL monsterSentMessage;

@property AVAudioPlayer* mainMusicPlayer;
@property AVAudioPlayer* introMusicPlayer;

+ (id)sharedManager;

-(void)incrementCardsLoadedIndexGlobal;
-(void)generateDailyIndices;
-(void)excludeProfileByProfileWeWantUserToSeeRightNow;

-(void)startMainMusic;
-(void)startIntroMusic;


-(void)resetAll;

//-(Profile *)profileUserIsLookingAt;
-(NSUInteger)profileUserIsLookingAtIndexNumber;
-(Profile *)profileWinner;

@property NSInteger profileWeWantUserToSeeRightNow;

@end
