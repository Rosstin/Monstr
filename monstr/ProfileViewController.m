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
    
    [self addNavigationBarItem];
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];

    if(sharedManager.thisIsTheLastCard){
        self.navigationItem.hidesBackButton = YES;
    }
    

    
    Profile *profileToShow = [sharedManager.allProfiles objectAtIndex: sharedManager.profileWeWantUserToSeeRightNow ];
    
    _profileImage.image = [UIImage imageNamed:profileToShow.profileImageName];
    
    NSString *trimmedDesc = [profileToShow.profileDescriptors stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];

    _profileDescription.text = trimmedDesc;
    
    NSString *trimmedText = [profileToShow.profileText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];

    _profileText.text = trimmedText;
    
    _profileName.text = profileToShow.profileName;
    
    CGRect frame = _viewContainingContent.frame;
    frame.size.height = 50;
    _viewContainingContent.frame = frame;
}

-(void) addNavigationBarItem
{
    UIBarButtonItem *messageBtn = [[UIBarButtonItem alloc] initWithTitle: @"Message" style: UIBarButtonItemStyleBordered target: self action:@selector(messageButtonClicked:)];

    [self.navigationItem setRightBarButtonItem:messageBtn];
}

-(IBAction)messageButtonClicked:(id)sender{
    NSLog(@"Message this user!! And remove them permanently from pool.");
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    //since they were accepted, remove them permanently from the pool
    //TODO fix exclusion
    [sharedManager excludeProfileByProfileWeWantUserToSeeRightNow];
    
    [self performSegueWithIdentifier:@"SegueToMessageFromProfile" sender:self];

}


@end
