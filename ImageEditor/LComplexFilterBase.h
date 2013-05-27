//
//  LComplexFilterBase.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#ifndef Image_Editor_Complex_FilterBase_h
#define Image_Editor_Complex_FilterBase_h


// Base class for all complex filters
class LComplexFilterBase
{
public:
    // Processes a frame and returns output image
    virtual bool processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame) = 0;
    
protected:
       static void getGray(const cv::Mat& input, cv::Mat& gray);
};

#endif
