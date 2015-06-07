//
//  PlayerDetailViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "PlayerDetailViewController.h"

@interface PlayerDetailViewController () {

    Player *_player;
}

@end

@implementation PlayerDetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"Player Details";
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)setPlayer:(Player*)player {

    _player = player;
}

@end
