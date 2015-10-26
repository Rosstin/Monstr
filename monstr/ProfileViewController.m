//  ProfileViewController.m

#import "ProfileViewController.h"
#import "DraggableViewBackground.h"
#import "ProfileStack.h"
#import "Profile.h"
#import "Config.h"

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
    
    UIColor *borderAndTextColor = [UIColor colorWithRed: 0.5 green: 0.1 blue: 0.5 alpha: 0.9];
    UIColor *backgroundColor = [UIColor colorWithRed: 0.1 green: 0.7 blue: 0.9 alpha: 0.05 ];
    
    _messageUserButton.layer.cornerRadius = STANDARD_BUTTON_CORNER_RADIUS;
    _messageUserButton.layer.borderWidth = 2;
    _messageUserButton.layer.borderColor = borderAndTextColor.CGColor;
    _messageUserButton.backgroundColor = backgroundColor;
    [_messageUserButton setTitleColor: borderAndTextColor forState:UIControlStateNormal];
    
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
    
    [sharedManager startSound];
    
    //since they were accepted, remove them permanently from the pool
    //TODO fix exclusion
    [sharedManager excludeProfileByProfileWeWantUserToSeeRightNow];
    
    [self performSegueWithIdentifier:@"SegueToMessageFromProfile" sender:self];

}


@end
