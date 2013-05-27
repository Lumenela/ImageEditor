//
//  LComplexFilterBase.cpp
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#include "LComplexFilterBase.h"
#include "cvneon.h"
#include <iostream>

void LComplexFilterBase::getGray(const cv::Mat& input, cv::Mat& gray)
{
    const int numChannes = input.channels();

    if (numChannes == 4)
    {
#if TARGET_IPHONE_SIMULATOR
        cv::cvtColor(input, gray, CV_BGRA2GRAY);
        //#else
        //cv::neon_cvtColorBGRA2GRAY(input, gray);
#endif

    }
    else if (numChannes == 3)
    {
        cv::cvtColor(input, gray, CV_BGR2GRAY);
    }
    else if (numChannes == 1)
    {
        gray = input;
    }
}

