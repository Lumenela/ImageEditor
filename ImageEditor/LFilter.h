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
@property (nonatomic, copy) UIImage * (^filterBlock)(UIImage *);

- (id)initWithName:(NSString *)filterName andBlock:(UIImage * (^)(UIImage *))filterBlock;
- (UIImage *)filterImage:(UIImage *)image;

@end
