//
//  LFilterFactory.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFilter.h"

typedef enum {
    FilterWithOneInputImage = 0,
    FilterWithTwoInputImages = 1
} FilterType;

@interface LFilterFactory : NSObject

+ (LFilter *)filterByName:(NSString *)filterName;
+ (FilterType)getFilterType:(LFilter *)filter;

@end
