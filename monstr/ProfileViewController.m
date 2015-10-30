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

    /*
    if(sharedManager.thisIsTheLastCard){
        self.navigationItem.hidesBackButton = YES;
    }
     */
    
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

- (void) viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) addNavigationBarItem
{
    UIBarButtonItem *messageBtn = [[UIBarButtonItem alloc] initWithTitle: @"Message" style: UIBarButtonItemStyleDone target: self action:@selector(messageButtonClicked:)];

    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithTitle: @"Share" style: UIBarButtonItemStylePlain target: self action:@selector(shareButtonClicked:)];

    //UIBarButtonItem *emptyBtn = [[UIBarButtonItem alloc] initWithTitle: @"         " style: UIBarButtonItemStylePlain target: self action:@selector(emptyButtonClicked:)];

    
    //[self.navigationItem setRightBarButtonItem:messageBtn];
    
    //NSArray<UIBarButtonItem *> *array = [messageBtn, shareBtn];
    
    NSArray * array = [NSArray arrayWithObjects:messageBtn, shareBtn, nil];
    
    [self.navigationItem setRightBarButtonItems: array];

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



-(IBAction)shareButtonClicked:(id)sender{
    NSLog(@"Share button clicked!!!");
    ProfileStack *sharedManager = [ProfileStack sharedManager];
    
    [sharedManager startSound];
    
    UIImage* screenshot = [self getScreenshot];
    
        //TODO FIND OUT HOW TO SHARE ON TWITTER
    
    /* send mail code from swift
     
     let mailComposeViewController = configuredMailComposeViewController()
     if MFMailComposeViewController.canSendMail() {
     self.presentViewController(mailComposeViewController, animated: true, completion: nil)
     } else {
     self.showSendMailErrorAlert()
     }
     
     */
}


-(UIImage*)getScreenshot{
    
    CALayer *layer = [UIApplication sharedApplication].keyWindow.layer;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow drawViewHierarchyInRect:layer.frame afterScreenUpdates:true];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(screenshot,nil,nil,nil);
    
    return screenshot;
}


/*
func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    mailComposerVC.setSubject("IBM RedRock")
    mailComposerVC.addAttachmentData(UIImageJPEGRepresentation(getScreenShot(), 1)!, mimeType: "image/jpeg", fileName: "IBMSparkInsightScreenShot.jpeg")
    return mailComposerVC
}

func getScreenShot() -> UIImage {
    let layer = UIApplication.sharedApplication().keyWindow!.layer
    let scale = UIScreen.mainScreen().scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    UIApplication.sharedApplication().keyWindow?.drawViewHierarchyInRect(layer.frame, afterScreenUpdates: true)
    
    let screenshot = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    
    return screenshot
}

func showSendMailErrorAlert() {
    let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
    sendMailErrorAlert.show()
}

func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
}

*/

-(IBAction)emptyButtonClicked:(id)sender{
}





@end
