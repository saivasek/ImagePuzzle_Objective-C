//
//  MyDrawingClass.h
//  CoreGraphicsBasics
//
//  Created by Logictreeit5 on 13/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TileVIew.h"
@class TileVIew;

typedef enum playerDirections
{
    direction_left = 0,
    direction_right,
    direction_up,
    direction_down,
    
}playerDirections;

@class CoreGraphicsBasicsAppDelegate;
@interface MyDrawingClass : UIView <UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    /////image rectangles
    CGImageRef cgImageRef;

    ////////////CGImages
    CGImageRef image;
        
    /////////UIImages
    UIImage *uiImage;
        
    NSMutableArray *centersArray;
    NSMutableArray *emptyCenterArray;
    NSMutableArray *referenceArray;
    NSMutableArray *tilesArray;
    NSMutableArray *rectanglesArray;
    playerDirections currentDirection;
    CGPoint startPoint;
    CGPoint endPoint;
    float angle;
    int firstIndexValueFromStorsArray;
    NSMutableArray *storeArray;
    ///////////Rearranging centers
    NSString *tmpIndexString;
    int tmpIndex;
    NSString *reArrangeCenterStr ;
    CGPoint reArrangeCenterPoint ;
    
    ///////// Reference values
    int touchesBeganBlock;
    int currentBlock;
    int proposedBlock;
    int prospectiveBlock;
    CGPoint currentCenter;
    
    int maxRows,maxColumns;
    TileVIew *currentSelectedImageView;

    BOOL canChangePosition;
    NSString *tmpCenterValue ;
    
    CGPoint startingPoint;
    CGPoint endingPoint;
    CGPoint beganPoint;
    CGPoint movingPoint;
    CGPoint previousPoint;
    float distanceTravelled;
    float distanceRequired;
    BOOL canMove;
    
    /////////// distnace variables
    float previousX;
    float previousY;
    float presentX;
    float presentY;
    int presentDirection;
    int pastDirection;
    int blockingDistanceByWidth;
    int blockingDistanceByHeight;
    
    ///////////////////////
    CoreGraphicsBasicsAppDelegate *appDelegate;
    int intialGap;
    ////////For Showing help and menu option
    BOOL isMoved; 
    NSDate *startTime;
    NSDate *endTime;
    NSTimeInterval time;
    int timePassed;
    /////////////
    UIView *gameQuitView;
    BOOL quitGame;
    BOOL canPlayGame;
    //////
    int playingTime;
    NSTimer *gameTimer;
    BOOL bestScoreAchieved;
    
    ////////////////////
    CGPoint   pbp1;
    NSTimer *touchTimer;
    
    int emptyCenterValue;
    BOOL firstTouch;
    
    ///////////////
    UIImageView *totalImage;
    UIView *gameWinview;
    UIView *gameExitView ;
    UIView *scoreSavingView;
    NSString *playerName;
    BOOL playerNameEntered;
    UIAlertView *gameCompleteAlert;
    UITextField *playerNameTextField;
    
}
-(void)createRandomNumbers;
-(void)createUIImages;
-(void)reArrangeTheImages;
-(void)moveImage;
-(void)setTheImageInChangedPosition;
-(void)calculateDistance;
-(void)gameCompleteMethod;
-(void)showTheHelpAndMenuOptions:(NSTimer *)aTimer;
-(void)hideTheHelpAndMenuOptions;
-(void)yesOrNoIsSelected:(UIButton *)selectedButton;
-(void)quitGame;
-(void)storeBestScore;
-(void)gameCompleteAnimation;
-(void)showExitScreen;
-(void)allScoresSavingMethod;
-(void)yesButtonClicked;
-(void)noButtonClicked;
//////////Direction changed method
-(BOOL)directionChangedMethod;
-(playerDirections)getDirections;
-(BOOL)canMoveOrNot;

@end
