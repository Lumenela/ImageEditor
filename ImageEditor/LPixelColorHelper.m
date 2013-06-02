//
//  LPixelColorHelper.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/3/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPixelColorHelper.h"

@implementation LPixelColorHelper

+ (UIColor *)byteToUIColor:(Byte)byte
{
    CGFloat alpha = ((byte >> 24) & 0xff)/255;
    CGFloat red = ((byte >> 16) & 0xff)/255;
    CGFloat green = ((byte >> 8) & 0xff)/255;
    CGFloat blue = (byte & 0xff)/255;
    return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
}

+ (Byte)UIColorToByte:(UIColor *)color
{
    int numComponents = CGColorGetNumberOfComponents(color.CGColor);

    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = components[3];
        int a = (int)roundf(alpha)*255;
        int r = (int)roundf(red)*255;
        int g = (int)roundf(green)*255;
        int b = (int)roundf(blue)*255;
        return (a << 24) + (r << 16) + (g << 8) + b;
    }
    return -1;
}

@end
