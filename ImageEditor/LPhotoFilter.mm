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

- (UIImage *)addDefaultConstant
{
    //TODO: use EAGL context for drawing
    //EAGLContext *myEAGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //    CIContext *context = [CIContext contextWithEAGLContext:myEAGLContext];
    CIImage *image = [[CIImage alloc] initWithImage:_image];
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:image forKey:kCIInputImageKey];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0.0 Y:0 Z:0 W:0.3] forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0.5 Z:0 W:0.2] forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0.5 W:0.1] forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    CIImage *outputImage = [colorMatrixFilter outputImage];
    return [UIImage imageWithCIImage:outputImage];
    
}
- (UIImage *)addConstant:(int)constant
{
    return nil;
}

@end
