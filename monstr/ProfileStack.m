//
//  ProfileStack.m
//  testing swiping
//
//  Created by Rosstin Murphy on 8/25/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "ProfileStack.h"
#import "Profile.h"
#import "CHCSVParser.h"

@implementation ProfileStack

-(id)init {
    NSLog(@"Init ProfileStack");
    
    self = [super init];
    
    if(self) {
        _cardsLoadedIndexGlobal = 0;
        _cardBeingViewedByPlayer = 0;
        
        Profile *profile1 = [[Profile alloc] init];
        
        /*
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
        profile5.profileImageName = @"p_cerealkiller";*/
        
        _allProfiles = [NSMutableArray array];
        
        /*
        [_allProfiles addObject:profile1];
        [_allProfiles addObject:profile2];
        [_allProfiles addObject:profile3];
        [_allProfiles addObject:profile4];
        [_allProfiles addObject:profile5];*/
        
        NSLog(@"allProfiles... before stuff... %@", _allProfiles);
        
        _profilesForToday = [NSMutableArray array];
        
        /*
        [_profilesForToday addObject:profile1];
        [_profilesForToday addObject:profile2];
        [_profilesForToday addObject:profile3];
        [_profilesForToday addObject:profile4];
        [_profilesForToday addObject:profile5];
         */
        
         
        _profileIndicesForToday = [NSMutableArray array];
        _excludedProfileIndices = [NSMutableArray array];

        [self loadProfiles];
        //[self generateDailyIndices];

    }
    
    return self;
}

-(void)incrementCardsLoadedIndexGlobal
{
    NSLog(@"incrementing cardsLoadedIndexGlobal");
    self.cardsLoadedIndexGlobal++;
}


- (void) generateDailyIndices{
    //NSLog(@"generating some random indices");
    while(_profileIndicesForToday.count < 3){
        NSLog(@"generating indices");
        int randomNumber = arc4random_uniform(_allProfiles.count);
        bool excluded = false;
        for( NSNumber *n in _excludedProfileIndices ){
            int num = [n intValue];
            if(randomNumber == num){
                excluded = true;
            }
        }
        
        if(!excluded){
            [_profileIndicesForToday addObject:[NSNumber numberWithInt:randomNumber]];
            [_excludedProfileIndices addObject:[NSNumber numberWithInt:randomNumber]];
        }
    }
    //NSLog(@"got some indices... %@", _profileIndicesForToday);
    //NSLog(@"excluded some indices... %@", _excludedProfileIndices);
}

- (void) loadProfiles{
    
    //_allProfiles
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"profiles" ofType:@"csv"];
    
    NSError *error = nil;
    
    NSArray *rows = [NSArray arrayWithContentsOfCSVFile:path];
    
    if(rows==nil){
        //something went wrong, log error and exit
        NSLog(@"error parsing file: %@", error);
        return;
    }
    
    //NSLog(@"rows: %@", rows);
    
    for(NSArray *myProfile in rows){
        Profile *profile = [[Profile alloc] init];
        profile.profileName = myProfile[1];
        profile.profileImageName = myProfile[2];
        
        //NSLog(@"profileName... %@", myProfile[1]);
        //NSLog(@"profileImageName... %@", myProfile[2]);
        
        [_allProfiles addObject:profile];
        [_profilesForToday addObject:profile];
    }
    
    //NSLog(@"allProfiles... %@", _allProfiles);
    
    
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
