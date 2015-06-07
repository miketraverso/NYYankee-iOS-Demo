//
//  HttpClient.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/5/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "HttpClient.h"
#import "Team.h"
#import "Player.h"

@implementation HttpClient

static HttpClient* __sharedClient = nil;

+ (instancetype)sharedClient {
    
    if (!__sharedClient) {
    
        NSString *serverString = @"http://yankeesapplicant.azurewebsites.net/api/";
        __sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:serverString]];
    };
    
    return __sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        [AppHelpers logToConsole:[NSString stringWithFormat:@"ThingToBring Server Reachability: %@", AFStringFromNetworkReachabilityStatus(status)]];
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // Our connection is fine
                // Resume our requests or do nothing
                [__sharedClient.operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
            {
                //not reachable
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                                message:@"Please check your Internet connection and try again."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
                //[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                
                [__sharedClient.operationQueue setSuspended:YES];
            }
                break;
        }
    }];
    [self.reachabilityManager startMonitoring];
    
    
    if (self) {

        self.operationQueue.maxConcurrentOperationCount = 15;
    }
    return self;
}

- (void)searchPlayers:(NSString*)parameterString
           completion:(void (^)(NSInteger, NSMutableArray *, NSError *))callback {
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];

    [self GET:[NSString stringWithFormat:@"player?criteria=%@", parameterString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObjects) {
                  
        for (id responseObject in responseObjects) {
            
            Player *player = [Player setupPlayerWithResponse:responseObject];
            [results addObject:player];
        }
        if (callback) {
            
            callback([operation.response statusCode], results, nil);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (callback) {
              
            callback([operation.response statusCode], results, error);
        }
    }];
}

- (void)getTeamRosterWithTeamId:(NSInteger)teamID
                     completion:(void (^)(NSInteger, NSMutableArray *, NSError *))callback {
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self GET:[NSString stringWithFormat:@"team/%i/roster", teamID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObjects) {
        
        for (id responseObject in responseObjects) {
            
            Player *player = [Player setupPlayerWithResponse:responseObject];
            [results addObject:player];
        }
        if (callback) {
            
            callback([operation.response statusCode], results, nil);
        }
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          if (callback) {
              
              callback([operation.response statusCode], results, error);
          }
      }];
}

- (void)getTeamsWithCompletion:(void (^)(NSInteger, NSMutableArray *, NSError *))callback {
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self GET:@"team" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObjects) {
        
        for (id responseObject in responseObjects) {
            
            Team *team = [Team setupTeamWithResponse:responseObject];
            [results addObject:team];
        }
        if (callback) {
            
            callback([operation.response statusCode], results, nil);
        }
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          if (callback) {
              
              callback([operation.response statusCode], results, error);
          }
      }];
}


@end
