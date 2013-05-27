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
    return [LFilterFactory defaultFilter];
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
        [filterEngine setImage:image];
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
        [filterEngine setImage:image];
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
        [filterEngine setImage:image];
        UIImage *res = [filterEngine negativeFromImage:image];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageFilterAppliedNotificationName object:nil];
        return res;
    };

    LFilter *filter = [[LFilter alloc] initWithName:ADD_WHITE_FILTERNAME andBlock:filterBlock];
    return filter;
}

@end
