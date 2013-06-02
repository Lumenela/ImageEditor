//
//  LFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LFilter.h"

@implementation LFilter

- (id)initWithName:(NSString *)filterName andBlock:(UIImage * (^)(UIImage *))filterBlock
{
    self = [super init];
    if (self) {
        _filterName = filterName;
        _filterBlock = filterBlock;
        return self;
    }
    return nil;
}

- (id)initWithName:(NSString *)filterName andTwoImagesBlock:(UIImage * (^)(UIImage *, UIImage *))filterBlock
{
    self = [super init];
    if (self) {
        _filterName = filterName;
        _advancedFilterBlock = filterBlock;
        return self;
    }
    return nil;
}

- (UIImage *)filterImage:(UIImage *)image
{
    return _filterBlock(image);
}

- (UIImage *)filterImage:(UIImage *)image withBackgroundImage:(UIImage *)backgroundImage
{
    return _advancedFilterBlock(image, backgroundImage);
}

@end
