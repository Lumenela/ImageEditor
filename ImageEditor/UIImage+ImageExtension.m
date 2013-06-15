//
//  UIImage+ImageExtension.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "UIImage+ImageExtension.h"
#import "LPixelHelper.h"

typedef struct argb_s {
    unsigned char a;
    unsigned char r;
    unsigned char g;
    unsigned char b;
} argb_t;

@implementation UIImage(ImageExtension)

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
                NSLog(@"%d",[bytes length]);
                return bytes;
            }
        }
    }
    return nil;
}

+ (Byte)getPixelAtx:(int)x y:(int)y fromBitmap:(NSData *)bitmap withWidth:(int)width
{
    //byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;

    int byteIndex = (width * 4) * y + x * 4;
                        NSLog(@"%d, index %d",[bitmap length], byteIndex);
    const char *bytes = (const char*)bitmap.bytes;
    // NSLog(@"%ld",sizeof(bytes)/sizeof(char));
    return bytes[byteIndex];
}

- (UIColor *)averageColor
{
	CGSize size = {1, 1};
	UIGraphicsBeginImageContext(size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
	[self drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
	uint8_t *data = CGBitmapContextGetData(ctx);
	UIColor *color = [UIColor colorWithRed:data[2] / 255.0f
									 green:data[1] / 255.0f
									  blue:data[0] / 255.0f
									 alpha:1];
	UIGraphicsEndImageContext();
	return color;
}

+ (UIImage *)imageFromCharArray:(unsigned char *)rgbaPixels withSize:(CGSize)size boundValue:(int)bound
{
    argb_t *argb = (argb_t *)rgbaPixels;
    for (int i=0; i< size.width * size.height; i++) {
       /* NSLog(@"%hhu", argb[i].a);
        NSLog(@"%hhu", argb[i].r);
        NSLog(@"%hhu", argb[i].g);
        NSLog(@"%hhu", argb[i].b);*/
        UIColor *c = [UIColor colorWithRed:argb[i].r green:argb[i].g blue:argb[i].b alpha:argb[i].a];
        if ([LPixelHelper UIColorToByte:c] > bound) {
            
            //UIColor *col = [UIColor whiteColor];
            //float *f = [LPixelHelper UIColorToFloatArray:col];
            argb[i].r = 255;
            argb[i].g = 255;
            argb[i].b = 255;
            argb[i].a = 255;
            
        } else {
            //UIColor *col = [UIColor blackColor];
            //float *f = [LPixelHelper UIColorToFloatArray:col];
            argb[i].r = 0;
            argb[i].g = 0;
            argb[i].b = 0;
            argb[i].a = 255;
        }
    }

    // Create a color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
		//free(bits);
        return nil;
    }

    CGContextRef context = CGBitmapContextCreate (argb, size.width, size.height, 8, size.width * 4, colorSpace, kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        fprintf (stderr, "Error: Context not created!");
        //free (bits);
		CGColorSpaceRelease(colorSpace );
		return nil;
    }

    CGColorSpaceRelease(colorSpace );
	CGImageRef ref = CGBitmapContextCreateImage(context);
	free(CGBitmapContextGetData(context));
	CGContextRelease(context);

	UIImage *img = [UIImage imageWithCGImage:ref];
	CFRelease(ref);
	return img;
}

- (unsigned char*) rgbaPixels
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace) {
        CGSize size = self.size;
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
                CGContextDrawImage(context, rect, self.CGImage);
                unsigned char *data = CGBitmapContextGetData(context);
                return data;
            }
        }
    }
    return nil;
}


@end