//
//  MyDrawingClass.m
//  CoreGraphicsBasics
//
//  Created by Logictreeit5 on 13/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyDrawingClass.h"
#import "CoreGraphicsBasicsAppDelegate.h"
#import "TileVIew.h"

@implementation MyDrawingClass
#define  BLOCKWIDTH 106
#define  BLOCKHEIGHT 120
- (NSString *)dataFilePathForBestTime 
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"bestTime.plist"];
    //[paths release];
}

- (NSString *)dataFilePathForAllScores
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"allScores.plist"];
    //[paths release];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        //self.multipleTouchEnabled = NO;
        firstTouch = YES;
        appDelegate = (CoreGraphicsBasicsAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.headerView.hidden = NO;
        intialGap = appDelegate.intialGap;
        quitGame = NO;
        playingTime = 0;
        isMoved = NO;
        canPlayGame = YES;
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increseTime) userInfo:nil repeats:YES];
        NSString *s = [self dataFilePathForBestTime];
        if ([[NSFileManager defaultManager] fileExistsAtPath:s]) 
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:s];
            NSString *tmpBestTime = @"Record Time : ";
            tmpBestTime = [tmpBestTime stringByAppendingString:[dic objectForKey:@"BestTime"]];
            appDelegate.leastTimeInSecLabel.text = tmpBestTime;
            [dic release];
        }
        else
        {
            NSString *tmpBestTime  = @"No record";
            appDelegate.leastTimeInSecLabel.text = tmpBestTime;

        }

        // Initialization code
        tilesArray = [[NSMutableArray alloc] initWithCapacity:0];
        rectanglesArray = [[NSMutableArray alloc] initWithCapacity:0];
        emptyCenterArray = [[NSMutableArray alloc] initWithCapacity:0];
              
        maxRows = appDelegate.maxRows;
        maxColumns=appDelegate.maxColumns;
      
        self.backgroundColor = [UIColor whiteColor];
        //UIImage *gameImage = [UIImage imageNamed:@"gameImage.png"];
        //cgImageRef = gameImage.CGImage;
        cgImageRef = appDelegate.gameImage.CGImage;
        centersArray = [[NSMutableArray alloc] initWithCapacity:0];

       
        [self createUIImages];  
       
        
    }
    return self;
}


-(void)createUIImages
{
    
   [self createRandomNumbers];

    float rectWidth = 320/(maxColumns);
    float rectHeight = 480/(maxRows);
    blockingDistanceByWidth = rectWidth;
    blockingDistanceByHeight = rectHeight;
    float xPos=0;
    float yPos=0;
    int tmpMaxRows = 0;
    int tmpMaxColumns = 0;
    
    for (int i=0; i<maxColumns*maxRows; i++)
    {
        xPos = (rectWidth) * tmpMaxColumns;
        yPos = rectHeight *tmpMaxRows;
        
        CGRect tmpRect = CGRectMake(xPos+intialGap, yPos, rectWidth, rectHeight);
        CGImageRef tmpCGImage  = CGImageCreateWithImageInRect(cgImageRef,tmpRect);
        UIImage *tmpImage = [UIImage imageWithCGImage:tmpCGImage];
        if (i<maxColumns*maxRows-1)
        {
         
        TileVIew *tileView = [[TileVIew alloc] initWithFrame:tmpRect image:tmpImage index:i];
        tileView.tag = i;
        [tilesArray addObject:tileView];
        CGPoint tc = tileView.center;
        NSString *tcStr = NSStringFromCGPoint(tc);
        [centersArray addObject:tcStr];
        [emptyCenterArray addObject:@"1"];

        }
        else
        {
        TileVIew *tileView = [[TileVIew alloc] initWithFrame:tmpRect image:nil index:i];
        tileView.tag = i;
        CGPoint tc = tileView.center;
        NSString *tcStr = NSStringFromCGPoint(tc);
        [centersArray addObject:tcStr];
        [tilesArray addObject:@""];
        [emptyCenterArray addObject:@"0"];
        }
        [rectanglesArray addObject:[NSValue valueWithCGRect:tmpRect]];
       
        if (tmpMaxColumns < maxColumns -1)
        {
            tmpMaxColumns = tmpMaxColumns+1;
            tmpMaxRows = tmpMaxRows;
        }
        else
        {
            tmpMaxColumns = 0;
            tmpMaxRows = tmpMaxRows+1;
        }
        CGImageRelease(tmpCGImage);
        
    }
    
    [appDelegate.helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [appDelegate.mainMenuButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
 
    [self reArrangeTheImages];
}
-(void)increseTime
{
    playingTime = playingTime+1;
    NSString *tmpStr = @"Time elapsed : ";
    tmpStr = [tmpStr stringByAppendingString:[NSString stringWithFormat:@"%d",playingTime]];
    appDelegate.timeElapsedInSec.text = tmpStr;

}

-(void)help
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"help" object:nil];
}

