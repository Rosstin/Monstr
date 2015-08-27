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
#import "Config.h"

@implementation ProfileStack

-(id)init {
    NSLog(@"Init ProfileStack");
    
    self = [super init];
    
    if(self) {
        _cardsLoadedIndexGlobal = 0;
        _cardBeingViewedByPlayer = 0;
        
        _winner = NO;
        
        _allProfiles = [NSMutableArray array];
        
        _profileIndicesForToday = [NSMutableArray array];
        _excludedProfileIndices = [NSMutableArray array];

        [self loadProfiles];
        [self generateWinningProfile];
        //[self generateDailyIndices]; //this is done thru login button now
    }
    
    return self;
}

-(void)incrementCardsLoadedIndexGlobal
{
    //NSLog(@"incrementing cardsLoadedIndexGlobal");
    self.cardsLoadedIndexGlobal++;
}

- (void) excludeCurrentProfile{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];

    [_excludedProfileIndices addObject:allProfilesIndex];
    
    NSLog(@"Permantly excluded the file at index... %@...", allProfilesIndex);
}

- (void) generateWinningProfile{
    int randomNumber = arc4random_uniform(_allProfiles.count);
    self.winningProfileIndex = randomNumber;
    NSLog(@"generateWinningProfile... ONLY DO THIS ONCE... %ld... ", (long)self.winningProfileIndex);
}

- (void) generateDailyIndices{
    //NSLog(@"generating some random indices");
    [_profileIndicesForToday removeAllObjects];
    
    NSMutableArray *excludedRightNow = [NSMutableArray array];
    
    while(_profileIndicesForToday.count < NUMBER_OF_PROFILES_PER_DAY){
        //NSLog(@"generating indices");
        int randomNumber = arc4random_uniform(_allProfiles.count);
        
        bool exclude = false;
        
        // check if this profile was excluded permanently
        for( NSNumber *n in _excludedProfileIndices ){
            int num = [n intValue];
            if(randomNumber == num){
                exclude = true;
            }
        }
        
        // check if this profile was excluded for this cycle
        for (NSNumber *n in excludedRightNow){
            int num = [n intValue];
            if(randomNumber == num){
                exclude = true;
            }
        }
        
        // not excluded this cycle, OR permanantly, so we can add it
        if(!exclude){
            [_profileIndicesForToday addObject:[NSNumber numberWithInt:randomNumber]];
            [excludedRightNow addObject:[NSNumber numberWithInt:randomNumber]];
        }
    }
}

- (Profile *) profileUserIsLookingAt{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];
    NSUInteger allProfilesIndexNSU = allProfilesIndex.integerValue;
    
    return [_allProfiles objectAtIndex: allProfilesIndexNSU ];
}

- (Profile *) profileWinner{
    return [_allProfiles objectAtIndex: _winningProfileIndex ];
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
        profile.profileText = myProfile[4];

        profile.profileHint = myProfile[5];

        
        [_allProfiles addObject:profile];
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
