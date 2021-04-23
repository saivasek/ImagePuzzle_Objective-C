//
//  ExisistingImagesViewController.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 04/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreGraphicsBasicsAppDelegate;
@class SelectTileViewController;
@interface ExisistingImagesViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> 
{
    IBOutlet UIScrollView *exsistingImagesScrollView;
    CoreGraphicsBasicsAppDelegate *appDelegate;
    SelectTileViewController *selectTileViewController;
    UIImagePickerController *imageGalleryPickerController;
    int totalNoOfImages;
    NSMutableArray *imagesArray;
    ///////// Storing Images
    BOOL fileExists;

}

-(void)addImagesToViewController;
-(void)imageIsSelected:(UIButton *)selectedButton;
-(void)showImagePickerController;
-(void)addImagesToImagesArray;
-(void)storeImages;
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize ;

@end