-(void)menuAction
{
    gameQuitView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 250, 100)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 20)];
    label.text = @"Do you really want to quit ?";
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor redColor];
    [gameQuitView addSubview:label];
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, 50, 30)];
    [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
    yesButton.tag = 0;
    yesButton.titleLabel.textColor = [UIColor blackColor] ;
    [yesButton setBackgroundColor:[UIColor grayColor]];
    [yesButton addTarget:self action:@selector(yesOrNoIsSelected:) forControlEvents:UIControlEventTouchUpInside];
    [gameQuitView addSubview:yesButton];
    
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 30, 50, 30)];
    [noButton setTitle:@"No" forState:UIControlStateNormal];
    noButton.tag = 1;
    noButton.titleLabel.textColor = [UIColor blackColor] ;
    [noButton setBackgroundColor:[UIColor grayColor]];
    [noButton addTarget:self action:@selector(yesOrNoIsSelected:) forControlEvents:UIControlEventTouchUpInside];
    [gameQuitView addSubview:noButton];
    
    [self addSubview:gameQuitView];
    canPlayGame = NO;

    
}
-(void)yesOrNoIsSelected:(UIButton *)selectedButton
{
    int k = selectedButton.tag;
    if (k==0)
    {
        quitGame = YES;
    }
    else if (k==1)
    {
        quitGame = NO; 
        canPlayGame = YES;
    }
    
    [self quitGame];
    
}
-(void)quitGame
{
    if (quitGame == YES)
    {
        [gameQuitView removeFromSuperview]; 
        appDelegate.mainMenuButton.hidden = YES;
        appDelegate.helpButton.hidden = YES;
        appDelegate.timeElapsedInSec.text = @"";
        [gameTimer invalidate];
        [self removeFromSuperview];
        [appDelegate.mainNavigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [gameQuitView removeFromSuperview]; 
    }
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    //[self reArrangeTheImages];
//}

#pragma mark Touch methdos

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (firstTouch == NO) 
    {
       return;
    }
 
    UITouch *touch = [touches anyObject];
    firstTouch = NO;
   
    if (canPlayGame == YES)
    {
        startPoint = [touch locationInView:self];
        isMoved = NO;
        timePassed = 0;
        if (touchTimer == nil)
        {
            touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showTheHelpAndMenuOptions:) userInfo:nil repeats:YES];
        }
        for (int i=0; i<[rectanglesArray count]; i++)
        {
            NSValue *tmpRectPoint = [rectanglesArray objectAtIndex:i];
            CGRect tmpCGRect = [tmpRectPoint CGRectValue];
            if (CGRectContainsPoint(tmpCGRect, startPoint))
            {

                emptyCenterValue = [[emptyCenterArray objectAtIndex:i] intValue];
                if (emptyCenterValue == 1)
                {
                    NSValue *tmpRect = [rectanglesArray objectAtIndex:i];
                    CGRect currentSelectedImageViewRect = [tmpRect CGRectValue];
                    currentSelectedImageView = [tilesArray objectAtIndex:i];

                    currentSelectedImageView.frame = currentSelectedImageViewRect;
                    [self addSubview:currentSelectedImageView];
                    [self bringSubviewToFront:currentSelectedImageView];
                    currentBlock = i;
                    startingPoint = currentSelectedImageView.center;
                    beganPoint = startPoint;
                    previousPoint = currentSelectedImageView.center;
                    canChangePosition = NO;
                    canMove = YES;
                    previousX =startPoint.x;
                    previousY =startPoint.y;
                    presentDirection =20;
                    pastDirection =50;
                }
                 
            }
        } 
    
    }
   // }
   // }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canPlayGame == YES)
    {
        if (emptyCenterValue == 1)
        {
                UITouch *touch = [touches anyObject];
                endPoint = [touch locationInView:self];
                endingPoint = endPoint;
              
                if ([tmpCenterValue intValue]==0)
                {
                    [self calculateDistance];
                }
                
                [self setTheImageInChangedPosition];
                
                if (canChangePosition == YES)
                {
                    [self gameCompleteMethod];
                }
        }
    }
    
    if (touchTimer != nil)
    {
        timePassed = 0;
        [touchTimer invalidate];
        touchTimer = nil;
    }
    firstTouch = YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (canPlayGame == YES)
    {
    if (emptyCenterValue == 1)
    {
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    isMoved = YES;
    float dx = startPoint.x - movePoint.x;
    float dy = startPoint.y - movePoint.y;
    angle = atan2(dy, dx);
    angle= angle*180/3.14;
    presentX = movePoint.x;
    presentY = movePoint.y;
    presentDirection = [self getDirections];
    if (presentDirection == pastDirection)
    {
        //NSLog(@"the past and presnt directions are = %d,%d",pastDirection,presentDirection);  
    }
    else
    {
        canMove = [self directionChangedMethod]; 
    }
    if (canMove == YES)
    {
        NSString *pbpStr = [centersArray objectAtIndex:currentBlock];
        pbp1 = CGPointFromString(pbpStr);
        BOOL tmp = [self canMoveOrNot];
        if (tmp == YES)
        {
        [self moveImage];
        }

    }
    }
        
    }
}


