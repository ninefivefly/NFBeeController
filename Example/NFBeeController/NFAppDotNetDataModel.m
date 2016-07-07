//
//  NFAppDotNetDataModel.m
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFAppDotNetDataModel.h"

@implementation NFAppDotNetResponse
@end

@implementation NFPost
@end

@implementation NFUser

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"avatar_image.url": @"avatar_image"}];
}

@end