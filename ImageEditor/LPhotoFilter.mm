//
//  LPhotoFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LPhotoFilter.h"
#import "UIImage+OpenCV.h"

@interface LPhotoFilter()

@property (nonatomic, strong) UIImage *image;

@end

@implementation LPhotoFilter


- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
        return self;
    }
    return nil;
}

- (UIImage *)addDefault
{
    
}
- (UIImage *)addConstant:(int)constant
{
    
}

@end
