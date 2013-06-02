//
//  UIImage+CIImageExtension.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CIImageExtension)

+ (CIImage *)ciImageFromUIImage:(UIImage *)source;

@end
