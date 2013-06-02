//
//  UIImage+InitializerExtension.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/2/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "UIImage+InitializerExtension.h"

@implementation UIImage(InitializerExtension)

+ (UIImage *)imageWithOriginalSizeFromCIImage:(CIImage *)source
{
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *res = [UIImage imageWithCGImage:[context createCGImage:source fromRect:[source extent]]];
    return res;
}

@end