-(playerDirections)getDirections
{
    if (angle >= 75 && angle <= 105)
    {
        currentDirection = direction_up;
    }
    
    else if(angle >= -15 && angle <= 35)
    {
        currentDirection = direction_left;
    }
    else if(angle <= -75 && angle >= -105)
    {
        currentDirection = direction_down; 
    }
    else 
    {
        currentDirection = direction_right; 
    } 
    return currentDirection;
}

-(BOOL)directionChangedMethod
{
    
    tmpCenterValue = @"1";
    if (angle >= 55.0 && angle <= 125.0)
    {
        currentDirection = direction_up;
        proposedBlock = currentBlock-maxColumns;
        if (proposedBlock >= 0 && proposedBlock<maxRows*maxColumns)
        {
            tmpCenterValue = [emptyCenterArray objectAtIndex:proposedBlock];
        }
    }
    else if(angle >= -35.0 && angle <= 35.0)
    {
        currentDirection = direction_left;
        proposedBlock = currentBlock-1;
        if (proposedBlock >= 0 && proposedBlock<maxRows*maxColumns)
        {
            tmpCenterValue = [emptyCenterArray objectAtIndex:proposedBlock];
        }
        
    }
    else if(angle <= -55.0 && angle >= -125.0)
    {
        currentDirection = direction_down; 
        proposedBlock = currentBlock+maxColumns;
        if (proposedBlock >= 0 && proposedBlock<maxRows*maxColumns)
        {
            tmpCenterValue = [emptyCenterArray objectAtIndex:proposedBlock];
        }
        
    }
    else if((angle>=135.0 && angle <= 180.0) || (angle <= -135.0 && angle >= -180.0))
    {
        currentDirection = direction_right; 
        proposedBlock = currentBlock+1;
        if (proposedBlock >= 0 && proposedBlock<maxRows*maxColumns)
        {
            tmpCenterValue = [emptyCenterArray objectAtIndex:proposedBlock];
        }
        
    }
      
    if ([tmpCenterValue intValue]==0)
    {
            return YES;
    }
   else
   {
       return NO;
   }
   
        
}

