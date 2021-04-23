//
//  CoreGraphicsBasicsAppDelegate.m
//  CoreGraphicsBasics
//
//  Created by Logictreeit5 on 13/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreGraphicsBasicsAppDelegate.h"

@implementation CoreGraphicsBasicsAppDelegate


@synthesize window=_window;
@synthesize gameImage;
@synthesize maxRows;
@synthesize maxColumns;
@synthesize intialGap;
@synthesize helpButton;
@synthesize imageSelected;
@synthesize mainMenuButton;
@synthesize frameType;
@synthesize mainNavigationController;
@synthesize headerView;
@synthesize timeElapsedInSec;
@synthesize leastTimeInSecLabel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    gameStartingViewController = [[GameStartingView alloc] init];
    mainNavigationController = [[UINavigationController alloc] initWithRootViewController:gameStartingViewController];
    mainNavigationController.navigationBar.hidden = YES;
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    headerView.backgroundColor = [UIColor clearColor];
      
    timeElapsedInSec = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    timeElapsedInSec.font = [UIFont systemFontOfSize:10.0];
    timeElapsedInSec.textColor = [UIColor whiteColor];
    [timeElapsedInSec setBackgroundColor: [UIColor clearColor]];

    [headerView addSubview:timeElapsedInSec];
      
    leastTimeInSecLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 90, 15)];
    leastTimeInSecLabel.font = [UIFont systemFontOfSize:10.0];
    leastTimeInSecLabel.textAlignment = UITextAlignmentRight;
    leastTimeInSecLabel.textColor = [UIColor whiteColor];
    [leastTimeInSecLabel setBackgroundColor: [UIColor clearColor]];
    [headerView addSubview:leastTimeInSecLabel];

    
    [self.window addSubview:headerView];
    
    
    
    
    
    
    helpButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    helpButton.frame = CGRectMake(0, 0, 100, 30);
    helpButton.center = CGPointMake(50, -15);
    [helpButton setTitle:@"Help" forState:UIControlStateNormal];
    [self.window addSubview:helpButton];
    
    mainMenuButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    mainMenuButton.frame = CGRectMake(0, 0, 100, 30);
    mainMenuButton.center = CGPointMake(250, -15);
    [mainMenuButton setTitle:@"Main Menu" forState:UIControlStateNormal];
    [self.window addSubview:mainMenuButton];

    self.window.multipleTouchEnabled = NO;
    self.window.rootViewController = mainNavigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
