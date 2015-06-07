//
//  HttpClient.h
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/5/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface HttpClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

- (void)searchPlayers:(NSString*)parameterString
           completion:(void (^)(NSInteger, NSMutableArray *, NSError *))callback;
- (void)getTeamsWithCompletion:(void (^)(NSInteger, NSMutableArray *, NSError *))callback;

@end
