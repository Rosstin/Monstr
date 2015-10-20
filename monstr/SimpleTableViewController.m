//
//  SimpleTableViewController
//  Monstr
//
//  Created by Rosstin Murphy on 8/28/15.
//  Copyright (c) 2015 Rosstin. All rights reserved.
//

#import "SimpleTableViewController.h"
#import "ProfileStack.h"

@implementation SimpleTableViewController
{
    NSArray *tableData;
}

- (void) viewDidLoad{
    [super viewDidLoad];

    //UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    //backView.backgroundColor = [UIColor clearColor];
    //cell.backgroundView = backView;
    
    UIColor *borderAndTextColor = [UIColor colorWithRed: 0.5 green: 0.1 blue: 0.5 alpha: 0.9];
    UIColor *backgroundColor = [UIColor colorWithRed: 0.1 green: 0.7 blue: 0.9 alpha: 0.19 ];
    
    tableData = [NSArray arrayWithObjects:
       @"This time, Plus Ultra was...",
       @"",
       @"~LAURA MICHET~",
       @"@lmichet",
       @"writing, concept",
       @"http://lauramichet.com/",
                 @"",
       @"~KENT SUTHERLAND~",
       @"@kentsutherland",
       @"writing",
       @"http://www.kentsuther.land/",
                 @"",
       @"~ROSSTIN MURPHY~",
       @"@rosstinmurphy",
       @"writing, programming",
       @"http://rosstinmurphy.com/",
                 @"",
       @"~RACHEL SALA~",
       @"@rachel_sala",
       @"profile pics",
       @"http://rachelsala.com",
                 @"",
       @"~MEAGAN TROTT~",
       @"@meagantrott",
       @"profile pics, logo, backgrounds",
       @"http://meagantrott.com/",
                 @"",
       @"~EMILY SO~",
       @"@bemirry",
       @"profile pics",
       @"http://emilyso.com/",
                 @"",
       @"~TRAVIS FORD DECASTRO~",
       @"music and sound",
       nil
       ];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 12;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
        
    return cell;
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSLog(@"handleTap");
    [self performSegueWithIdentifier:@"SegueToLoginFromCredits" sender:self];
    //NSLog(@"handleTap in LoginController");
    //ProfileStack *sharedManager = [ProfileStack sharedManager];
    //sharedManager.introTextIndex++;
    /*
     switch(sharedManager.reflectionTextIndex)
     {
     case 0: //this should never happen, it's reset elsewhere
     _introText.text = @"Ugh... Late for work again! You're huddled under your umbrella at the bus stop, trying to keep your tentacles out of the rain, trying not to think about what your boss will say...";
     [_introText setFont:[UIFont boldSystemFontOfSize:18]];
     break;
     case 1:
     _introText.text = @"...when the bus pulls up and your whole life changes.";
     [_introText setFont:[UIFont boldSystemFontOfSize:18]];
     break;
     case 7:
     _introText.text = @"It's time to check Monstr.";
     [_introText setFont:[UIFont boldSystemFontOfSize:18]];
     break;
     case 8:
     [self returnToRegularLoginScreen];
     break;
     default:
     // do nothing
     break;
     }
     */
}

@end
