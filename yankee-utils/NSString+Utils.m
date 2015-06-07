//
//  NSString+Utils.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+ (NSString*)replaceNullWithEmptyString:(NSString*)input {
    
    if ([input isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return input;
}
@end
