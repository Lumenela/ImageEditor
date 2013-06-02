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
@property (nonatomic, copy) UIImage * (^advancedFilterBlock)(UIImage *, UIImage *);

- (id)initWithName:(NSString *)filterName andBlock:(UIImage * (^)(UIImage *))filterBlock;
- (id)initWithName:(NSString *)filterName andTwoImagesBlock:(UIImage * (^)(UIImage *, UIImage *))filterBlock;
- (UIImage *)filterImage:(UIImage *)image;
- (UIImage *)filterImage:(UIImage *)image withBackgroundImage:(UIImage *)backgroundImage;

@end