-(BOOL)canMoveOrNot
{
    CGPoint csbp = currentSelectedImageView.center;
    int distanceTravelled1 = sqrtf((pbp1.x - csbp.x) * (pbp1.x - csbp.x) + (pbp1.y - csbp.y) * (pbp1.y - csbp.y));
    if (currentDirection == direction_up || currentDirection == direction_down) 
    {
        if (distanceTravelled1  <=blockingDistanceByWidth)
        {
            return YES;
        }
        else
        {
            return  NO;
        }

    }
    else
    {
        if (distanceTravelled1  <=blockingDistanceByWidth)
        {
            return YES;
        }
        else
        {
            return  NO;
        }
 
    }
    
   }


-(void)moveImage
{
    if (canMove == YES)
    {

    float xAdd = previousX - presentX;
    float yAdd = previousY - presentY;
    previousX = presentX;
    previousY = presentY;
    if (currentDirection == direction_up)
    {
        xAdd = 0;
        yAdd =-yAdd;
    }
    else if (currentDirection == direction_down)
    {
        xAdd = 0;
        yAdd =-yAdd;
    }
    else if (currentDirection == direction_left)
    {
        xAdd = -xAdd;
        yAdd =0;
    }
    else if (currentDirection == direction_right)
    {
        xAdd = -xAdd;
        yAdd =0;
    }
        CGPoint tmpCenter = currentSelectedImageView.center;
        currentSelectedImageView.center = CGPointMake(tmpCenter.x+xAdd,tmpCenter.y+yAdd);
      
    }
}

-(void)calculateDistance
{
    NSString *cbpStr = [centersArray objectAtIndex:currentBlock];
    CGPoint cbp = CGPointFromString(cbpStr);
   
    NSString *pbpStr = [centersArray objectAtIndex:proposedBlock];
    CGPoint   pbp = CGPointFromString(pbpStr);
    
    distanceRequired= sqrtf((cbp.x - pbp.x) * (cbp.x - pbp.x) + 
                                    (cbp.y - pbp.y) * (cbp.y - pbp.y));
    
    distanceTravelled = sqrtf((startingPoint.x - endPoint.x) * (startingPoint.x - endPoint.x) + 
                                    (startingPoint.y - endPoint.y) * (startingPoint.y - endPoint.y));
        
    if ((distanceTravelled) >= (distanceRequired)) 
    {
      canChangePosition = YES;   
    }
    else
    {
         canChangePosition = NO;
    }
    
}



-(void)createRandomNumbers
{
    storeArray = [[NSMutableArray alloc] init];
    referenceArray = [[NSMutableArray alloc] initWithCapacity:0];
    BOOL record = NO;
    int x;
    int max = maxRows*maxColumns;
    for (int i=0; [storeArray count] < max; i++) //Loop for generate different random values
    {
        x = arc4random() % max;//generating random number
        if(i==0)//for first time 
        {
            [storeArray addObject:[NSNumber numberWithInt:x]];  
        }
        else
        {
            for (int j=0; j< [storeArray count]; j++) 
            {
                if (x ==[[storeArray objectAtIndex:j] intValue]) 
                    record = YES;
            }
            
            if (record == YES) 
            {
                record = NO;
            }
            else
            {
                [storeArray addObject:[NSNumber numberWithInt:x]];
            }
        }
    }
    //NSLog(@" the random array =%@",storeArray);
        
}
-(void)reArrangeTheImages
{
    
    NSMutableArray *numbersArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0 ; i < [tilesArray count]-1; i++)
    {
        [numbersArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [tilesArray count]-1; i++)
    {
        int tmpMax = [numbersArray count];
        int  x = arc4random() % tmpMax;
        int y = [[numbersArray objectAtIndex:x] intValue];
               
        NSString *tmpCenterStr = [centersArray objectAtIndex:i];
        
        CGPoint tmpCenterPoint = CGPointFromString(tmpCenterStr);
        
        TileVIew *tile = [tilesArray objectAtIndex:y];
        tile.center = tmpCenterPoint;
        [tmpArr addObject:tile];
        [self addSubview:tile];
        [numbersArray removeObjectAtIndex:x];
        
    }
    
    for (int i = 0; i < [tilesArray count]-1; i++)
    {
        [tilesArray replaceObjectAtIndex:i withObject:[tmpArr objectAtIndex:i]];
    }
    [numbersArray release];
    [tmpArr release];
}
 
