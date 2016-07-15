//
//  UIResponder+NFRouter.m
//  NFBeeController
//
//  Created by jiangpengcheng on 8/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "UIResponder+NFRouter.h"

@implementation UIResponder (NFRouter)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
