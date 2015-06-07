//
//  Team.h
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (nonatomic) NSInteger teamID;
@property (nonatomic) NSInteger leagueID;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* abbreviation;
@property (nonatomic, strong) NSString* teamName;
@property (nonatomic, strong) NSString* fullName;

+ (instancetype)setupTeamWithResponse:(id)responseObject;

@end