-(void)setTheImageInChangedPosition
{
    if (canChangePosition == YES)
    {
    if (proposedBlock >= 0 && proposedBlock<maxRows*maxColumns)
    {
     
        [emptyCenterArray exchangeObjectAtIndex:currentBlock withObjectAtIndex:proposedBlock];
        [tilesArray exchangeObjectAtIndex:currentBlock withObjectAtIndex:proposedBlock];
        NSString *localCenterPointStr = [centersArray objectAtIndex:proposedBlock];
        CGPoint localCenterPoint = CGPointFromString(localCenterPointStr);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        currentSelectedImageView.center = localCenterPoint;
        [UIView commitAnimations];
    }

   }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        currentSelectedImageView.center = previousPoint;
        [UIView commitAnimations];
    }
    
    previousX = 0;
    previousY =0;
    presentX = 0;
    presentY = 0;
        
}

-(void)gameCompleteMethod
{
    BOOL gameComplete = NO;
    for (int i = 0; i<[tilesArray count]; i++)
    {
        if (i == currentBlock)
        {
            
        }
        else
        {
        TileVIew *tiv = [tilesArray objectAtIndex:i];
            if ([tiv isKindOfClass:[TileVIew class]])
            {
                if (i== tiv.tag)
                {
                    gameComplete = YES;
                }
                else
                {
                    gameComplete = NO;
                    break;
                }
            }        
       
        }
    }
    
    if (gameComplete == YES)
    {
        [self storeBestScore];
        
//        if (bestScoreAchieved == YES)
//        {
//            UIAlertView *gameCompletAlert = [[UIAlertView alloc] initWithTitle:@"Game Completed in record time" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [gameCompletAlert show];
//            [gameCompletAlert release];  
//        }
//        else
//        {
//            UIAlertView *gameCompletAlert = [[UIAlertView alloc] initWithTitle:@"Game Complete" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [gameCompletAlert show];
//            [gameCompletAlert release];
//        
//        }
        canPlayGame = NO;
        [self gameCompleteAnimation];
        [gameTimer invalidate];
        //timePassed = 0;
               
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == gameCompleteAlert)
    {
        if (buttonIndex == 0)
        {
            [self noButtonClicked];
        }
        else if (buttonIndex == 1)
        {
            [self yesButtonClicked]; 
        }
    }
    else
    {
    if (buttonIndex == 0)
    {
        [self removeFromSuperview];
        [appDelegate.mainNavigationController popToRootViewControllerAnimated:YES];
    }
    }
}
-(void)storeBestScore
{
    bestScoreAchieved = NO;
    NSString *s = [self dataFilePathForBestTime];
    if ([[NSFileManager defaultManager] fileExistsAtPath:s]) 
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:s];
        int tmpBestTime  = [[dic objectForKey:@"BestTime"] intValue];
        if (playingTime < tmpBestTime)
        {
            [dic setObject:[NSString stringWithFormat:@"%d",playingTime] forKey:@"BestTime"];
             bestScoreAchieved =YES;
        }
        else
        {
            [dic setObject:[NSString stringWithFormat:@"%d",tmpBestTime] forKey:@"BestTime"];
        }
        [dic writeToFile:s atomically:YES];

        
    }
    else
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSString stringWithFormat:@"%d",playingTime] forKey:@"BestTime"];
        [dic writeToFile:s atomically:YES];
        [dic release];
    }
}

