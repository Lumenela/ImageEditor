//
//  LComplexFilterFacade.m
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LComplexFilterFacade.h"
#import "LComplexFilterBase.h"
#import "UIImage+OpenCV.h"

@interface LComplexFilterFacade()

@property (nonatomic, assign) LComplexFilterBase *complexFilter;

@end

@implementation LComplexFilterFacade

- (id) initWithSample:(LComplexFilterBase *)complexFilter
{
    assert(complexFilter);

    if (self = [super init])
    {
        _complexFilter = complexFilter;
    }

    return self;

}

- (UIImage*) processFrame:(UIImage*) source
{
    cv::Mat inputImage = [source CVMat];
    cv::Mat outputImage;

    _complexFilter->processFrame(inputImage, outputImage);
    UIImage * result = [UIImage imageWithCVMat:outputImage];
    return result;
}

@end
