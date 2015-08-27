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

- (void) generateWinningProfile{
    int randomNumber = arc4random_uniform(_allProfiles.count);
    self.winningProfileIndex = randomNumber;
    NSLog(@"generateWinningProfile... ONLY DO THIS ONCE... %ld... ", (long)self.winningProfileIndex);
}

- (void) generateDailyIndices{
    //NSLog(@"generating some random indices");
    [_profileIndicesForToday removeAllObjects];
    
    while(_profileIndicesForToday.count < NUMBER_OF_PROFILES_PER_DAY){
        //NSLog(@"generating indices");
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
}

- (Profile *) profileUserIsLookingAt{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];
    NSUInteger allProfilesIndexNSU = allProfilesIndex.integerValue;
    
    //NSLog(@"_cardBeingViewedByPlayer.. %lu",(unsigned long)myCardNumber);
    //NSLog(@"allProfilesIndex.. %@",allProfilesIndex);
    //NSLog(@"allProfilesIndexNSU.. %lu",(unsigned long)allProfilesIndexNSU);
    
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
