//
//  NFCoverHorizontalTransitionAnimator.m
//  NFBeeController
//
//  Created by jiangpengcheng on 14/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFCoverHorizontalTransitionAnimator.h"

@implementation NFCoverHorizontalTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *fromView;
    UIView *toView;
    
    // In iOS 8, the viewForKey: method was introduced to get views that the
    // animator manipulates.  This method should be preferred over accessing
    // the view of the fromViewController/toViewController directly.
    // It may return nil whenever the animator should not touch the view
    // (based on the presentation style of the incoming view controller).
    // It may also return a different view for the animator to animate.
    //
    // Imagine that you are implementing a presentation similar to form sheet.
    // In this case you would want to add some shadow or decoration around the
    // presented view controller's view. The animator will animate the
    // decoration view instead and the presented view controller's view will
    // be a child of the decoration view.
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    // If this is a presentation, toViewController corresponds to the presented
    // view controller and its presentingViewController will be
    // fromViewController.  Otherwise, this is a dismissal.
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // We are responsible for adding the incoming view to the containerView
    // for the presentation.
    if (isPresenting) {
        // For a presentation, the toView starts off-screen and slides in.
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
        [containerView addSubview:toView];
    } else {
        fromView.frame = fromFrame;
        toView.frame = toFrame;
        
        // -addSubview places its argument at the front of the subview stack.
        // For a dismissal animation we want the fromView to slide away,
        // revealing the toView.  Thus we must place toView under the fromView.
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
        } else {
            // For a dismissal, the fromView slides off the screen.
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width, 0);
        }
    } completion:^(BOOL finished) {
        // When we complete, tell the transition context
        // passing along the BOOL that indicates whether the transition
        // finished or not.
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
