//
//  NFCommon.h
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#ifndef NFCommon_h
#define NFCommon_h

//获取系统版本
#define VERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:CFBundleVersion]

#define NFDefaultImage(size) NFFixedImage([UIImage imageNamed:@"icon_warehouse_default"], size)

#define kOnePixel 1/[UIScreen mainScreen].scale

#define PerformSelector(sender, selector)\
    ((void (*)(id, SEL))[sender methodForSelector:selector])(sender, selector)

#define PerformSelectorWithObj(sender, selector, obj)\
    ((void (*)(id, SEL, id))[sender methodForSelector:selector])(sender, selector, obj)\

// Add View Constraint Macro
#define AddConstraintBase(super, view1, attr1, relation, view2, attr2, multi, cons) \
    [super addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multi constant:cons]]

#define AddConstraint(super, view1, attr1, view2, attr2, cons) \
    AddConstraintBase(super, view1, attr1, NSLayoutRelationEqual, view2, attr2, 1, cons)

#define AddConstraintToSuper(super, view1, attr1, cons) \
    AddConstraint(super, view1, attr1, super, attr1, cons)

#define AddConstraintToSelf(self, attr, cons) \
    AddConstraint(self, self, attr, nil, 0, cons)

#define ClassImplementation(class) \
    @implementation class\
    @end

// Add UIColor Macro
#define UI_COLOR_RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define UI_COLOR_RGB(r,g,b)      UI_COLOR_RGBA(r,g,b,1)

#define UIColorFromRGBA(rgbValue, alpha) \
    UI_COLOR_RGBA(((float)((rgbValue & 0xFF0000) >> 16)), ((float)((rgbValue & 0xFF00) >> 8)), ((float)(rgbValue & 0xFF)), alpha)

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1)

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

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define NF_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
    #define NF_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define NF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero
#else
    #define NF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero
#endif

#define NF_DEFAULT_MULTILINE_TEXTSIZE(text, fontSize, width) \
    NF_MULTILINE_TEXTSIZE(text, [UIFont systemFontOfSize:fontSize], CGSizeMake((width), MAXFLOAT), NSLineBreakByWordWrapping)

#define NF_DEFAULT_TEXT_HEIGHT(text, fontSize, width) \
    (NF_DEFAULT_MULTILINE_TEXTSIZE(text, fontSize, width)).height

#endif /* NFCommon_h */
