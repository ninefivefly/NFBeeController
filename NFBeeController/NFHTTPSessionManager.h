//
//  NFHTTPSessionManager.h
//  NFBeeController
//
//  Created by jiangpengcheng on 1/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "NFBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NFHttpRequester <NSObject>

typedef NS_ENUM(NSInteger, NFRequestMethod) {
    NFRequestMethodPost = 0,
    NFRequestMethodGet
};

@required

/**
 *  根据特定的接口action返回特定的类名，该方法必须实现。
 *  你可以返回的类型包含nil 、NSString、NSDictionary、NSMutableDictionary
 *  以及任何继承自NFBaseResponse的类型
 *
 *  @param action
 *
 *  @return
 */
- (NSString *)classNameForAction:(NSString *)action;

@optional

/**
 *  根据Action返回加载HUD的父类
 *
 *  @param action 接口url
 *
 *  @return 返回nil,则不显示HUD
 */
- (nullable UIView*)parentView:(NSString *)action;

/**
 *  根据Action返回自定义的HUD
 *
 *  @param action
 *
 *  @return
 */
- (MBProgressHUD *)activityIndicator:(NSString *)action;

/**
 *  返回加载特定action时对话框中显示的文本信息
 *
 *  @param action
 *
 *  @return
 */
- (NSString *)textDisplayWhenExecuteAction:(NSString *)action;

/**
 指定请求服务器的接口类型,默认情况下为 `InterfaceTypeBase`
 @param action http请求时用到的action
 */
//- (InterfaceType)customTypeForAction:(NSString*)action;

/**
 *  根据Action返回Request的方法，例如：GET， POST，默认返回POST
 *
 *  @param action
 *
 *  @return
 */
- (NFRequestMethod)customRequestMethodAction:(NSString *)action;

/**
 *  当数据请求结束时，将调用该函数
 *  当实现该方法之后,`didExecuteFinish:withAction:withTag:withResponse`将不会被调用
 *
 *  @param error    当发生错误时，该参数将被赋值，未发生错误时，该参数为nil
 *  @param action   进行http请求时传递的action
 *  @param response 服务器返回的数据，该数据已经被解析为 `classNameForAction:` 中指定的类型
 */
- (void)didExecuteFinish:(nullable NSError*)error withAction:(NSString*)action withResponse:(nullable id)response;


/**
 *  当数据请求结束时，将调用该函数。
 *  注意：如果要使用该方法，请不要实现 `didExecuteFinish:withAction:withResponse` 方法
 *
 *  @param error    当发生错误时，该参数将被赋值，未发生错误时，该参数为nil
 *  @param action   进行http请求时传递的action
 *  @param tag      进行http请求时指定的tag
 *  @param response 服务器返回的数据，该数据已经被解析为 `classNameForAction:` 中指定的类型
 */
- (void)didExecuteFinish:(nullable NSError*)error withAction:(NSString*)action withTag:(NSInteger)tag withResponse:(nullable id)response;

/**
 *  给调用者一次处理json数据的机会
 *  当服务器返回的json数据不规范的时候可以使用
 *
 *  @param jsonString
 *  @param action
 *
 *  @return
 */
- (nullable NSString*)willParseJson:(nullable NSString*)jsonString withAction:(nonnull NSString*)action;

@end

@interface NFHTTPSessionManager : AFHTTPSessionManager

/**
 *  执行http post/get请求, 用delegate的方式
 *
 *  @param requester  遵循NFHttpRequester的对象，一般为viewcontroller
 *  @param action     服务器接口对应的action
 *  @param parameters 业务参数
 *  @param tag        http请求标记
 *  @param block      用于表单提交，需要在该block里面构造formDat.
 */
- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(nullable NSDictionary *)parameters
            tag:(NSInteger)tag
      formBlock:(nullable void (^)(id <AFMultipartFormData> formData))block;

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(nullable NSDictionary *)parameters
            tag:(NSInteger)tag;

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action
     parameters:(nullable NSDictionary *)parameters;

- (void)execute:(__weak id<NFHttpRequester>)requester
         action:(NSString*)action;


/**
 *  执行http post/get请求, 用block的方式
 *
 *  @param action        服务器接口对应的action
 *  @param method        Request的方法，例如：GET， POST
 *  @param parameters    业务参数
 *  @param tag           http请求标记
 *  @param customHudView 自定义的hud
 *  @param parentView    指定hud的父类
 *  @param hudText       指定hud的text
 *  @param className     指定服务器返回数据的解析对象类名
 *  @param block         用于表单提交，需要在该block里面构造formDat.
 *  @param success       网络请求成功之后的block
 *  @param failed        网络请求失败之后的block
 */
- (void)execute:(NSString *)action
  requestMethod:(NFRequestMethod) method
     parameters:(nullable NSDictionary *)parameters
            tag:(NSInteger)tag
  customHudView:(nullable MBProgressHUD *)customHudView
  hudParentView:(nullable UIView *)parentView
   hudLabelText:(nullable NSString *)hudText
      className:(NSString *)className
      formBlock:(nullable void (^)(id <AFMultipartFormData>  formData))block
        success:(nullable void (^)(id response, NSError* error)) success
         failed:(nullable void (^)(NSError* error)) failed;

- (void)execute:(NSString *)action
  requestMethod:(NFRequestMethod) method
     parameters:(nullable NSDictionary *)parameters
  hudParentView:(nullable UIView *)parentView
   hudLabelText:(nullable NSString *)hudText
      className:(NSString *)className
        success:(nullable void (^)(id, NSError*)) success
         failed:(nullable void (^)(NSError*)) failed;

@end

NS_ASSUME_NONNULL_END
