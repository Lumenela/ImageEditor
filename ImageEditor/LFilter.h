//
//  LFilter.h
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFilter : NSObject

@property (nonatomic, strong) NSString *filterName;
@property (nonatomic, copy) void (^filterBlock)(void);

- (id)initWithName:(NSString *)filterName andBlock:(void (^)(void))filterBlock;

@end
