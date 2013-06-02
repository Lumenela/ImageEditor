//
//  LFilterFactory.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LFilterFactory.h"
#import "LFilterEngine.h"
#import "LAppDelegate.h"

@implementation LFilterFactory

+ (LFilter *)filterByName:(NSString *)filterName
{
    if ([filterName isEqualToString:ADD_WHITE_FILTERNAME]) {
        return [LFilterFactory addWhiteToImage];
    }
    if ([filterName isEqualToString:SUBTRACT_WHITE_FILTERNAME]) {
        return [LFilterFactory subtractWhiteFromImage];
    }
    if ([filterName isEqualToString:NEGATIVE_FILTERNAME]) {
        return [LFilterFactory negativeFromImage];
    }
    if ([filterName isEqualToString:EDGE_DETECTION_FILTERNAME]) {
        return [LFilterFactory detectEdgesOnImage];
    }
    if ([filterName isEqualToString:ADD_IMAGE_FILTERNAME]) {
        return [LFilterFactory addBackgroundImageToImage];
    }
    if ([filterName isEqualToString:MULTIPLY_IMAGE_FILTERNAME]) {
        return [LFilterFactory multuplyImageByBackgroundImage];
    }
    if ([filterName isEqualToString:SQUARE_IMAGE_FILTERNAME]) {
        return [LFilterFactory squareImage];
    }
    return [LFilterFactory defaultFilter];
}

+ (FilterType)getFilterType:(LFilter *)filter
{
    NSString *filterName = [filter filterName];
    if ([filterName isEqualToString:NORMAL_FILTERNAME] ||
        [filterName isEqualToString:ADD_WHITE_FILTERNAME] ||
        [filterName isEqualToString:SUBTRACT_WHITE_FILTERNAME] ||
        [filterName isEqualToString:NEGATIVE_FILTERNAME] ||
        [filterName isEqualToString:DEFAULT_FILTERNAME] ||
        [filterName isEqualToString:SQUARE_IMAGE_FILTERNAME]) {
        return FilterWithOneInputImage;
    } else if ([filterName isEqualToString:ADD_IMAGE_FILTERNAME] ||
               [filterName isEqualToString:MULTIPLY_IMAGE_FILTERNAME]) {
        return FilterWithTwoInputImages;
    }
    return FilterWithOneInputImage;
}

+ (LFilter *)defaultFilter
{
    return [[LFilter alloc] initWithName:DEFAULT_FILTERNAME andBlock:^UIImage *(UIImage *image) {
        return image;
    }];
}

+ (LFilter *)addWhiteToImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage * (^filterBlock)(UIImage *image) = ^UIImage *(UIImage *image) {
        UIImage *res = [filterEngine addWhiteToImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };

    LFilter *filter = [[LFilter alloc] initWithName:ADD_WHITE_FILTERNAME andBlock:filterBlock];
    return filter;
}

+ (LFilter *)subtractWhiteFromImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage * (^filterBlock)(UIImage *image) = ^UIImage *(UIImage *image) {
        UIImage *res = [filterEngine subtractWhiteFromImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };

    LFilter *filter = [[LFilter alloc] initWithName:ADD_WHITE_FILTERNAME andBlock:filterBlock];
    return filter;
}

+ (LFilter *)negativeFromImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage * (^filterBlock)(UIImage *image) = ^UIImage *(UIImage *image) {
        UIImage *res = [filterEngine negativeFromImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };

    LFilter *filter = [[LFilter alloc] initWithName:ADD_WHITE_FILTERNAME andBlock:filterBlock];
    return filter;
}

+ (LFilter *)addBackgroundImageToImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage *(^filterBlock)(UIImage *image, UIImage *bgImage) = ^UIImage *(UIImage *image, UIImage *bgImage) {
        UIImage *res = [filterEngine addBackgroundImage:bgImage toImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };
    LFilter *filter = [[LFilter alloc] initWithName:ADD_IMAGE_FILTERNAME andTwoImagesBlock:filterBlock];
    return filter;
}

+ (LFilter *)multuplyImageByBackgroundImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage *(^filterBlock)(UIImage *image, UIImage *bgImage) = ^UIImage *(UIImage *image, UIImage *bgImage) {
        UIImage *res = [filterEngine multiplyImage:image byImage:bgImage];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };
    LFilter *filter = [[LFilter alloc] initWithName:ADD_IMAGE_FILTERNAME andTwoImagesBlock:filterBlock];
    return filter;
}

+ (LFilter *)squareImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage *(^filterBlock)(UIImage *image) = ^UIImage *(UIImage *image) {
        UIImage *res = [filterEngine squareImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };
    LFilter *filter = [[LFilter alloc] initWithName:SQUARE_IMAGE_FILTERNAME andBlock:filterBlock];
    return filter;
}


+ (LFilter *)detectEdgesOnImage
{
    id<LFilterEngine> filterEngine = [ApplicationDelegate filterEngine];
    UIImage * (^filterBlock)(UIImage *image) = ^UIImage *(UIImage *image) {
        UIImage *res = [filterEngine detectEdgesOnImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };

    LFilter *filter = [[LFilter alloc] initWithName:EDGE_DETECTION_FILTERNAME andBlock:filterBlock];
    return filter;
}

@end
