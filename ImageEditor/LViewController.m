//
//  LViewController.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LViewController.h"
#import "LPhotoFilter.h"
#import "LFilter.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "LSliderViewController.h"
#import "FPPopoverController.h"

#define kBorderWidth 3.0
#define kCornerRadius 8.0

@interface LViewController ()

@property (nonatomic, strong) UIImagePickerController *cameraUI;
@property (nonatomic, strong) UIImagePickerController *cameraRollUI;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *prevImage;
@property (nonatomic, strong) LPhotoFilter *photoFilter;
@property (nonatomic, strong) NSArray *filtersArray;
@property (nonatomic, strong) UIAlertView *alert;

//events
@property (nonatomic, strong, readonly) NSString *ImageFilterAppliedNotificationName;
@end


@implementation LViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureImagePlaceholder];
    [self configureCameraUI];
    [self configureCameraRollUI];
    [self createFiltersArray];
    [self configureInitialUI];
    [self configureAlertView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    _ImageFilterAppliedNotificationName = @"ImageFilterApplied";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableUndo) name:_ImageFilterAppliedNotificationName object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)createFiltersArray
{
    NSMutableArray *filtersArray = [[NSMutableArray alloc] init];
    __block LViewController *blockSafeSelf = self;
    void (^addFilterBlock)(void) = ^ {
        [blockSafeSelf addConstantToImage];
        [blockSafeSelf hideActivityIndicator];
    };
    LFilter *addFilter = [[LFilter alloc] initWithName:@"Add" andBlock:addFilterBlock];
    [filtersArray addObject:addFilter];

    void (^substractFilterBlock)(void) = ^ {
        [blockSafeSelf substractConstantFromImage];
        [blockSafeSelf hideActivityIndicator];
    };
    LFilter *substractFilter = [[LFilter alloc] initWithName:@"Substract" andBlock:substractFilterBlock];
    [filtersArray addObject:substractFilter];
    
    _filtersArray = filtersArray;
}

- (void)configureImagePlaceholder
{
    _imagePlaceholder.layer.borderColor = [[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.9] CGColor];
    _imagePlaceholder.layer.borderWidth = 3.0f;
    [_imagePlaceholder.layer setShadowColor:[UIColor blackColor].CGColor];
    [_imagePlaceholder.layer setShadowOpacity:0.8];
    [_imagePlaceholder.layer setShadowRadius:3.0];
    [_imagePlaceholder.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (void)configureAlertView
{
    _alert = [[UIAlertView alloc] initWithTitle:@"Processing" message:@"\n\n"
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil, nil];

    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(120, 70, 50, 50);
    [activityIndicator startAnimating];
    [_alert addSubview:activityIndicator];

}

- (void)configureInitialUI
{
    self.title = @"CHOOSE PICTURE";
    _imageView.hidden = YES;
    _imageSelectionView.hidden = NO;
    _undoButton.enabled = NO;
    _configureButton.enabled = NO;
    _addButton.enabled = NO;
    _autoContrastButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)configureEditingUI
{
    self.title = @"EDIT";
    _imageSelectionView.hidden = YES;
    _imageView.hidden = NO;
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(save)];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}

- (void)configureCameraUI
{
    _cameraUI = [[UIImagePickerController alloc] init];
    _cameraUI.delegate = self;
    _cameraUI.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum; //UIImagePickerControllerSourceTypeCamera;
    _cameraUI.mediaTypes = @[(NSString *) kUTTypeImage];
    _cameraUI.allowsEditing = YES;
}

- (void)configureCameraRollUI
{
    _cameraRollUI = [[UIImagePickerController alloc] init];
    _cameraRollUI.delegate = self;
    _cameraRollUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    _cameraRollUI.mediaTypes = @[(NSString *) kUTTypeImage];
    _cameraRollUI.allowsEditing = YES;
}

#pragma mark - internal logic

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = _image;
}

- (void)enableUndo
{
    if (_prevImage) {
        _undoButton.enabled = YES;
    }
}

- (void)save
{
    UIImageWriteToSavedPhotosAlbum(_image, nil, nil , nil);
    [self configureInitialUI];
}

- (void)cancel
{
    [self configureInitialUI];
}

- (IBAction)undo:(id)sender
{
    _undoButton.enabled = NO;
    _image = _prevImage;
    [self showImage:_image];
}

- (IBAction)configure:(id)sender
{
    LSliderViewController *sliderViewController;// = [[LSliderViewController alloc] init];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LSliderViewController" owner:self options:nil];
    sliderViewController = nib[0];
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:sliderViewController
                                                                              delegate:self];
    [popover presentPopoverFromView:(UIView *)sender];
    
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
    //[_imageView setNeedsDisplay];
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
        [self setImage:imageToSave];
        _photoFilter = [[LPhotoFilter alloc] initWithImage:_image];
        [self configureEditingUI];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_filtersArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:UILabel.class]) {
            [view removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sample.png"]];
    cell.layer.borderColor = [[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.9] CGColor];
    cell.layer.borderWidth = 3.0f;
    [cell.layer setShadowColor:[UIColor blackColor].CGColor];
    [cell.layer setShadowOpacity:0.8];
    [cell.layer setShadowRadius:3.0];
    [cell.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    NSString *filterName = ((LFilter *) _filtersArray[indexPath.row]).filterName;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 70, 85, 20)];
    label.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];
    label.text = filterName;
    label.font = [label.font fontWithSize:10];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_image) {
        LFilter *filter = ((LFilter *) _filtersArray[indexPath.row]);
        if ([filter.filterName isEqualToString:@"Add"]) {
            _configureButton.enabled = YES;
        } else {
            _configureButton.enabled = NO;
        }
        [self showActivityIndicator];
        void (^filterBlock)(void) = filter.filterBlock;
        filterBlock();
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval;
    retval.height = 90;
    retval.width = 90;
    return retval;
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 2, 5, 2);
}

#pragma mark - Manage Alert View

- (void)showActivityIndicator
{
    [_alert show];
}

- (void)hideActivityIndicator
{
    if (_alert) {
        [_alert dismissWithClickedButtonIndex:-1 animated:YES];
    }
}

#pragma mark - AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

#pragma mark - Filters

- (void)addConstantToImage
{
    _prevImage = [_image copy];
    [self setImage:[LPhotoFilter addDefaultConstantToImage:_image]];
    [[NSNotificationCenter defaultCenter] postNotificationName:_ImageFilterAppliedNotificationName object:nil];
}

- (void)substractConstantFromImage
{
    _prevImage = [_image copy];
    [self setImage:[LPhotoFilter substractDefaultConstantFromImage:_image]];
    [[NSNotificationCenter defaultCenter] postNotificationName:_ImageFilterAppliedNotificationName object:nil];
}

#pragma mark - Popover Delegate

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController
{
    
}

@end
