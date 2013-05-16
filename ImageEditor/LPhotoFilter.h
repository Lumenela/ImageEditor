//
//  LPhotoFilter.h
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPhotoFilter : NSObject

- (id)initWithImage:(UIImage *)image;
- (UIImage *)addConstant:(int)constant;

+ (UIImage *)substractDefaultConstantFromImage:(UIImage *)source;
+ (UIImage *)addDefaultConstantToImage:(UIImage *)source;
+ (UIImage *)negative:(UIImage *)image;
@end
