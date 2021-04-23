//
//  SelectTileViewController.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 03/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SelectTileViewController.h"
#import "CoreGraphicsBasicsAppDelegate.h"

@implementation SelectTileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)tile3X4ButtonSelected:(id)sender
{
    if (appDelegate.imageSelected == YES)
    {
        appDelegate.maxColumns = 3;
        appDelegate.maxRows = 4;
        appDelegate.intialGap = 1;
        tileTypeSelected = YES;
        appDelegate.frameType =1;
        [self tileIsSelected];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have not selected the image to play.Select the image first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    
}
-(IBAction)tile4X6ButtonSelected:(id)sender
{ 
    if (appDelegate.imageSelected == YES)
   {
    appDelegate.maxColumns = 4;
    appDelegate.maxRows = 6;
    appDelegate.intialGap = 0;
    tileTypeSelected = YES;
    appDelegate.frameType =2;
    [self tileIsSelected];

   }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have not selected the image to play.Select the image first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    

}
-(IBAction)tile5X8ButtonSelected:(id)sender
{
    if (appDelegate.imageSelected == YES)
    {
    appDelegate.maxColumns = 5;
    appDelegate.maxRows = 8;
    appDelegate.intialGap = 0;
    tileTypeSelected = YES;
    appDelegate.frameType =3;
    [self tileIsSelected];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have not selected the image to play.Select the image first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    

}

-(void)tileIsSelected
{
    if (tileTypeSelected == YES)
    {
        myDrawingClass = [[MyDrawingClass alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [self.navigationController setNavigationBarHidden:YES];
        [self.view addSubview:myDrawingClass];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tile type not selected" message:@"Select tile type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}



- (void)dealloc
{
    [super dealloc];
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
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    //self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tileTypeSelected = NO;
    appDelegate = (CoreGraphicsBasicsAppDelegate *)[[UIApplication sharedApplication] delegate];
    showImage.image = appDelegate.gameImage;
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
