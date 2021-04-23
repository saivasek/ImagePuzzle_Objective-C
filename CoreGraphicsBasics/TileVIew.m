//
//  TileVIew.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 04/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "TileVIew.h"
#import "CoreGraphicsBasicsAppDelegate.h"

@implementation TileVIew
@synthesize tileFrameView;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)presentIamge index:(int)index
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        appDelegate = (CoreGraphicsBasicsAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        tileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tileImageView.image = presentIamge;
        [self addSubview:tileImageView];
        
        tileFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if (appDelegate.frameType ==1)
        {
            tileFrameView.image = [UIImage imageNamed:@"106-120.png"];

        }
        else if (appDelegate.frameType ==2)
        {
             tileFrameView.image = [UIImage imageNamed:@"80-80.png"];
        }
        else
        {
            tileFrameView.image = [UIImage imageNamed:@"64-60.png"];
 
        }
        [self addSubview:tileFrameView];
        
        indexLabel= [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.size.height/2, 20, 20)];
        indexLabel.textAlignment = UITextAlignmentCenter;
        [indexLabel setBackgroundColor:[UIColor blackColor]];
        indexLabel.text = [NSString stringWithFormat:@"%d",index];
        indexLabel.textColor = [UIColor whiteColor];
        [self addSubview:indexLabel];
        indexLabel.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLabel) name:@"help" object:nil];
    }
    return self;
}

-(void)showLabel
{
    indexLabel.hidden = NO;
    indexLabel.alpha = 1.0;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(turnOffLabel) userInfo:nil repeats:YES];
    
}

-(void)turnOffLabel
{
//    indexLabel.hidden = YES;
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
    indexLabel.alpha = 0.0;
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"help" object:nil];
    [super dealloc];
}

@end
