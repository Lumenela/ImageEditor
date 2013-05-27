//
//  LFilterFactory.h
//  ImageEditor
//
//  Created by Sveta Dedunovich on 5/27/13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFilter.h"

#define DEFAULT_FILTERNAME @"Default filter"
#define ADD_WHITE_FILTERNAME @"Add white"
#define SUBTRACT_WHITE_FILTERNAME @"Subtract white"
#define NORMAL_FILTERNAME @"Normal"
#define NEGATIVE_FILTERNAME @"Negative"

@interface LFilterFactory : NSObject

+ (LFilter *)filterByName:(NSString *)filterName;

@end
