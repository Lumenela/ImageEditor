//
//  LFilterEngine.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFilterEngine <NSObject>

- (id)initWithImage:(UIImage *)image;
- (void)setImage:(UIImage *)image;
- (UIImage *)addWhiteToImage:(UIImage *)image;
- (UIImage *)addWhiteColorWithCoefficient:(int)coefficient toImage:(UIImage *)image;
- (UIImage *)addImage:(UIImage *)image toImage:(UIImage *)image;
- (UIImage *)subtractWhiteFromImage:(UIImage *)image;
- (UIImage *)negativeFromImage:(UIImage *)image;
- (UIImage *)detectEdgesOnImage:(UIImage *)image;

@end
