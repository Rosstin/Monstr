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
    
    _profileImage.image = [UIImage imageNamed:sharedManager.profileUserIsLookingAt.profileImageName];
    _profileText.text = sharedManager.profileUserIsLookingAt.profileText;
}

@end
