//
//  LPhotoFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPhotoFilter.h"
#import "UIImage+OpenCV.h"

@interface LPhotoFilter()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) cv::Mat matrix;

@end

@implementation LPhotoFilter


- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
        _matrix = [_image CVMat];
        return self;
    }
    return nil;
}

+ (UIImage *)addDefaultConstantToImage:(UIImage *)source
{
    //TODO: use EAGL context for drawing
    //EAGLContext *myEAGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //    CIContext *context = [CIContext contextWithEAGLContext:myEAGLContext];
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
- (UIImage *)addConstant:(int)constant
{
    return nil;
}

+ (UIImage *)substractDefaultConstantFromImage:(UIImage *)source
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

- (UIImage *)substractConstant:(int)constant
{
    return nil;
}

@end
