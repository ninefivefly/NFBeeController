//
//  NFBaseResponse.h
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NFBaseResponse : JSONModel

/**
 *  是否转发
 *
 *  @return 返回yes，则允许转发，返回no，则终止转发
 */
- (BOOL)isForward;

/**
 *  对数据进行预处理
 *
 *  @return 
 */
- (NSError *)preprocess;

@end
