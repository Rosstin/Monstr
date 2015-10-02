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

    
    //THE MAIN MUSIC PLAYER
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"sfx/main" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    self.mainMusicPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];

    //THE INTRO MUSIC PLAYER
    NSString *filePath2 = [mainBundle pathForResource:@"sfx/rain" ofType:@"mp3"];
    NSData *fileData2 = [NSData dataWithContentsOfFile:filePath2];
    self.introMusicPlayer = [[AVAudioPlayer alloc] initWithData:fileData2 error:&error];
    
    self = [super init];
    
    if(self) {
        [self resetAll];
    }
    _firstTime = YES;
    
    return self;
}

-(void) resetAll{
    _cardsLoadedIndexGlobal = 0;
    _cardBeingViewedByPlayer = 0;
    
    _winner = NO;
    _firstTime = NO;
    _introTextIndex = 0;
    
    _profileIndicesForToday = [NSMutableArray array];
    _excludedProfileIndices = [NSMutableArray array];
    
    [self loadProfiles];
    [self generateWinningProfile];
    //[self generateDailyIndices]; //this is done thru login button now
}



-(void) startMainMusic{
    //[self.mainMusicPlayer stop];
    [self.introMusicPlayer stop];
    
    [self.mainMusicPlayer prepareToPlay];
    [self.mainMusicPlayer play];
}

-(void) startIntroMusic{
    [self.mainMusicPlayer stop];
    //[self.introMusicPlayer stop];
    
    [self.introMusicPlayer prepareToPlay];
    [self.introMusicPlayer play];
}


-(void)incrementCardsLoadedIndexGlobal
{
    //NSLog(@"incrementing cardsLoadedIndexGlobal");
    self.cardsLoadedIndexGlobal++;
}

/*
- (void) excludeCurrentProfile{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];

    [_excludedProfileIndices addObject:allProfilesIndex];
    
    NSLog(@"Permantly excluded the file at index... %@...", allProfilesIndex);
}
 */

- (void) excludeProfileByProfileWeWantUserToSeeRightNow{
    
    NSNumber *myNum = [NSNumber numberWithInteger:self.profileWeWantUserToSeeRightNow];
    [_excludedProfileIndices addObject: myNum];
    
    NSLog(@"Permantly excluded the file at index... %@...", myNum);
}


- (void) generateWinningProfile{
    int randomNumber = arc4random_uniform(_allProfiles.count);
    self.winningProfileIndex = randomNumber;
    //NSLog(@"generateWinningProfile... ONLY DO THIS ONCE... %ld... ", (long)self.winningProfileIndex);
}

- (void) generateDailyIndices{
    //NSLog(@"generating some random indices");
    [_profileIndicesForToday removeAllObjects];
    
    NSMutableArray *excludedRightNow = [NSMutableArray array];
    
    int count = 0;
    
    while(_profileIndicesForToday.count < NUMBER_OF_PROFILES_PER_DAY && count < 100){
        count++;
        
        //NSLog(@"generating indices... %d", count);
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
    if(count >= 100){
        NSLog(@"WARNING! NOT ENOUGH PROFILES! Reloading profiles and resetting excluded profiles.");
        [self loadProfiles];
        _excludedProfileIndices = [NSMutableArray array];
        [self generateDailyIndices];
    }
}

/*
- (Profile *) profileUserIsLookingAt{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];
    NSUInteger allProfilesIndexNSU = allProfilesIndex.integerValue;
    
    return [_allProfiles objectAtIndex: allProfilesIndexNSU ];
}
 */

- (NSUInteger) profileUserIsLookingAtIndexNumber{
    NSUInteger myCardNumber = _cardBeingViewedByPlayer;
    NSNumber *allProfilesIndex = [_profileIndicesForToday objectAtIndex:myCardNumber];
    NSUInteger allProfilesIndexNSU = allProfilesIndex.integerValue;
    
    return allProfilesIndexNSU;
}


- (Profile *) profileWinner{
    return [_allProfiles objectAtIndex: _winningProfileIndex ];
}

- (void) loadProfiles{
    
    _allProfiles = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"profiles3" ofType:@"csv"];
    
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
        profile.profileDescriptors = myProfile[3];
        profile.profileText = myProfile[4];
        profile.profileHint = myProfile[5];
        profile.badMessage = myProfile[6];
        profile.goodMessage = myProfile[7];
        
        NSLog(@"profilename... %@", profile.profileName);
        
        [_allProfiles addObject:profile];
    }
    
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
