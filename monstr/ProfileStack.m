//
//  ProfileStack.m
//  testing swiping
//
//  Created by Rosstin Murphy on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "ProfileStack.h"
#import "Profile.h"

@implementation ProfileStack

-(id)init {
    NSLog(@"Init");
    
    _cardsLoadedIndexGlobal = 0;
    
    Profile *profile1 = [[Profile alloc] init];
    profile1.profileName = @"XxCEREALKILLERxX";
    profile1.profileImageName = @"p_cerealkiller";
    Profile *profile2 = [[Profile alloc] init];
    profile2.profileName = @"oldsoul";
    profile2.profileImageName = @"p_tradvamp";
    Profile *profile3 = [[Profile alloc] init];
    profile3.profileName = @"XxCEREALKILLERxX";
    profile3.profileImageName = @"p_cerealkiller";
    Profile *profile4 = [[Profile alloc] init];
    profile4.profileName = @"oldsoul";
    profile4.profileImageName = @"p_tradvamp";
    Profile *profile5 = [[Profile alloc] init];
    profile5.profileName = @"XxCEREALKILLERxX";
    profile5.profileImageName = @"p_cerealkiller";
    
    _allProfiles = [NSMutableSet set];
    [_allProfiles addObject:profile1];
    [_allProfiles addObject:profile2];
    [_allProfiles addObject:profile3];
    [_allProfiles addObject:profile4];
    [_allProfiles addObject:profile5];
    
    _profilesForToday = [NSMutableArray array];
    [_profilesForToday addObject:profile1];
    [_profilesForToday addObject:profile2];
    [_profilesForToday addObject:profile3];
    [_profilesForToday addObject:profile4];
    [_profilesForToday addObject:profile5];
    
    return self;
}

+ (id)sharedManager{
    static ProfileStack *sharedProfileStack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProfileStack = [[self alloc] init];
    });
    return sharedProfileStack;
    
}

@end
