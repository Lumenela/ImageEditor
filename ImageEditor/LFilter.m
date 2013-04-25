//
//  LFilter.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LFilter.h"

@implementation LFilter

- (id)initWithName:(NSString *)filterName andBlock:(void (^)(void))filterBlock
{
    self = [super init];
    if (self) {
        _filterName = filterName;
        _filterBlock = filterBlock;
        return self;
    }
    return nil;
}

@end
