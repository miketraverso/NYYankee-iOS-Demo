//
//  TeamLookupUtility.h
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum MLBTeamID {
    ANA = 108,
    ARI,
    BAL,
    BOS,
    CHN,
    CIN,
    CLE,
    COL,
    DET,
    HOU,
    KCA,
    LAN,
    WAS,
    NYN,
    OAK = 133,
    PIT,
    SDN,
    SEA,
    SFN,
    SLN,
    TBA,
    TEX,
    TOR,
    MIN,
    PHI,
    ATL,
    CHA,
    MIA,
    NYA,
    MIL = 158
} MLBTeamID;

@interface TeamLookupUtility : NSObject

+ (NSString*)getTeamAbbr:(MLBTeamID)teamID;
+ (UIImage*)getTeamLogo:(MLBTeamID)teamID;
+ (UIImage*)getTeamLogoLarge:(MLBTeamID)teamID;
@end
