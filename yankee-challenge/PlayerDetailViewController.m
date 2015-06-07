//
//  PlayerDetailViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "Player.h"
#import "UIImageView+AFNetworking.h"

@interface PlayerDetailViewController () {

    Player *_player;
    IBOutlet UIImageView *imgPlayer;
    IBOutlet UILabel *lblPlayerName;
    IBOutlet UILabel *lblPosition;
    IBOutlet UILabel *lblBats;
    IBOutlet UILabel *lblWeight;
    IBOutlet UILabel *lblBIrthdate;
    IBOutlet UILabel *lblHometown;
    IBOutlet UILabel *lblThrows;
    IBOutlet UILabel *lblHeight;
    IBOutlet UILabel *lblJerseyNumber;
    
    IBOutlet UIView *imgPitcher;
    IBOutlet UIView *imgCatcher;
    IBOutlet UIView *imgFirst;
    IBOutlet UIView *imgSecond;
    IBOutlet UIView *imgThird;
    IBOutlet UIView *imgShort;
    IBOutlet UIView *imgLeft;
    IBOutlet UIView *imgCenter;
    IBOutlet UIView *imgRight;
    
    IBOutletCollection(UIView) NSArray *imgFieldPosIndicators;
}

@end

@implementation PlayerDetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"Player Details";
    
    for (UIView *indicator in imgFieldPosIndicators) {

        indicator.hidden = YES;
        indicator.layer.cornerRadius = indicator.bounds.size.width / 2;
        indicator.layer.masksToBounds = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)setPlayer:(Player*)player {

    _player = player;
}

- (void)updateUI {
    
    if (_player) {
        
        if (_player.formalName && ![_player.formalName isEqualToString:@""]) {
            
            [lblPlayerName setText:_player.formalName];
        }
        else {
            
            [lblPlayerName setText:[NSString stringWithFormat:@"%@ %@", _player.firstName, _player.lastName]];
        }
        
        if (_player.headShotURL) {
            
            [imgPlayer setImageWithURL:_player.headShotURL];
        }
        
        [lblPosition setText:[_player getPositionName]];
        [lblWeight setText:[NSString stringWithFormat:@"Weight: %@",[_player getWeight]]];
        [lblHeight setText:[NSString stringWithFormat:@"Height: %@",[_player getHeight]]];

        [lblHometown setText:[NSString stringWithFormat:@"Hometown: %@, %@ %@", _player.birthCity, _player.birthState, _player.birthCountry]];
        
        switch (_player.bats) {

            case 1:
                [lblBats setText:@"Bats: RIGHT"];
                break;
            case 2:
                [lblBats setText:@"Bats: LEFT"];
                break;
            case 3:
                [lblBats setText:@"Bats: SWITCH"];
                break;
            default:
                [lblBats setText:@"Bats: UNKNOWN"];
                break;
        }

        switch (_player.throws) {
                
            case 1:
                [lblThrows setText:@"Throws: RIGHT"];
                break;
            case 2:
                [lblThrows setText:@"Throws: LEFT"];
                break;
            case 3:
                [lblThrows setText:@"Throws: SWITCH"];
                break;
            default:
                [lblThrows setText:@"Throws: UNKNOWN"];
                break;
        }

        switch (_player.position) {
            case 1:
                imgPitcher.hidden = NO;
                break;
            case 2:
                imgCatcher.hidden = NO;
                break;
            case 3:
                imgFirst.hidden = NO;
                break;
            case 4:
                imgSecond.hidden = NO;
                break;
            case 5:
                imgThird.hidden = NO;
                break;
            case 6:
                imgShort.hidden = NO;
                break;
            case 7:
                imgLeft.hidden = NO;
                break;
            case 8:
                imgCenter.hidden = NO;
                break;
            case 9:
                imgRight.hidden = NO;
                break;
                
            default:
                break;
        }
        
        if (_player.number > 0) {
            
            [lblJerseyNumber setText:[NSString stringWithFormat:@"%i", _player.number]];
        }
    }
}

@end
