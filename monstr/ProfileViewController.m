//  ProfileViewController.m

#import "ProfileViewController.h"
#import "DraggableViewBackground.h"
#import "ProfileStack.h"
#import "Profile.h"

@interface ProfileViewController ()
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    NSLog(@"VIEWDIDLOAD PROFILEVIEWCONTROLLER");
    [super viewDidLoad];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    Profile *currentProfile = [sharedManager.profilesForToday objectAtIndex:sharedManager.cardBeingViewedByPlayer];
    
    _profileImage.image = [UIImage imageNamed:currentProfile.profileImageName];
    
    //DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    //[self.view addSubview:draggableBackground];
}

/*
- (instancetype)init
{
    NSLog(@"init");
    self = [super init];
    if (self) {
        _profileImage.image = [UIImage imageNamed:@"p_tradvamp"];
    }
    return self;
}*/

@end
