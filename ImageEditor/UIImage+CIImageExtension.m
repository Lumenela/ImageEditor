//
//  UIImage+CIImageExtension.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "UIImage+CIImageExtension.h"

@implementation UIImage(CIImageExtension)

+ (CIImage *)ciImageFromUIImage:(UIImage *)source;
{
    CIImage *ci = source.CIImage;
    struct CGImage *cg = source.CGImage;
    CIImage *image;
    if (cg) {
        image = [[CIImage alloc] initWithCGImage:cg];
    } else if (ci) {
        image = ci;
    }
    if (!image) {
        return nil;
    }
    return image;
}

@end
