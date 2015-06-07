//
//  TeamTableViewCell.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "TeamTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TeamLookupUtility.h"

@interface TeamTableViewCell () {
    
    IBOutlet UILabel *lblTeamName;
    IBOutlet UIImageView *imgTeam;
    IBOutlet UIImageView *imgTeamBackground;
}
@end

@implementation TeamTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setupTeamCell:(Team*)team {
    
    [self cleanupCell];
    
    if (team.fullName && ![team.fullName isEqualToString:@""]) {
        [lblTeamName setText:team.fullName];
    }

    [imgTeam setImage:[TeamLookupUtility getTeamLogo:(MLBTeamID)team.teamID]];
    [imgTeamBackground setImage:[TeamLookupUtility getTeamLogoLarge:(MLBTeamID)team.teamID]];
}

- (void)cleanupCell {
    
    lblTeamName.text = @"";
    imgTeam.image = 0;
    imgTeamBackground.image = 0;
}

@end
