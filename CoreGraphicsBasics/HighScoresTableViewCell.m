//
//  HighScoresTableViewCell.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 24/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "HighScoresTableViewCell.h"


@implementation HighScoresTableViewCell
@synthesize playerName;
@synthesize time;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        playerName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        playerName.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:playerName];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 50, 20)];
        time.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:time];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
    [playerName release];
    [time release];
}

@end
