//
//  SelectTileViewController.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 03/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDrawingClass.h"

@class CoreGraphicsBasicsAppDelegate;
@interface SelectTileViewController : UIViewController 
{
    CoreGraphicsBasicsAppDelegate *appDelegate;
    MyDrawingClass *myDrawingClass;
    BOOL tileTypeSelected;
    IBOutlet UIImageView *showImage;

}
-(IBAction)tile3X4ButtonSelected:(id)sender;
-(IBAction)tile4X6ButtonSelected:(id)sender;
-(IBAction)tile5X8ButtonSelected:(id)sender;
-(void)tileIsSelected;
@end
