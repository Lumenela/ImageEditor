//
//  UIImage+InitializerExtension.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(InitializerExtension)

+ (UIImage *)imageWithOriginalSizeFromCIImage:(CIImage *)source;

@end
