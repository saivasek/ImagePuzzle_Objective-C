//
//  ExisistingImagesViewController.m
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 04/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ExisistingImagesViewController.h"
#import "CoreGraphicsBasicsAppDelegate.h"
#import "SelectTileViewController.h"
@implementation ExisistingImagesViewController
////////////////
- (NSString *)dataFilePath 
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"imagesData.plist"];
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

-(void)addImagesToImagesArray
{
    for (int i = 1; i<=6; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        imageName = [imageName stringByAppendingString:@".png"];
        UIImage *tmpImage = [UIImage imageNamed:imageName];
        NSData *imageData = UIImagePNGRepresentation(tmpImage);
        [imagesArray addObject:imageData];
    }
    totalNoOfImages= [imagesArray count];

}


-(void)addImagesToViewController
{
    int x = 50;
    int y = 10;
     
    for (int i = 1; i<=[imagesArray count]; i++)
    {
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
        imageButton.tag = i;
        NSData *tmpdata = [imagesArray objectAtIndex:i-1];
        UIImage *tmpImg = [UIImage imageWithData:tmpdata];
        [imageButton setBackgroundImage:tmpImg forState:UIControlStateNormal];
        [exsistingImagesScrollView addSubview:imageButton];
        [imageButton addTarget:self action:@selector(imageIsSelected:) forControlEvents:UIControlEventTouchUpInside];
        if (x == 160)
        {
            x = 50;
            y = y+110;
            
        }
        else
        {
            x = x+110;
            
        }
    }
    
    
    
    
    
}

-(void)imageIsSelected:(UIButton *)selectedButton
{
    
    int k = selectedButton.tag;
    for (int i=1; i<=[imagesArray count]; i++)
    {
        if (k==i)
        {
            NSData *tmpData = [imagesArray objectAtIndex:i-1];
            appDelegate.gameImage = [UIImage imageWithData:tmpData];
        }
    }
    //[self.view removeFromSuperview];
    appDelegate.imageSelected = YES;
    //[self.navigationController popViewControllerAnimated:YES];
    selectTileViewController = [[SelectTileViewController alloc] init];
    [self.navigationController pushViewController:selectTileViewController animated:YES];

}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize 
{  
    UIGraphicsBeginImageContext(newSize);  
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];  
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();    
    return newImage;  
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *image2 = [self scaleImage:image1 toSize:CGSizeMake(320, 480)];
    //[imagesArray addObject:image2];
    NSData *imageData = UIImagePNGRepresentation(image2);
    [imagesArray addObject:imageData];
    [self addImagesToViewController];
    [self dismissModalViewControllerAnimated:YES];
}


-(void)showImagePickerController;
{
    [self presentModalViewController:imageGalleryPickerController animated:YES]; 
}

-(void)storeImages
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *s=[self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:s])
    {
       
        [dic setObject:imagesArray forKey:@"images"];
        //NSLog(@"dic :%@",dic);
        [dic writeToFile:s atomically:YES];
    }
    else
    {
        [dic setObject:imagesArray forKey:@"images"];
        [dic writeToFile:s atomically:YES]; 
    }
    [dic release];
    
}

- (void)dealloc
{
    [super dealloc];
    [imagesArray release];

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
    [self storeImages];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (CoreGraphicsBasicsAppDelegate *)[[UIApplication sharedApplication] delegate];

    [exsistingImagesScrollView setContentSize:CGSizeMake(320, 960)];
    
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain  target:self action:@selector(showImagePickerController)];      
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    imageGalleryPickerController = [[UIImagePickerController alloc] init];
    imageGalleryPickerController.delegate = self;
    imageGalleryPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    NSString *s=[self dataFilePath];
    imagesArray = [[NSMutableArray alloc]initWithCapacity:0];

    if ([[NSFileManager defaultManager] fileExistsAtPath:s])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:s];
        //NSLog(@"the values of dic :%@",dic );
        if([[dic objectForKey:@"images"]count]){
            [imagesArray removeAllObjects];
            [imagesArray addObjectsFromArray:[dic objectForKey:@"images"]];
        }
        else
        {
            [self addImagesToImagesArray]; 
        }
        [dic release];
    }
    else
    {
        [self addImagesToImagesArray]; 
    }
    
    
    [self addImagesToViewController];

    
    

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
