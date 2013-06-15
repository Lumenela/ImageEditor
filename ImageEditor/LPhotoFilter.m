//
//  LPhotoFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPhotoFilter.h"
#import "UIImage+ImageExtension.h"
#import "UIImage+InitializerExtension.h"
#import "UIImage+ImageExtension.h"
#import "LPixelHelper.h"

@interface LPhotoFilter()


@end

@implementation LPhotoFilter

- (void)test:(UIImage *)source
{
    UIColor *c = [source averageColor];
    NSLog(@"%d", [LPixelHelper UIColorToByte:c]);

}

- (UIImage *)addWhiteToImage:(UIImage *)source
{
    //[self test:source];
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

- (UIImage *)enhance:(UIImage *)source
{
    CIImage *image = [UIImage ciImageFromUIImage:source];
    
    NSArray *adjustments = [image autoAdjustmentFiltersWithOptions:nil];
    for (CIFilter *filter in adjustments) {
        [filter setValue:image forKey:kCIInputImageKey];
        image = filter.outputImage;
    }
    return [UIImage imageWithOriginalSizeFromCIImage:image];
}

- (UIImage *)segmentateImage:(UIImage *)image
{
    // convert to grey scale and shrink the image by 4 - this makes processing a lot faster!
	//ImageWrapper *greyScale= [ImageWrapper createImage:image width:image.size.width height:image.size.height];// Image::createImage(srcImage, srcImage.size.width/4, srcImage.size.height/4);
	// you can play around with the numbers to see how it effects the edge extraction
	// typical numbers are  tlow 0.20-0.50, thigh 0.60-0.90
	//ImageWrapper *edges=greyScale.image->gaussianBlur().image->cannyEdgeExtract(0.3,0.7);
    //  ImageWrapper *edges= [greyScale.image autoThreshold];
    return image;//edges.image.toUIImage;
}

- (UIImage *)grayScale:(UIImage *)image
{
    UIImage *newImage;

    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width * image.scale, image.size.height * image.scale, 8, image.size.width * image.scale, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), [image CGImage]);

    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);

    UIImage *resultImage = [UIImage imageWithCGImage:bwImage];
    CGImageRelease(bwImage);

    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [resultImage drawInRect:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
