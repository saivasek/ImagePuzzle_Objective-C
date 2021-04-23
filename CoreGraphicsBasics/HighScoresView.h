//
//  HighScoresView.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 24/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoresTableViewCell.h"

@interface HighScoresView : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *highScoresTableView;
    NSMutableArray *highScoresRetrivingArray;
    NSMutableDictionary *highScoresRetrivingDic;
}

@end
