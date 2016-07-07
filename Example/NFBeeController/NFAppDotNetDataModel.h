//
//  NFAppDotNetDataModel.h
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NFBaseResponse.h"

@interface NFUser : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *avatar_image;

@end

@protocol  NFPost @end
@interface NFPost : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *text;
@property (nonatomic) NFUser *user;

@end

@interface NFAppDotNetResponse : NFBaseResponse

@property(nonatomic)NSArray<NFPost> *data;

@end


