//
//  TileVIew.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 04/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreGraphicsBasicsAppDelegate;
@interface TileVIew : UIView 
{
    CoreGraphicsBasicsAppDelegate *appDelegate;
    UIImageView *tileFrameView;
    UIImageView *tileImageView;
    UILabel *indexLabel;
}
@property (nonatomic,assign) UIImageView *tileFrameView;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)presentIamge index:(int)index;
-(void)showLabel;
@end