-(void)showTheHelpAndMenuOptions:(NSTimer *)aTimer
{
    timePassed++;
        if (timePassed >=3)
        {
            if (isMoved == NO) 
            {
                timePassed = 0;
                [aTimer invalidate];
                touchTimer = nil;
                appDelegate.mainMenuButton.hidden = NO;
                appDelegate.helpButton.hidden = NO;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1.0];
                appDelegate.helpButton.center  = CGPointMake(50, 40);
                appDelegate.mainMenuButton.center = CGPointMake(250, 40);
                [UIView commitAnimations];
                [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideTheHelpAndMenuOptions) userInfo:nil repeats:NO];
            }
            else
            {
                if (aTimer != nil)
                {
                    timePassed = 0;
                    [aTimer invalidate];
                    touchTimer = nil;
                }
                
            }

        }
}
-(void)gameCompleteAnimation
{
    totalImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    totalImage.image = appDelegate.gameImage;
    [self addSubview:totalImage];
    
    gameWinview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    gameWinview.backgroundColor = [UIColor clearColor];
    UIImageView *gameWinImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    gameWinImageVIew.image = [UIImage imageNamed:@"white.png"];
    [gameWinview addSubview:gameWinImageVIew];
    [self addSubview:gameWinview];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0];
    gameWinImageVIew.alpha = 1.0;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0];
    gameWinImageVIew.alpha = 0;
    [UIView commitAnimations];
    //[self showExitScreen];
    [self performSelector:@selector(showExitScreen) withObject:nil afterDelay:3];
}

-(void)showExitScreen
{
    
//    gameExitView  = [[UIView alloc] initWithFrame:CGRectMake(70, 150, 200, 300)];
//    
//    UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 200, 40)];
//    messageLabel.text = @"Game completed.Do you want to save the score";
//    [gameExitView addSubview:messageLabel];
//    
//    UIButton *yesButton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 50, 30)];
//    yesButton.titleLabel.text = @"Yes";
//    yesButton.backgroundColor = [UIColor redColor];
//    [yesButton addTarget:self action:@selector(yesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [gameExitView addSubview:yesButton];
//    
//    UIButton *noButton  = [[UIButton alloc] initWithFrame:CGRectMake(140, 70, 50, 30)];
//    noButton.titleLabel.text = @"No";
//    noButton.backgroundColor = [UIColor blueColor];
//    [noButton addTarget:self action:@selector(noButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [gameExitView addSubview:noButton];
//    
//    [self addSubview:gameExitView];
 
    
    gameCompleteAlert = [[UIAlertView alloc] initWithTitle:@"Game completed" message:@"Do you want to save the score" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [gameCompleteAlert show];
    [gameCompleteAlert release];
    
    
    
    
}


-(void)yesButtonClicked
{
    [gameExitView removeFromSuperview];
    scoreSavingView = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 300, 200)];
    UILabel *playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    playerNameLabel.text = @"Player name";
    [scoreSavingView addSubview:playerNameLabel];
    
    playerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 100, 20)];
    playerNameTextField.delegate = self;
    playerNameTextField.backgroundColor = [UIColor whiteColor];
    [scoreSavingView addSubview:playerNameTextField];
    
    UIButton *okButton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 50, 30)];
    okButton.titleLabel.text = @"OK";
    okButton.backgroundColor = [UIColor redColor];
    [okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scoreSavingView addSubview:okButton];
    
    
    
    UIButton *canselButton  = [[UIButton alloc] initWithFrame:CGRectMake(150, 70, 50, 30)];
    canselButton.titleLabel.text = @"OK";
    canselButton.backgroundColor = [UIColor redColor];
    [canselButton addTarget:self action:@selector(canselButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scoreSavingView addSubview:canselButton];

    [self addSubview:scoreSavingView];

    

}
-(void)okButtonClicked
{
    [self allScoresSavingMethod];
    [scoreSavingView removeFromSuperview];
    [totalImage removeFromSuperview];
    [gameWinview removeFromSuperview];
    [self removeFromSuperview];
    [appDelegate.mainNavigationController popToRootViewControllerAnimated:YES];
    
}
-(void)canselButtonClicked
{
    
    [scoreSavingView removeFromSuperview];
    [totalImage removeFromSuperview];
    [gameWinview removeFromSuperview];
    [self removeFromSuperview];
    [appDelegate.mainNavigationController popToRootViewControllerAnimated:YES]; 
    
    
}

