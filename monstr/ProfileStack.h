//
//  ProfileStack.h
//  testing swiping
//
//  Created by Rosstin Murphy on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
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
