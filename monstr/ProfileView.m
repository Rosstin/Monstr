//
//  ProfileView.m
//  testing swiping
//
//  Created by Richard Kim on 5/22/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#import "ProfileView.h"

@implementation ProfileView
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p_cerealkiller"]];
        [self addSubview:imageView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(0, 0, 290, 290);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
