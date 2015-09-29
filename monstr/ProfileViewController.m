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
    
    self.navigationItem.hidesBackButton = YES;
    
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    _profileImage.image = [UIImage imageNamed:sharedManager.profileUserIsLookingAt.profileImageName];
    
    NSString *trimmedDesc = [sharedManager.profileUserIsLookingAt.profileDescriptors stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];

    _profileDescription.text = trimmedDesc;
    
    NSString *trimmedText = [sharedManager.profileUserIsLookingAt.profileText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];

    _profileText.text = trimmedText;
    
    _profileName.text = sharedManager.profileUserIsLookingAt.profileName;
    
    CGRect frame = _viewContainingContent.frame;
    frame.size.height = 50;
    _viewContainingContent.frame = frame;
    
    //_viewContainingContent.backgroundColor = [UIColor redColor];
    
    //CGRect viewBounds = _viewContainingContent.bounds;
    //viewBounds.size.height = 50;
    //_viewContainingContent.bounds = viewBounds;
    
    //[_viewContainingContent layoutIfNeeded];
    
    
    //[_viewContainingContent setNeedsDisplay];
    //[_scrollviewContainingView setNeedsDisplay];
    
    //_viewContainingContent.hidden = YES;
    
    
    //_viewContainingContent.bounds

    //CGRect newFrame = CGRectMake(_viewContainingContent.frame.origin.x, _viewContainingContent.frame.origin.y, _viewContainingContent.frame.size.width, 300);

    //[_viewContainingContent setFrame: newFrame];
    
    //[self displ]
    
    
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
    [sharedManager excludeCurrentProfile];
    
    [self performSegueWithIdentifier:@"SegueToMessageFromProfile" sender:self];

}


@end
