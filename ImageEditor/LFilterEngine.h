//
//  LFilterEngine.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_FILTERNAME @"Default filter"
#define ADD_WHITE_FILTERNAME @"Add white"
#define SUBTRACT_WHITE_FILTERNAME @"Subtract white"
#define NORMAL_FILTERNAME @"Normal"
#define NEGATIVE_FILTERNAME @"Negative"
#define SEGMENTATE_IMAGE_FILTERNAME @"Binarize"
#define ADD_IMAGE_FILTERNAME @"Add image"
#define MULTIPLY_IMAGE_FILTERNAME @"Multiply image"
#define SQUARE_IMAGE_FILTERNAME @"Square"
#define ENHANCE_IMAGE_FILTERNAME @"Enhace image"
#define GRAYSCALE_FILTERNAME @"Grayscale"

@protocol LFilterEngine <NSObject>

- (UIImage *)addWhiteToImage:(UIImage *)image;
- (UIImage *)addWhiteColorWithCoefficient:(int)coefficient toImage:(UIImage *)image;
- (UIImage *)addBackgroundImage:(UIImage *)backgroundImage toImage:(UIImage *)image;
- (UIImage *)squareImage:(UIImage *)image;
- (UIImage *)subtractWhiteFromImage:(UIImage *)image;
- (UIImage *)negativeFromImage:(UIImage *)image;
- (UIImage *)multiplyImage:(UIImage *)source byImage:(UIImage *)backgroundImage;
- (UIImage *)segmentateImage:(UIImage *)image;
- (UIImage *)enhance:(UIImage *)image;
- (UIImage *)grayScale:(UIImage *)image;

@end
