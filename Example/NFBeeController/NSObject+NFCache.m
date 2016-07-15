//
//  NSObject+NFCache.m
//  NFBeeController
//
//  Created by jiangpengcheng on 11/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NSObject+NFCache.h"

@implementation NSObject(NFUserDefaults)

//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    [super encodeWithCoder:coder];
//    ;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        ;
//    }
//    return self;
//}
//
//- (void)saveAsUserDefaultWithKey:(NSString *)key{
//    if (!key.length) {
//        return ;
//    }
//    [NSUserDefaults standardUserDefaults]
//    
//}
//
//
//
//+ (id)userDefaultsRead:(NSString *)key
//{
//    if ( nil == key )
//        return nil;
//    
//    key = [self persistenceKey:key];
//    
//    return [[PHUserDefaults sharedInstance] objectForKey:key];
//}
//
//+ (void)userDefaultsWrite:(id)value forKey:(NSString *)key
//{
//    if ( nil == key || nil == value )
//        return;
//    
//    key = [self persistenceKey:key];
//    
//    [[PHUserDefaults sharedInstance] setObject:value forKey:key];
//}
//
//+ (void)userDefaultsRemove:(NSString *)key
//{
//    if ( nil == key )
//        return;
//    
//    key = [self persistenceKey:key];
//    
//    [[PHUserDefaults sharedInstance] removeObjectForKey:key];
//}
//
//- (id)userDefaultsRead:(NSString *)key
//{
//    return [[self class] userDefaultsRead:key];
//}
//
//- (void)userDefaultsWrite:(id)value forKey:(NSString *)key
//{
//    [[self class] userDefaultsWrite:value forKey:key];
//}
//
//- (void)userDefaultsRemove:(NSString *)key
//{
//    [[self class] userDefaultsRemove:key];
//}
//
//+ (id)readObject
//{
//    return [self readObjectForKey:nil];
//}
//
//+ (id)readObjectForKey:(NSString *)key
//{
//    key = [self persistenceKey:key];
//    
//    id value = [[PHUserDefaults sharedInstance] objectForKey:key];
//    if ( value )
//    {
//        return value;
//    }
//    
//    return nil;
//}
//
//+ (void)saveObject:(id)obj
//{
//    [self saveObject:obj forKey:nil];
//}
//
//+ (void)saveObject:(id)obj forKey:(NSString *)key
//{
//    if ( nil == obj )
//        return;
//    
//    key = [self persistenceKey:key];
//    
//    if (obj) {
//        [[PHUserDefaults sharedInstance] setObject:obj forKey:key];
//    }else {
//        [[PHUserDefaults sharedInstance] removeObjectForKey:key];
//    }
//}
//
//+ (void)removeObject
//{
//    [self removeObjectForKey:nil];
//}
//
//+ (void)removeObjectForKey:(NSString *)key
//{
//    key = [self persistenceKey:key];
//    
//    [[PHUserDefaults sharedInstance] removeObjectForKey:key];
//}

@end
