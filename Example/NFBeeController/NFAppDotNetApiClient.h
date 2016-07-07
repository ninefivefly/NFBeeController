//
//  NFAppDotNetApiClient.h
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <NFBeeController/NFHTTPSessionManager.h>

@interface NFAppDotNetApiClient : NFHTTPSessionManager

+ (instancetype)sharedClient;

@end
