//  ProfileViewController.m

#import "ProfileViewController.h"
#import "DraggableViewBackground.h"


@interface ProfileViewController ()
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    //_profileImage.image = [UIImage imageNamed:@"p_tradvamp"];
    
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
