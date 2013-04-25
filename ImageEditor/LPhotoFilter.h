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
- (UIImage *)addDefaultConstant;
- (UIImage *)addConstant:(int)constant;

@end
