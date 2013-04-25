//
//  LViewController.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface LViewController ()

@property (nonatomic, strong) UIImagePickerController *cameraUI;
@property (nonatomic, strong) UIImagePickerController *cameraRollUI;
@property (nonatomic, strong) UIImage *image;

@end

@implementation LViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _cameraUI = [[UIImagePickerController alloc] init];
    _cameraUI.delegate = self;
    _cameraUI.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum; //UIImagePickerControllerSourceTypeCamera;
    _cameraUI.mediaTypes = @[(NSString *) kUTTypeImage];
    _cameraUI.allowsEditing = YES;

    _cameraRollUI = [[UIImagePickerController alloc] init];
    _cameraRollUI.delegate = self;
    _cameraRollUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    _cameraRollUI.mediaTypes = @[(NSString *) kUTTypeImage];
    _cameraRollUI.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - internal logic

- (IBAction)takePicture
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)selectImageFromPhotoLibrary
{
    [self startPhotoLibraryControllerFromViewController:self usingDelegate:self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {

    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;

    [self presentViewController:_cameraUI animated:YES completion:nil];
    return YES;
}

- (BOOL) startPhotoLibraryControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {

    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;

    [self presentViewController:_cameraRollUI animated:YES completion:nil];
    return YES;
}

- (void)showImage:(UIImage *)image
{
    [_imageView setImage:image];
    [_imageSelectionView setHidden:YES];
    [_imageView setNeedsDisplay];
}

#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;

    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];

        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        //UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil , nil);
        _image = imageToSave;
        [self showImage:_image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image
        finishedSavingWithError:(NSError *)error
                    contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
