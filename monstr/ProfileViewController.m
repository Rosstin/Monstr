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
    
    _profileImage.image = [UIImage imageNamed:sharedManager.profileUserIsLookingAt.profileImageName];
    _profileText.text = sharedManager.profileUserIsLookingAt.profileText;
}

-(void) addNavigationBarItem
{
    UIBarButtonItem *messageBtn = [[UIBarButtonItem alloc] initWithTitle: @"Message" style: UIBarButtonItemStyleBordered target: self action:@selector(messageButtonClicked:)];

    [self.navigationItem setRightBarButtonItem:messageBtn];
}

-(IBAction)messageButtonClicked:(id)sender{
    NSLog(@"Message this user!!");
}


@end
