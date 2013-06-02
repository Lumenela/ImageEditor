//
//  UIImage+ImageFormatsExtension.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageFormatsExtension)

+ (CIImage *)ciImageFromUIImage:(UIImage *)source;
+ (NSData *)bitmapFromImage:(UIImage *)source;

@end
