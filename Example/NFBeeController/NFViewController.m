//
//  NFViewController.m
//  NFBeeController
//
//  Created by ninefivefly on 06/27/2016.
//  Copyright (c) 2016 ninefivefly. All rights reserved.
//

#import "NFViewController.h"

#import "NFAppDotNetApiClient.h"
#import "NFAppDotNetDataModel.h"

#import <NFBeeController/NFLog.h>


@interface NFViewController ()<NFHttpRequester>

@end

void STLogResponderChain(UIResponder *responder) {
    NSLog(@"------------------The Responder Chain------------------");
    NSMutableString *spaces = [NSMutableString stringWithCapacity:4];
    while (responder) {
        NSLog(@"%@%@", spaces, responder.class);
        responder = responder.nextResponder;
        [spaces appendString:@"----"];
    }
}

@implementation NFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NFAppDotNetApiClient sharedClient]execute:@"stream/0/posts/stream/global" requestMethod:NFRequestMethodGet parameters:nil tag:3 customHudView:nil hudParentView:nil hudLabelText:@"dddd" className:@"NFAppDotNetResponse" formBlock:nil success:^(id _Nonnull response, NSError * _Nonnull error) {
        NFLogDebug(@"%@", error);
    } failed:nil];
    
    [[NFAppDotNetApiClient sharedClient]execute:self action:@"stream/0/posts/stream/global" parameters:@{@"sign": @"adfasdfasdf"} tag:1 formBlock:nil];
    [[NFAppDotNetApiClient sharedClient]execute:self action:@"stream/0/posts/stream/global" parameters:@{@"sign": @"adfasdfasdf"} tag:2 formBlock:nil];
    [[NFAppDotNetApiClient sharedClient]execute:self action:@"stream/0/posts/stream/global" parameters:@{@"sign": @"adfasdfasdf"} tag:4 formBlock:nil];
    [[NFAppDotNetApiClient sharedClient]execute:self action:@"stream/0/posts/stream/global" parameters:@{@"sign": @"adfasdfasdf"} tag:5 formBlock:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JXHttpRequester Delegate Methods
-(NSString*)classNameForAction:(NSString*)action
{
    return @"NFAppDotNetResponse";
}
//
//-(UIView*)parentView:(NSString *)action
//{
//    return self.view;
//}
//
//- (nonnull MBProgressHUD *)activityIndicator:(NSString *)action {
//    MBProgressHUD* hud = [[MBProgressHUD alloc]init];
//    return hud;
//}
//
//-(NSString*)textDisplayWhenExecuteAction:(NSString*)action
//{
//    return @"加载中...";
//}
//
- (NFRequestMethod)customRequestMethodAction:(NSString*)action{
    return NFRequestMethodGet;
}

- (void)didExecuteFinish:(NSError *)error withAction:(NSString *)action withResponse:(id)response{
    if (error) {
        ;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    STLogResponderChain(self.view);
}

@end
