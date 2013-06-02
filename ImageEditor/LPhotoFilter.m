//
//  LPhotoFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPhotoFilter.h"
#import "UIImage+ImageFormatsExtension.h"
#import "UIImage+InitializerExtension.h"

@interface LPhotoFilter()


@end

@implementation LPhotoFilter

- (UIImage *)addWhiteToImage:(UIImage *)source
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:image forKey:kCIInputImageKey];
    [colorMatrixFilter setValue:[CIVector vectorWithX:1 Y:0 Z:0 W:0] forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0.1 Y:0.1 Z:0.1 W:0] forKey:@"inputBiasVector"];
    CIImage *outputImage = [colorMatrixFilter outputImage];
    return [UIImage imageWithOriginalSizeFromCIImage:outputImage];
}

- (UIImage *)subtractWhiteFromImage:(UIImage *)source
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:image forKey:kCIInputImageKey];
    [colorMatrixFilter setValue:[CIVector vectorWithX:1 Y:0 Z:0 W:0] forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:-0.1 Y:-0.1 Z:-0.1 W:0] forKey:@"inputBiasVector"];
    CIImage *outputImage = [colorMatrixFilter outputImage];
    return [UIImage imageWithOriginalSizeFromCIImage:outputImage];
}

- (UIImage *)negativeFromImage:(UIImage *)source
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setDefaults];
    [filter setValue:image forKey:kCIInputImageKey];
    CIImage* outputImage = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithOriginalSizeFromCIImage:outputImage];
}

- (UIImage *)addBackgroundImage:(UIImage *)backgroundImage toImage:(UIImage *)source
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    CIImage *bgImage = [UIImage ciImageFromUIImage:backgroundImage];
    CIFilter *imageAdditionFilter = [CIFilter filterWithName:@"CIAdditionCompositing"];
    [imageAdditionFilter setDefaults];
    [imageAdditionFilter setValue:image forKey:kCIInputImageKey];
    [imageAdditionFilter setValue:bgImage forKey:kCIInputBackgroundImageKey];
    CIImage *outputImage = [imageAdditionFilter outputImage];
    return [UIImage imageWithOriginalSizeFromCIImage:outputImage];
}

- (UIImage *)multiplyImage:(UIImage *)source byImage:(UIImage *)backgroundImage
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    CIImage *bgImage = [UIImage ciImageFromUIImage:backgroundImage];
    CIFilter *imageAdditionFilter = [CIFilter filterWithName:@"CIMultiplyCompositing"];
    [imageAdditionFilter setDefaults];
    [imageAdditionFilter setValue:image forKey:kCIInputImageKey];
    [imageAdditionFilter setValue:bgImage forKey:kCIInputBackgroundImageKey];
    CIImage *outputImage = [imageAdditionFilter outputImage];
    return [UIImage imageWithOriginalSizeFromCIImage:outputImage];
}

- (UIImage *)squareImage:(UIImage *)image
{
    return [self multiplyImage:image byImage:image];
}

- (UIImage *)detectEdgesOnImage:(UIImage *)image
{
    return image;
}

- (UIImage *)addWhiteColorWithCoefficient:(int)coefficient toImage:(UIImage *)image
{
    return image;
}

@end
