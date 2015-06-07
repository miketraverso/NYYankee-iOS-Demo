//
//  Team.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "Team.h"
#import "NSString+Utils.h"

@implementation Team

+ (instancetype)setupTeamWithResponse:(id)responseObject {
    
    Team *team = [[Team alloc] init];
    if (team) {
        
        team.city = [responseObject objectForKey:@"City"];
        team.abbreviation = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"Abbr"]];
        team.teamName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"Name"]];
        team.fullName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FullName"]];
        team.teamID =[[responseObject objectForKey:@"TeamID"] integerValue];
        team.leagueID =[[responseObject objectForKey:@"LeagueID"] integerValue];
    }
    
    return team;
}

@end
