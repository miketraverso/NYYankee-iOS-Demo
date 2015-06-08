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
        player.lastInitial = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"LastInitial"]];
        player.fullName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FullName"]];
        player.playerID = [[responseObject objectForKey:@"PlayerID"] integerValue];
        player.lastName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"LastName"]];
        player.firstName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FirstName"]];
        player.middleName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"MiddleName"]];
        player.bats = [[responseObject objectForKey:@"Bats"] integerValue];
        player.throws = [[responseObject objectForKey:@"Throws"] integerValue];
        player.teamID = [[responseObject objectForKey:@"TeamID"] integerValue];
        player.birthDate = [Player getBirthdate:[responseObject objectForKey:@"BirthDate"]];
        player.birthCity = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthCity"]];
        player.birthCountry = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthCountry"]];
        player.birthState = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"BirthState"]];
        player.heightInches =[[responseObject objectForKey:@"Height"] integerValue];
        player.weightPounds =[[responseObject objectForKey:@"Weight"] integerValue];
        player.position =[[responseObject objectForKey:@"Position"] integerValue];
        player.number =[[responseObject objectForKey:@"Number"] integerValue];
        player.formalName = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"FormalName"]];
        
        NSString *url = [NSString replaceNullWithEmptyString:[responseObject objectForKey:@"HeadShotURL"]];
        if ([[[url substringWithRange:NSMakeRange(0, 7)] lowercaseString] isEqualToString:@"http://"]) {
            
            player.headShotURL = [NSURL URLWithString:url];
        }
        
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
        return [NSString stringWithFormat:@"%li lbs", (long)_weightPounds];
    }
    return @"Unknown";
}

- (NSString*)getHeight {
    
    if (_heightInches > 0) {
        return [NSString stringWithFormat:@"%li'%li\"", _heightInches / 12, _heightInches % 12];
    }
    return @"Unknown";
}

+ (NSDate*)getBirthdate:(NSString*)birthdate {
    
    NSRange tLocation = [birthdate rangeOfString:@"T"];
    NSString *date = [birthdate substringWithRange:NSMakeRange(0, tLocation.location)];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    dateFormat.dateFormat = @"yyyy-MM-dd";
    return [dateFormat dateFromString:date];
}

- (NSString*)getBirthday {
    
    NSDateFormatter *printableDateFormat = [[NSDateFormatter alloc] init] ;
    printableDateFormat.dateFormat = @"MMM dd, yyyy";
    return [printableDateFormat stringFromDate:_birthDate];
}

#pragma mark - NSCoding

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeInt64:_playerID forKey:@"playerID"];
    [encoder encodeObject:_lastName forKey:@"lastName"];
    [encoder encodeObject:_firstName forKey:@"firstName"];
    [encoder encodeObject:_middleName forKey:@"middleName"];
    [encoder encodeInt64:_bats forKey:@"bats"];
    [encoder encodeInt64:_throws forKey:@"throws"];
    [encoder encodeInt64:_teamID forKey:@"teamID"];
    [encoder encodeObject:_birthDate forKey:@"birthDate"];
    [encoder encodeObject:_birthCity forKey:@"birthCity"];
    [encoder encodeObject:_birthCountry forKey:@"birthCountry"];
    [encoder encodeObject:_birthState forKey:@"birthState"];
    [encoder encodeInt64:_heightInches forKey:@"heightInches"];
    [encoder encodeInt64:_weightPounds forKey:@"weightPounds"];
    [encoder encodeInt64:_position forKey:@"position"];
    [encoder encodeInt64:_number forKey:@"number"];
    [encoder encodeObject:_headShotURL forKey:@"headShotURL"];
    [encoder encodeBool:_isPitcher forKey:@"isPitcher"];
    [encoder encodeObject:_firstInitial forKey:@"firstInitial"];
    [encoder encodeObject:_lastInitial forKey:@"lastInitial"];
    [encoder encodeObject:_fullName forKey:@"fullName"];
    [encoder encodeObject:_formalName forKey:@"formalName"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [[Player alloc] init];
    if (self) {
        
        self.playerID = [decoder decodeInt64ForKey:@"playerID"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.middleName = [decoder decodeObjectForKey:@"middleName"];
        self.bats = [decoder decodeInt64ForKey:@"bats"];
        self.throws = [decoder decodeInt64ForKey:@"throws"];
        self.teamID = [decoder decodeInt64ForKey:@"teamID"];
        self.birthDate = [decoder decodeObjectForKey:@"birthDate"];
        self.birthCity = [decoder decodeObjectForKey:@"birthCity"];
        self.birthState = [decoder decodeObjectForKey:@"birthState"];
        self.birthCountry = [decoder decodeObjectForKey:@"birthCountry"];
        self.heightInches = [decoder decodeInt64ForKey:@"heightInches"];
        self.weightPounds = [decoder decodeInt64ForKey:@"weightPounds"];
        self.position = [decoder decodeInt64ForKey:@"position"];
        self.number = [decoder decodeInt64ForKey:@"number"];
        self.headShotURL = [decoder decodeObjectForKey:@"headShotURL"];
        self.isPitcher = [decoder decodeBoolForKey:@"isPitcher"];
        self.firstInitial = [decoder decodeObjectForKey:@"firstInitial"];
        self.lastInitial = [decoder decodeObjectForKey:@"lastInitial"];
        self.fullName = [decoder decodeObjectForKey:@"fullName"];
        self.formalName = [decoder decodeObjectForKey:@"formalName"];
    }
    
    return self;
}

@end
