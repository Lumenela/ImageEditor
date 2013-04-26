//
//  LSliderViewController.h
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 26.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSliderViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *minLabel;
@property (nonatomic, strong) IBOutlet UILabel *maxLabel;
@property (nonatomic, strong) IBOutlet UILabel *currentLabel;
@end
