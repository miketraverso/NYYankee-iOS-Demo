//
//  TeamLookupUtility.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "TeamLookupUtility.h"

@implementation TeamLookupUtility

+ (NSString*)getTeamAbbr:(MLBTeamID)teamID {
    
    NSString *teamLogo = @"";
    switch (teamID) {
            
        case ANA:
            teamLogo = @"ANA";
            break;
            
        case ARI:
            teamLogo = @"ARI";
            break;
            
        case BAL:
            teamLogo = @"BAL";
            break;
            
        case BOS:
            teamLogo = @"BOS";
            break;
            
        case CHA:
            teamLogo = @"CHA";
            break;
            
        case CHN:
            teamLogo = @"CHN";
            break;
            
        case CIN:
            teamLogo = @"CIN";
            break;
            
        case CLE:
            teamLogo = @"CLE";
            break;
            
        case COL:
            teamLogo = @"COL";
            break;
            
        case ATL:
            teamLogo = @"ATL";
            break;
            
        case DET:
            teamLogo = @"DET";
            break;
            
        case HOU:
            teamLogo = @"HOU";
            break;
            
        case KCA:
            teamLogo = @"KCA";
            break;
            
        case LAN:
            teamLogo = @"LAN";
            break;
            
        case MIA:
            teamLogo = @"MIA";
            break;
            
        case MIL:
            teamLogo = @"MIL";
            break;
            
        case MIN:
            teamLogo = @"MIN";
            break;
            
        case NYA:
            teamLogo = @"NYA";
            break;
            
        case NYN:
            teamLogo = @"NYN";
            break;
            
        case OAK:
            teamLogo = @"OAK";
            break;
            
        case PHI:
            teamLogo = @"PHI";
            break;
            
        case PIT:
            teamLogo = @"PIT";
            break;
            
        case SDN:
            teamLogo = @"SDN";
            break;
            
        case SEA:
            teamLogo = @"SEA";
            break;
            
        case SFN:
            teamLogo = @"SFN";
            break;
            
        case SLN:
            teamLogo = @"SLN";
            break;
            
        case TBA:
            teamLogo = @"TBA";
            break;
            
        case TEX:
            teamLogo = @"TEX";
            break;
            
        case TOR:
            teamLogo = @"TOR";
            break;
            
        case WAS:
            teamLogo = @"WAS";
            break;
            
        default:
            break;
    }
    
    return teamLogo;
}

+ (UIImage*)getTeamLogo:(MLBTeamID)teamID {
    
    NSString *teamAbbr = [TeamLookupUtility getTeamAbbr:teamID];
    if (teamAbbr && ![teamAbbr isEqualToString:@""]) {
        return [UIImage imageNamed:teamAbbr];
    }
    return 0;
}

+ (UIImage*)getTeamLogoLarge:(MLBTeamID)teamID {
    
    NSString *teamAbbr = [TeamLookupUtility getTeamAbbr:teamID];
    if (teamAbbr && ![teamAbbr isEqualToString:@""]) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@-lg",teamAbbr]];
    }
    return 0;
}

@end
