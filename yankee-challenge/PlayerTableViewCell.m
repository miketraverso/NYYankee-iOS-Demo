//
//  PlayerTableViewCell.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "PlayerTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TeamLookupUtility.h"

@interface PlayerTableViewCell () {
    
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblPosition;
    IBOutlet UIImageView *imgBackgroundPlayer;
    IBOutlet UIImageView *imgPlayer;
}
@end

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    
    imgBackgroundPlayer.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
}

- (void) setupPlayerCell:(Player*)player {
    
    [self cleanupCell];
    
    if (player.formalName && ![player.formalName isEqualToString:@""]) {
        
        [lblName setText:player.formalName];
    }
    else {
        
        [lblName setText:[NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName]];
    }
    
    if (player.headShotURL) {
        
        [imgPlayer setImageWithURL:player.headShotURL];
    }
    
    [lblPosition setText:[player getPositionName]];
    [imgBackgroundPlayer setImage:[TeamLookupUtility getTeamLogo:(MLBTeamID)player.teamID]];
}

- (void)cleanupCell {
    
    lblPosition.text = @"";
    lblName.text = @"";
    imgPlayer.image = 0;
    imgBackgroundPlayer.image = 0;
}

@end
