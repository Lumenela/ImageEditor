//
//  UIImage+ImageFormatsExtension.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "UIImage+ImageFormatsExtension.h"

@implementation UIImage(ImageFormatsExtension)

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

+ (NSData *)bitmapFromImage:(UIImage *)source
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace) {
        CGSize size = source.size;
        unsigned char *bitmapData = calloc(size.width * size.height*4, 1);
        if (bitmapData) {
            CGContextRef context = CGBitmapContextCreate(bitmapData,
                                                         size.width,
                                                         size.height,
                                                         8,
                                                         size.width*4,
                                                         colorSpace,
                                                         kCGImageAlphaPremultipliedFirst);
            CGColorSpaceRelease(colorSpace);
            if (context) {
                CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
                CGContextDrawImage(context, rect, source.CGImage);
                unsigned char *data = CGBitmapContextGetData(context);
                NSData *bytes = [NSData dataWithBytes:data length:size.width*size.height*4];
                free(bitmapData);
                return bytes;
            }
        }
    }
    return nil;
}

@end
