//
//  NFHTTPSessionManager.m
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFHTTPSessionManager.h"
#import "NFCommon.h"
#import "NFBaseResponse.h"
#import <objc/runtime.h>

@interface MBProgressHUD (Addtion)

@property(nonatomic)NSInteger activityCount;

@end

@implementation MBProgressHUD(Addtion)

+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(show:)), class_getInstanceMethod(self, @selector(nf_show:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(hide:)), class_getInstanceMethod(self, @selector(nf_hide:)));
}

- (NSInteger)activityCount{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setActivityCount:(NSInteger)activityCount{
    objc_setAssociatedObject(self, @selector(activityCount), @(activityCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)nf_show:(BOOL)animated{
    NSAssert([NSThread isMainThread], @"NFProgressHUD needs to be accessed on the main thread.");
    self.activityCount++;
    if (self.activityCount == 1) {
        [self nf_show:animated];
    }
}

- (void)nf_hide:(BOOL)animated{
    NSAssert([NSThread isMainThread], @"NFProgressHUD needs to be accessed on the main thread.");
    self.activityCount--;
    if (self.activityCount <= 0) {
        [self nf_hide:animated];
        self.activityCount = 0;
    }
}

@end

id parseResponse(id response, NSString* className, NSError** error)
{
    NSString * clsName = className;
    if (!clsName.length) {
        if (error) {
            *error = [[NSError alloc]initWithDomain:@"你的类名为空" code:0 userInfo:nil];
        }
        return response;
    }
    
    if ([clsName isEqualToString:@"NSString"] ||
        [clsName isEqualToString:@"NSMutableDictionary"]||
        [clsName isEqualToString:@"NSDictionary"]) {
        return response;
    }
    
    Class cls = NSClassFromString(clsName);
    NSObject *object = [cls new];
    if ([object isKindOfClass:[NFBaseResponse class]]) {
        NFBaseResponse* model = (NFBaseResponse*)object;
        model = [model initWithData:response error:error];
        
        // 检测是否终止转发，例如：登录过期，则需要丢弃改消息，做相应的业务处理
        if (model && ![model isForward]) {
            if (error) {
                *error = [[NSError alloc]initWithDomain:@"用户终止转发" code:0 userInfo:nil];
            }
            return nil;
        }
        
        // 数据预处理，例如：服务器返回错误码，等等
        if (model) {
            if (error) {
                *error = [model preprocess];
            }
        }
        
        return model;
    }else{
        if (error) {
            *error = [NSError errorWithDomain:@"你的类必须继承自NFBaseResponse类型" code:0 userInfo:nil];
        }
        return response;
    }
}

@implementation NFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action {
    [self execute:requester action:action parameters:nil tag:0 formBlock:nil];
}

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(NSDictionary *)parameters {
    [self execute:requester action:action parameters:parameters tag:0 formBlock:nil];
}

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(NSDictionary *)parameters
            tag:(NSInteger)tag {
    [self execute:requester action:action parameters:parameters tag:tag formBlock:nil];
}

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(NSDictionary *)parameters
            tag:(NSInteger)tag
      formBlock:(void (^)(id <AFMultipartFormData> formData))block
{
    if (!requester) {
        return;
    }
    
    UIView *parent  = nil;
    NSString * text = nil;
    NSString * clsName = nil;
    
    // 检查class name
    if ([requester respondsToSelector:@selector(classNameForAction:)]) {
        clsName = [requester classNameForAction:action];
    }
    
    if (!clsName.length) {
        return;
    }
    
    // 获取hud text
    if ([requester respondsToSelector:@selector(textDisplayWhenExecuteAction:)]) {
        text = [requester textDisplayWhenExecuteAction:action];
    }
    
    // 获取hud
    MBProgressHUD *hud = nil;
    if ([requester respondsToSelector:@selector(parentView:)]
        && (parent = [requester parentView:action]))
    {
        if (![MBProgressHUD HUDForView:parent]) {
            if ([requester respondsToSelector:@selector(activityIndicator:)]
                && (hud = [requester activityIndicator:action])) {
                // 显示自定义的hud
                hud.frame = parent.bounds;
                hud.removeFromSuperViewOnHide = YES;
                hud.labelText = text;
            }
        }
    }
    
    // 获取request method
    NFRequestMethod method = NFRequestMethodPost;
    if ([requester respondsToSelector:@selector(customRequestMethodAction:)]) {
        method = [requester customRequestMethodAction:action];
    }
    
    // Request
    [self execute:action
    requestMethod:method
       parameters:parameters
              tag:tag
    customHudView:hud
    hudParentView:parent
     hudLabelText:text
        className:clsName
        formBlock:block
          success:^(id response, NSError *error) {
              [NFHTTPSessionManager sendResponse:requester withAction:action withTag:tag withResponse:response withError:error];
          }
           failed:^(NSError *error) {
               [NFHTTPSessionManager sendResponse:requester withAction:action withTag:tag withResponse:nil withError:error];
           }];
}

+ (void)sendResponse:(__weak id<NFHttpRequester>)requester
          withAction:(NSString*)action
             withTag:(NSInteger)tag
        withResponse:(id)response
           withError:(NSError*)error
{
    if ([requester respondsToSelector:@selector(didExecuteFinish:withAction:withResponse:)]) {
        [requester didExecuteFinish:error withAction:action withResponse:response];
        return;
    }
    
    if ([requester respondsToSelector:@selector(didExecuteFinish:withAction:withTag:withResponse:)]) {
        [requester didExecuteFinish:error withAction:action withTag:tag withResponse:response];
        return;
    }
}

- (void)execute:(NSString *)action
  requestMethod:(NFRequestMethod) method
     parameters:(NSDictionary *)parameters
  hudParentView:(UIView *)parentView
   hudLabelText:(NSString *)hudText
      className:(NSString *)className
        success:(void (^)(id, NSError*)) success
         failed:(void (^)(NSError*)) failed
{
    [self execute:action requestMethod:method parameters:parameters tag:0 customHudView:nil hudParentView:parentView hudLabelText:hudText className:className formBlock:nil success:success failed:failed];
}

- (void)execute:(NSString *)action
  requestMethod:(NFRequestMethod) method
     parameters:(NSDictionary *)parameters
            tag:(NSInteger)tag
  customHudView:(MBProgressHUD *)customHudView
  hudParentView:(UIView *)parentView
   hudLabelText:(NSString *)hudText
      className:(NSString *)className
      formBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(id, NSError*)) success
         failed:(void (^)(NSError*)) failed
{
    // 显示hud
    MBProgressHUD* hudView = nil;
    if (parentView) {
        hudView = [MBProgressHUD HUDForView:parentView];
        if (hudView) {
            [hudView show:YES];
        } else {
            if (customHudView) {
                // 显示自定义的hud
                customHudView.frame = parentView.bounds;
                customHudView.removeFromSuperViewOnHide = YES;
                customHudView.labelText = hudText;
                [parentView addSubview:customHudView];
                [customHudView show:YES];
                hudView = customHudView;
            } else {
                // 构造一个默认的hud
                hudView = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
                hudView.labelText = hudText;
            }
        }
    }
    
    void (^sucessBlock)(NSURLSessionDataTask *operation, id responseObject) = ^(NSURLSessionDataTask *operation, id responseObject)
    {
        NFLogDebug(@"<----------%@\n%@", operation.response, [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [hudView hide:YES];
        if (success) {
            NSError* error = nil;
            id model = parseResponse(responseObject, className, &error);
            success(model, error);
        }
        return ;
    };
    
    void (^failedBlock)(NSURLSessionDataTask *operation, NSError *error) = ^(NSURLSessionDataTask *operation, NSError *error)
    {
        NFLogDebug(@"<----------%@\n%@", operation.response.URL, error);
        [hudView hide:YES];
        if (failed) {
            failed(error);
        }
        return ;
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSessionDataTask *task = nil;
        switch (method) {
            case NFRequestMethodPost:
                if (block) {
                    task = [super POST:action parameters:parameters constructingBodyWithBlock:block progress:nil success:sucessBlock failure:failedBlock];
                } else {
                    task = [super POST:action parameters:parameters progress:nil success:sucessBlock failure:failedBlock];
                }
                break;
            case NFRequestMethodGet:
                task = [super  GET:action parameters:parameters progress:nil success:sucessBlock failure:failedBlock];
                break;
            default:
                break;
        }
        
        if (task) {
            NFLogDebug(@"---------->%@ %@%@%@", task.originalRequest.HTTPMethod,
                       task.originalRequest.URL,
                       task.originalRequest.allHTTPHeaderFields,
                       task.originalRequest.HTTPBody? [[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding] : task.originalRequest.HTTPBodyStream ?: @"");
        }
    });
}

@end

