//
//  NFBaseTableViewCell.h
//  NFBeeController
//
//  Created by jiangpengcheng on 8/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <UIKit/UIKit.h>

// TableView Cell的消息路由有两种方式
// 1. 设置代理，实现`- (void)postMessage:(NSDictionary *)userInfo`
// 2. 通过响应链传递消息，`- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;`

@protocol NFBaseTableViewCellDelegate <NSObject>

@optional
- (void)postMessage:(NSDictionary *)userInfo;

@end

@interface NFBaseTableViewCell : UITableViewCell

/**
 *  TableView Cell的数据模型
 *  可以在setter方法里面，对cell进行初始化
 */
@property(nonatomic)id model;

/**
 *  设置代理
 */
@property(nonatomic, weak)id<NFBaseTableViewCellDelegate> delegate;

/**
 *  根据model返回cell的高度, 默认44
 *
 *  @param model
 *
 *  @return
 */
+ (CGFloat)cellHeightWithModel:(id)model;

@end
