//
//  ProfileStack.h
//  testing swiping
//

#import <Foundation/Foundation.h>
#import "Profile.h"

@interface ProfileStack : NSObject

@property NSMutableArray *allProfiles;
@property NSMutableArray *profilesForToday;

@property NSMutableArray *profileIndicesForToday;
@property NSMutableArray *excludedProfileIndices;

@property NSInteger cardsLoadedIndexGlobal;
@property NSInteger cardBeingViewedByPlayer;


+ (id)sharedManager;

-(void)incrementCardsLoadedIndexGlobal;

-(Profile *)profileUserIsLookingAt;

@end
