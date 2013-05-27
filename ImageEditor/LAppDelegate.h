//
//  LAppDelegate.h
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 25.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFilterEngine.h"

#define ApplicationDelegate ((LAppDelegate *)[UIApplication sharedApplication].delegate)
#define ImageFilterAppliedNotificationName @"ImageFilterApplied"

@interface LAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<LFilterEngine> filterEngine;

@end
