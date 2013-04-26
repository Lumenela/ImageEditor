//
//  LSliderViewController.m
//  ImageEditor
//
//  Created by Svetlana Dedunovich on 26.04.13.
//  Copyright (c) 2013 Lumenela. All rights reserved.
//

#import "LSliderViewController.h"

@interface LSliderViewController ()

@end

@implementation LSliderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LSliderViewController" owner:self options:nil];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LSliderViewController" owner:self options:nil];
    //self = nib[0];
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
