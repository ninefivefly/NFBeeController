//
//  NFLog.h
//  NFBeeController
//
//  Created by jiangpengcheng on 11/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#ifndef NFLog_h
#define NFLog_h

// Add Log Macro
#define NFLog(FORMAT, ...) NSLog([NSString stringWithFormat:@"[%s:%d]%@", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, FORMAT], ## __VA_ARGS__, nil);

#define LogLevelVerbose     1
#define LogLevelDebug       2
#define LogLevelInfo        3
#define LogLevelError       4
#define LogLevelHigh        5

#ifdef DEBUG
    #define LogLevel LogLevelVerbose
#else
    #define LogLevel LogLevelHigh
#endif

#if (LogLevel >= LogLevelHigh)
    #define NFLogError(FORMAT, ...)
    #define NFLogInfo(FORMAT, ...)
    #define NFLogDebug(FORMAT, ...)
    #define NFLogVerbose(FORMAT, ...)
#elif (LogLevel >= LogLevelError)
    #define NFLogError(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogInfo(FORMAT, ...)
    #define NFLogDebug(FORMAT, ...)
    #define NFLogVerbose(FORMAT, ...)
#elif (LogLevel >= LogLevelInfo)
    #define NFLogError(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogInfo(FORMAT, ...)      NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogDebug(FORMAT, ...)
    #define NFLogVerbose(FORMAT, ...)
#elif (LogLevel >= LogLevelDebug)
    #define NFLogError(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogInfo(FORMAT, ...)      NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogDebug(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogVerbose(FORMAT, ...)
#elif (LogLevel >= LogLevelVerbose)
    #define NFLogError(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogInfo(FORMAT, ...)      NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogDebug(FORMAT, ...)     NFLog(FORMAT, ##__VA_ARGS__)
    #define NFLogVerbose(FORMAT, ...)   NFLog(FORMAT, ##__VA_ARGS__)
#endif

#endif /* NFLog_h */
