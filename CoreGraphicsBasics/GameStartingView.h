//
//  GameStartingView.h
//  CoreGraphicsBasics
//
//  Created by Saikumar Bondugula on 03/01/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExisistingImagesViewController.h"
#import "HowToPlayViewController.h"
#import "SelectTileViewController.h"
#import "HighScoresView.h"
@class CoreGraphicsBasicsAppDelegate;
@interface GameStartingView : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate> 
{
    CoreGraphicsBasicsAppDelegate *appDelegate;
    ExisistingImagesViewController *exsistingImagesViewController;
    HowToPlayViewController *howToPlayViewController;
    SelectTileViewController *selectTileViewController;
    HighScoresView *highScoresView;
    IBOutlet UIButton *selectImageButton;
    IBOutlet UIButton *okButton;
    UIActionSheet *optionsActionSheet;
    UIImagePickerController *imageGalleryPickerController;
    UIImagePickerController *cameraPickerController;
}
-(IBAction)selectImageButtonClicked:(id)sender;
-(IBAction)howToPlayButtonClicked:(id)sender;
-(IBAction)galleryButtonClicked:(id)sender;
-(IBAction)highScoresButtonClicked:(id)sender;
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize ;

@end
