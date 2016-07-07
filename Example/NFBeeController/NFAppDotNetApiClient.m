//
//  NFAppDotNetApiClient.m
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFAppDotNetApiClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation NFAppDotNetApiClient

+ (instancetype)sharedClient {
    static NFAppDotNetApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NFAppDotNetApiClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


@end
