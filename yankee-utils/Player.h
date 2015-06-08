//
//  Player.h
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject <NSCoding>

@property (nonatomic) NSInteger playerID;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* middleName;
@property (nonatomic) NSInteger bats;
@property (nonatomic) NSInteger throws;
@property (nonatomic) NSInteger teamID;
@property (nonatomic, strong) NSDate* birthDate;
@property (nonatomic, strong) NSString* birthCity;
@property (nonatomic, strong) NSString* birthCountry;
@property (nonatomic, strong) NSString* birthState;
@property (nonatomic) NSInteger heightInches;
@property (nonatomic) NSInteger weightPounds;
@property (nonatomic) NSInteger position;
@property (nonatomic) NSInteger number;
@property (nonatomic, strong) NSURL* headShotURL;
@property (nonatomic) BOOL isPitcher;
@property (nonatomic, strong) NSString* firstInitial;
@property (nonatomic, strong) NSString* lastInitial;
@property (nonatomic, strong) NSString* fullName;
@property (nonatomic, strong) NSString* formalName;

+ (instancetype)setupPlayerWithResponse:(id)responseObject;
- (NSString*)getPositionName;
- (NSString*)getHeight;
- (NSString*)getWeight;
- (NSString*)getBirthday;
@end
