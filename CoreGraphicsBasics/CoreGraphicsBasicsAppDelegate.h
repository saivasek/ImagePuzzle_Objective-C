//
//  CoreGraphicsBasicsAppDelegate.h
//  CoreGraphicsBasics
//
//  Created by Logictreeit5 on 13/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameStartingView.h"
@interface CoreGraphicsBasicsAppDelegate : NSObject <UIApplicationDelegate>

{
    UINavigationController *mainNavigationController;
    GameStartingView *gameStartingViewController;
    UIImage *gameImage;
    int maxRows;
    int maxColumns;
    int intialGap;
    int frameType;
    BOOL imageSelected;
    
    ///////Help button
    UIButton *helpButton;
    UIButton *mainMenuButton;
    
    /////////Header view 
    
    UIView *headerView;
    UILabel *timeElapsedInSec;
    UILabel *leastTimeInSecLabel;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) UIImage *gameImage;
@property(nonatomic,assign)UIButton *helpButton;
@property(nonatomic,assign)UIButton *mainMenuButton;
@property int maxRows;
@property int maxColumns;
@property int intialGap;
@property  BOOL imageSelected;
@property int frameType;
@property(nonatomic,assign)UINavigationController *mainNavigationController;
/////////Header view 
@property(nonatomic,assign)UIView *headerView;
@property(nonatomic,assign)UILabel *timeElapsedInSec;
@property(nonatomic,assign)UILabel *leastTimeInSecLabel;

@end
