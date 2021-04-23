//
//  GameStartingView.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 03/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "GameStartingView.h"
#import "CoreGraphicsBasicsAppDelegate.h"

@implementation GameStartingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)howToPlayButtonClicked:(id)sender
{
    howToPlayViewController = [[HowToPlayViewController alloc] init];
    [self.navigationController pushViewController:howToPlayViewController animated:YES];
}
-(IBAction)galleryButtonClicked:(id)sender
{
    exsistingImagesViewController = [[ExisistingImagesViewController alloc] init];
    [self.navigationController pushViewController:exsistingImagesViewController animated:YES];
}

-(IBAction)selectImageButtonClicked:(id)sender
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) 
    {
        optionsActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select image to play" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Choose from exsisting images",@"Choose from photo gallery",@"Take a picture", nil];

    }
    else
    {
        optionsActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select image to play" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Choose from exsisting images",@"Choose from photo gallery", nil];

    }
    
    optionsActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [optionsActionSheet showInView:self.view];
    [optionsActionSheet release];
    
}

-(IBAction)highScoresButtonClicked:(id)sender
{
    highScoresView = [[HighScoresView alloc] init];
    [self.navigationController pushViewController:highScoresView animated:YES];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if (buttonIndex == 0)
    {
        //appDelegate.gameImage = [UIImage imageNamed:@"4.png"]; 
        exsistingImagesViewController = [[ExisistingImagesViewController alloc] init];
        //[self.view addSubview:exsistingImagesViewController.view];
        [self.navigationController pushViewController:exsistingImagesViewController animated:YES];

	}
    else if (buttonIndex == 1)
    {
        [self presentModalViewController:imageGalleryPickerController animated:YES];
	} 
    else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) 
        {
        [self presentModalViewController:cameraPickerController animated:YES];
        }
        else
        {
            [self dismissModalViewControllerAnimated:YES];
        }
	}
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   UIImage *image1 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   UIImage *image2 = [self scaleImage:image1 toSize:CGSizeMake(320, 480)];
   appDelegate.gameImage = image2;
   appDelegate.imageSelected = YES;
   selectTileViewController = [[SelectTileViewController alloc] init];
   [self.navigationController pushViewController:selectTileViewController animated:YES];
   [self dismissModalViewControllerAnimated:YES];
}

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize 
{  
    UIGraphicsBeginImageContext(newSize);  
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];  
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();    
    return newImage;  
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
    self.navigationController.navigationBar.hidden = YES;
    appDelegate.headerView.hidden = YES;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (CoreGraphicsBasicsAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    imageGalleryPickerController = [[UIImagePickerController alloc] init];
    imageGalleryPickerController.delegate = self;
    imageGalleryPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    cameraPickerController = [[UIImagePickerController alloc] init];
    cameraPickerController.delegate = self;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) 
    {
    cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
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
