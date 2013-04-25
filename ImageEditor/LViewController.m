//
//  LViewController.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LViewController.h"
#import "LPhotoFilter.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface LViewController ()

@property (nonatomic, strong) UIImagePickerController *cameraUI;
@property (nonatomic, strong) UIImagePickerController *cameraRollUI;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *prevImage;
@property (nonatomic, strong) LPhotoFilter *photoFilter;

//events
@property (nonatomic, strong, readonly) NSString *ImageFilterAppliedNotificationName;
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
    
    _undoButton.enabled = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    _ImageFilterAppliedNotificationName = @"ImageFilterApplied";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableUndo) name:_ImageFilterAppliedNotificationName object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - internal logic

- (void)enableUndo
{
    _undoButton.enabled = YES;
}

- (void)setImage:(UIImage *)image forImageView:(UIImageView *)imageView
{
    imageView.image = image;
    [imageView setNeedsDisplay];
}

- (IBAction)undo:(id)sender
{
    _undoButton.enabled = NO;
    _image = _prevImage;
    [self setImage:_image forImageView:_imageView];
}

- (IBAction)addConstantToImage:(id)sender
{
    _prevImage = [_image copy];
    _image = [_photoFilter addDefaultConstant];
    [self setImage:_image forImageView:_imageView];
    [[NSNotificationCenter defaultCenter] postNotificationName:_ImageFilterAppliedNotificationName object:nil];
}

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
        _photoFilter = [[LPhotoFilter alloc] initWithImage:_image];
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

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"back_pattern.png"];
    
    CGSize retval = image.size.width > 0 ? image.size : CGSizeMake(35, 35);
    retval.height += 35;
    retval.width += 35;
    return retval;
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 2, 5, 2);
}

@end
