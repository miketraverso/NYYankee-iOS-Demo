//
//  SplashViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/7/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController () {
    
    IBOutlet NSLayoutConstraint *constraintImage;
    IBOutlet UIImageView *imgBackground;
}

@end

@implementation SplashViewController

- (void)viewDidLoad {

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self animateSplash];
}

#pragma mark - Animation

- (void)animateSplash {
    
    constraintImage.constant = -40;
    [UIView animateWithDuration:4.0f
                          delay:0.5f
                        options:0
                     animations:^{
                         
                         [imgBackground layoutIfNeeded];
                         
                     } completion:^(BOOL finished) {
                         
                         [self performSegueWithIdentifier:BaseTabBarControllerIdentifier sender:nil];
                     }];
}

@end
