//
//  LPixelHelper.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/3/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPixelHelper : NSObject

+ (UIColor *)byteToUIColor:(Byte)byte;
+ (Byte)UIColorToByte:(UIColor *)color;
+ (float *)UIColorToFloatArray:(UIColor *)color;

@end
