//
//  LComplexFilterFacade.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LComplexFilterBase.h"

@interface LComplexFilterFacade : NSObject

- (id) initWithSample:(LComplexFilterBase *)complexFilter;

- (UIImage*) processFrame:(UIImage*) source;

@end
