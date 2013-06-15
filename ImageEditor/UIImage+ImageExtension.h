//
//  UIImage+ImageExtension.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageExtension)

+ (CIImage *)ciImageFromUIImage:(UIImage *)source;
+ (NSData *)bitmapFromImage:(UIImage *)source;
- (unsigned char*) rgbaPixels;
+ (UIImage *)imageFromCharArray:(unsigned char *)rgbaPixels withSize:(CGSize)size boundValue:(int)bound;
+ (Byte)getPixelAtx:(int)x y:(int)y fromBitmap:(NSData *)bitmap withWidth:(int)width;
- (UIColor *)averageColor;
@end
