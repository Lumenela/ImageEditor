//
//  LViewController.h
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LViewController : UIViewController<UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate,
                                                UICollectionViewDataSource,
                                                UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView  *imageSelectionView;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIButton *undoButton;

- (IBAction)takePicture;
- (IBAction)selectImageFromPhotoLibrary;
- (IBAction)addConstantToImage:(id)sender;

- (IBAction)undo:(id)sender;

@end
