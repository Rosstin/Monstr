//
//  ProfileStack.h
//  testing swiping
//
//  Created by Rosstin Murphy on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileStack : NSObject

@property NSMutableSet *allProfiles;
@property NSMutableArray *profilesForToday;

@property int *cardsLoadedIndexGlobal;

+ (id)sharedManager;

@end
