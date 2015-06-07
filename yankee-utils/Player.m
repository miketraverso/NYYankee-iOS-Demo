//
//  Player.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "Player.h"
#import "NSString+Utils.h"

@implementation Player

+ (instancetype)setupPlayerWithResponse:(id)responseObject {
    
    Player *player = [[Player alloc] init];
    if (player) {
        
        player.firstInitial = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FirstInitial"]];
        player.playerID = [[responseObject objectForKey:@"PlayerID"] integerValue];
        player.lastName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"LastName"]];
        player.firstName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FirstName"]];
        player.middleName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"MiddleName"]];
        player.bats = [[responseObject objectForKey:@"Bats"] integerValue];
        player.throws = [[responseObject objectForKey:@"Throws"] integerValue];
        player.teamID = [[responseObject objectForKey:@"TeamID"] integerValue];
        player.birthDate = [responseObject objectForKey:@"BirthDate"];
        player.birthCity = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthCity"]];
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthCountry"]];
        player.birthState = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthState"]];
        player.heightInches =[[responseObject objectForKey:@"Height"] integerValue];
        player.weightPounds =[[responseObject objectForKey:@"Weight"] integerValue];
        player.position =[[responseObject objectForKey:@"Position"] integerValue];
        player.number =[[responseObject objectForKey:@"Number"] integerValue];
        
        NSString *url = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"HeadShotURL"]];
        if ([[[url substringWithRange:NSMakeRange(0, 7)] lowercaseString] isEqualToString:@"http://"]) {
            
            player.headShotURL = [NSURL URLWithString:url];
        }
        
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FirstInitial"]];
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"LastInitial"]];
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FullName"]];
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FormalName"]];
        player.isPitcher = [[responseObject objectForKey:@"IsPitcher"] boolValue];
    }

    return player;
}

- (NSString*)getPositionName {
    
    switch (_position) {
        case 1:
            return @"Pitcher";
            break;
        case 2:
            return @"Catcher";
            break;
        case 3:
            return @"First Baseman";
            break;
        case 4:
            return @"Second Baseman";
            break;
        case 5:
            return @"Third Baseman";
            break;
        case 6:
            return @"Shortstop";
            break;
        case 7:
            return @"Left Fielder";
            break;
        case 8:
            return @"Center Fielder";
            break;
        case 9:
            return @"Right Fielder";
            break;
        default:
            return @"Unknown";
            break;
    }
}

- (NSString*)getWeight {
    
    if (_weightPounds > 0) {
        return [NSString stringWithFormat:@"%li lbs", _weightPounds];
    }
    return @"Unknown";
}

- (NSString*)getHeight {
    
    if (_heightInches > 0) {
        return [NSString stringWithFormat:@"%li'%li\"", _heightInches / 12, _heightInches % 12];
    }
    return @"Unknown";
}
    
@end
