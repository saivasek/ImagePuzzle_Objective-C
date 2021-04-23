//
//  HighScoresView.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 24/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "HighScoresView.h"


@implementation HighScoresView
- (NSString *)dataFilePathForAllScores
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"allScores.plist"];
    //[paths release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - Table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([highScoresRetrivingArray count] <= 10)
    {
        return [highScoresRetrivingArray count];
    }
    else
    {
        return 10;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    HighScoresTableViewCell *cell;
    
    cell = (HighScoresTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[HighScoresTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
    
    highScoresRetrivingDic = [highScoresRetrivingArray objectAtIndex:indexPath.row];
    cell.playerName.text = [highScoresRetrivingDic objectForKey:@"playerName"];
    cell.time.text = [highScoresRetrivingDic objectForKey:@"playingTime"];
       
    return cell;

}

- (void)dealloc
{
    [super dealloc];
    [highScoresRetrivingArray release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"HIGH SCORES";
    NSString *s = [self dataFilePathForAllScores];
    if ([[NSFileManager defaultManager] fileExistsAtPath:s])
    {
        highScoresRetrivingArray = [[NSMutableArray alloc] initWithContentsOfFile:s];
    }
    else
    {
        highScoresRetrivingArray = [[NSMutableArray alloc] init];
  
    }
        
    highScoresTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, 250, 350)];
    highScoresTableView.delegate =  self;
    highScoresTableView.dataSource =  self;
    [self.view addSubview:highScoresTableView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
