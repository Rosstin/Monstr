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

@property NSString* facebookName;

@property BOOL monsterSentMessage;

@property BOOL seguedToWin;

@property AVAudioPlayer* mainMusicPlayer;
@property AVAudioPlayer* introMusicPlayer;
@property AVAudioPlayer* victoryMusicPlayer;
@property AVAudioPlayer* titleMusicPlayer;

@property AVAudioPlayer* startSoundPlayer;
@property AVAudioPlayer* sendSoundPlayer;
@property AVAudioPlayer* receiveSoundPlayer;

+ (id)sharedManager;

-(void)incrementCardsLoadedIndexGlobal;
-(void)generateDailyIndices;
-(void)excludeProfileByProfileWeWantUserToSeeRightNow;

-(void)startMainMusic;
-(void)startIntroMusic;
-(void)startVictoryMusic;
-(void)startTitleMusic;

-(void)startSound;
-(void)sendSound;
-(void)receiveSound;

-(void)resetAll;

-(NSUInteger)profileUserIsLookingAtIndexNumber;
-(Profile *)profileWinner;

@property NSInteger profileWeWantUserToSeeRightNow;

@end
