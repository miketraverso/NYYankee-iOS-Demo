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
    
    UIBarButtonItem *favoriteButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(favoritePressed)];
    self.navigationItem.rightBarButtonItem = favoriteButtonItem;
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
        [lblBIrthdate setText:[NSString stringWithFormat:@"Birthday: %@",[_player getBirthday]]];
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
            
            [lblJerseyNumber setText:[NSString stringWithFormat:@"%li", (long)_player.number]];
        }
        
        UIView *indicatorToFlash = 0;
        for (UIView *indicator in imgFieldPosIndicators) {
            
            if (!indicator.hidden) {
                
                indicatorToFlash = indicator;
                break;
            }
        }
        
        indicatorToFlash.transform = CGAffineTransformMakeScale(0.0, 0.0);
        indicatorToFlash.transform = CGAffineTransformMakeScale(0.0, 0.0);

        [UIView animateWithDuration:1.0f
                              delay:0.0f
                            options:0
                         animations:^{
                             
                            indicatorToFlash.transform = CGAffineTransformIdentity;
                            indicatorToFlash.transform = CGAffineTransformIdentity;
                         }
                         completion:0];
    }
}

#pragma mark - Button handling

- (IBAction)favoritePressed {
    
    NSData *favoriteData = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlayers"];
    if (favoriteData == nil) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSArray arrayWithObject:_player]];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"favoritePlayers"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        
        NSArray *favoritePlayers = [NSKeyedUnarchiver unarchiveObjectWithData:favoriteData];
        NSMutableArray *newFavorites = [NSMutableArray arrayWithArray:favoritePlayers];
        [newFavorites addObject:_player];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newFavorites];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"favoritePlayers"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [[[UIAlertView alloc] initWithTitle:@"Favorited!" message:[NSString stringWithFormat:@"%@ added to your favorite players.", _player.fullName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:0, nil] show];
}

@end
