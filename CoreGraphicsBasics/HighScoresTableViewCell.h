//
//  HighScoresTableViewCell.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 24/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoresTableViewCell : UITableViewCell 
{
    UILabel *playerName;
    UILabel *time;
}
@property (nonatomic,assign) UILabel *playerName;
@property (nonatomic,assign)UILabel *time;  

@end
