//
//  LPixelColorHelper.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 6/3/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPixelColorHelper : NSObject

+ (UIColor *)byteToUIColor:(Byte)byte;
+ (Byte)UIColorToByte:(UIColor *)color;

@end