-(void)noButtonClicked
{
    [gameExitView removeFromSuperview];
    [totalImage removeFromSuperview];
    [gameWinview removeFromSuperview];
    [self removeFromSuperview];
    [appDelegate.mainNavigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    playerNameEntered = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    playerName = textField.text;
    playerNameEntered = YES;
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    playerNameEntered = YES;
    playerName = textField.text;
    return YES;
}

-(void)allScoresSavingMethod
{
   
    NSMutableArray *highScoresArray ;
    NSString *s=[self dataFilePathForAllScores];
    if ([[NSFileManager defaultManager] fileExistsAtPath:s])
    {
        highScoresArray = [[NSMutableArray alloc] initWithContentsOfFile:s]; 
    }
    else
    {
       highScoresArray = [[NSMutableArray alloc] initWithCapacity:0];  
       
    }
    
    NSMutableDictionary *highScoresDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [highScoresDic setObject:[NSString stringWithFormat:@"%d",playingTime] forKey:@"playingTime"];
    
    playerName = playerNameTextField.text;
    
//    if (playerNameEntered == YES)
//    {
//        [highScoresDic setObject:playerName forKey:@"playerName"];
//    }
//    else
//    {
//        [highScoresDic setObject:@"sss" forKey:@"playerName"];
//
//    }
    
    if ([playerName length]>0)
    {
        [highScoresDic setObject:playerName forKey:@"playerName"];
    }
    else
    {
      [highScoresDic setObject:@"sss" forKey:@"playerName"];  
    }
    
    
    if ([highScoresArray count] >0)
    {
     int k = [highScoresArray count];
     for (int i = 0; i<k; i++)
    {
        NSMutableDictionary *tempDic = [highScoresArray objectAtIndex:i];
        NSString *tempStr = [tempDic objectForKey:@"playingTime"];
        int t = [tempStr intValue];
        int a = playingTime;
        if (a <= t) 
        {
            [highScoresArray insertObject:highScoresDic atIndex:i];
            break;
            
        }
        else
        {
            if (i == k-1)
            {
                [highScoresArray insertObject:highScoresDic atIndex:++i];
            }
            
        }
        
        
        
    } 
        
    }
    else
    {
        [highScoresArray addObject:highScoresDic]; 
    }
    
    
    
    NSString *highScorePath = [self dataFilePathForAllScores];
    if ([[NSFileManager defaultManager] fileExistsAtPath:highScorePath])
    {
        [highScoresArray writeToFile:highScorePath atomically:YES];
    }
    else
    {
        [highScoresArray writeToFile:highScorePath atomically:YES];
    }
    
    
    [highScoresArray release];
    [highScoresDic release];
  
    
}






-(void)hideTheHelpAndMenuOptions;
{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDidStopSelector:@selector(stopHelpAnimation)];
        appDelegate.helpButton.center  = CGPointMake(50, -15);
        appDelegate.mainMenuButton.center = CGPointMake(250, -15);
        [UIView commitAnimations];
    
 
}

- (void)dealloc
{
    [super dealloc];
    [centersArray release];
    [referenceArray release];
    [emptyCenterArray release];
    [tilesArray release];
}

@end
