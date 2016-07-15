//
//  NFBaseViewController.m
//  NFBeeController
//
//  Created by jiangpengcheng on 8/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFBaseViewController.h"
#import "NFCoverHorizontalTransitionAnimator.h"
#import <NFBeeController/NFHTTPSessionManager.h>
#import "NFLog.h"

@interface NFBaseViewController ()<UIViewControllerTransitioningDelegate, NFHttpRequester>

@end

@implementation NFBaseViewController

#pragma mark - NFHttpRequester Delegate Methods

- (NSString *)classNameForAction:(NSString *)action
{
    return @"NFBaseResponse";
}

- (UIView *)parentView:(NSString *)action
{
    return self.view;
}

- (NSString*)textDisplayWhenExecuteAction:(NSString*)action
{
    return @"加载中...";
}

- (NFRequestMethod)customRequestMethodAction:(NSString*)action{
    return NFRequestMethodPost;
}

#pragma mark - Rewrite

- (void)dealloc{
    NFLogDebug(@"dealloc %@", NSStringFromClass([self class]))
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if ([viewControllerToPresent isKindOfClass:[NFBaseViewController class]] &&
        ((NFBaseViewController *)viewControllerToPresent).presentTransitionStyleCoverHorizontal) {
        // Setting the modalPresentationStyle to FullScreen enables the
        // <ContextTransitioning> to provide more accurate initial and final frames
        // of the participating view controllers
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        
        // The transitioning delegate can supply a custom animation controller
        // that will be used to animate the incoming view controller.
        viewControllerToPresent.transitioningDelegate = self;
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - UIViewControllerTransitioningDelegate

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [NFCoverHorizontalTransitionAnimator new];
}


//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [NFCoverHorizontalTransitionAnimator new];
}

@end
