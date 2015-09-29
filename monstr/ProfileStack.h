//
//  ProfileStack.h
//  testing swiping
//

#import <Foundation/Foundation.h>
#import "Profile.h"

@interface ProfileStack : NSObject

@property NSMutableArray *allProfiles;

@property NSMutableArray *profileIndicesForToday;
@property NSMutableArray *excludedProfileIndices;

@property NSInteger cardsLoadedIndexGlobal;
@property NSInteger cardBeingViewedByPlayer;

@property NSInteger winningProfileIndex;

@property BOOL winner;
@property BOOL firstTime;
@property NSInteger introTextIndex;

+ (id)sharedManager;

-(void)incrementCardsLoadedIndexGlobal;
-(void)generateDailyIndices;
-(void)excludeCurrentProfile;

-(void)resetAll;

-(Profile *)profileUserIsLookingAt;
-(Profile *)profileWinner;

@end
