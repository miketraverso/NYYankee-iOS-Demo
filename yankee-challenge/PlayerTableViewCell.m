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

    imgBackgroundPlayer.transform = CGAffineTransformMakeScale(0.0, 0.0);
    imgBackgroundPlayer.transform = CGAffineTransformMakeScale(0.0, 0.0);
    imgBackgroundPlayer.alpha = 0.0f;

    imgPlayer.transform = CGAffineTransformMakeScale(0.0, 0.0);
    imgPlayer.transform = CGAffineTransformMakeScale(0.0, 0.0);
    imgPlayer.alpha = 0.0f;

    [imgBackgroundPlayer setImage:[TeamLookupUtility getTeamLogo:(MLBTeamID)player.teamID]];
    
    [UIView animateWithDuration:1.0
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:3.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         imgBackgroundPlayer.transform = CGAffineTransformIdentity;
                         imgBackgroundPlayer.transform = CGAffineTransformIdentity;
                         imgBackgroundPlayer.alpha = 1.0f;
                         
                         imgPlayer.transform = CGAffineTransformIdentity;
                         imgPlayer.transform = CGAffineTransformIdentity;
                         imgPlayer.alpha = 1.0f;
                     }
                     completion:0];
}

- (void)cleanupCell {
    
    lblPosition.text = @"";
    lblName.text = @"";
    imgPlayer.image = 0;
    imgBackgroundPlayer.image = 0;
}

@end
