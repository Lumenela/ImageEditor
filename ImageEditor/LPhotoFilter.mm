//
//  LPhotoFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPhotoFilter.h"

@interface LPhotoFilter()

@property (nonatomic, strong) UIImage *image;

@end

@implementation LPhotoFilter


- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
        return self;
    }
    return nil;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
}

- (UIImage *)addWhiteToImage:(UIImage *)source
{
    CIImage *ci = source.CIImage;
    CGImage *cg = source.CGImage;
    CIImage *image;
    if (cg) {
        image = [[CIImage alloc] initWithCGImage:cg];
    } else if (ci) {
        image = ci;
    }
    if (!image) {
        return nil;
    }
    
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:image forKey:kCIInputImageKey];
    [colorMatrixFilter setValue:[CIVector vectorWithX:1 Y:0 Z:0 W:0] forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0.1 Y:0.1 Z:0.1 W:0] forKey:@"inputBiasVector"];
    CIImage *outputImage = [colorMatrixFilter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *res = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:[outputImage extent]]];
    return res;
}

- (UIImage *)subtractWhiteFromImage:(UIImage *)source
{
    CIImage *ci = source.CIImage;
    CGImage *cg = source.CGImage;
    CIImage *image;
    if (cg) {
        image = [[CIImage alloc] initWithCGImage:cg];
    } else if (ci) {
        image = ci;
    }
    if (!image) {
        return nil;
    }
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:image forKey:kCIInputImageKey];
    [colorMatrixFilter setValue:[CIVector vectorWithX:1 Y:0 Z:0 W:0] forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:-0.1 Y:-0.1 Z:-0.1 W:0] forKey:@"inputBiasVector"];
    CIImage *outputImage = [colorMatrixFilter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *res = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:[outputImage extent]]];
    return res;
}

- (UIImage *)negativeFromImage:(UIImage *)source
{
    CIImage *ci = source.CIImage;
    CGImage *cg = source.CGImage;
    CIImage *image;
    if (cg) {
        image = [[CIImage alloc] initWithCGImage:cg];
    } else if (ci) {
        image = ci;
    }
    if (!image) {
        return nil;
    }
    CIFilter* filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setDefaults];
    [filter setValue:image forKey:kCIInputImageKey];
    CIImage* outputImage = [filter valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *res = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:[outputImage extent]]];
    return res;
}

- (UIImage *)detectEdgesOnImage:(UIImage *)image
{
    return image;
}

- (UIImage *)addWhiteColorWithCoefficient:(int)coefficient toImage:(UIImage *)image
{
    return image;
}

- (UIImage *)addImage:(UIImage *)image toImage:(UIImage *)otherImage
{
    return image;
}

@end
