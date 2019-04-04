//
//  NNPortalAnimationTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/2.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNPortalAnimationTransition.h"

#define ZOOM_SCALE 0.8

@implementation NNPortalAnimationTransition

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                              toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    if (self.state == NNTransitionStateEnter) {
        [self _enterAnimationTransitionHandlerWithDurationTime:durationTime
                                             transitionContext:transitionContext
                                                        fromVC:(UIViewController *)fromVC
                                                          toVC:(UIViewController *)toVC
                                                     fromeView:fromView
                                                        toView:toView
                                                 containerView:containerView];
    } else {
        [self _exitAnimationTransitionHandlerWithDurationTime:durationTime
                                             transitionContext:transitionContext
                                                       fromVC:(UIViewController *)fromVC
                                                         toVC:(UIViewController *)toVC
                                                     fromeView:fromView
                                                        toView:toView
                                                 containerView:containerView];
    }
}

#pragma mark - Private

- (void)_enterAnimationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                                  fromVC:(UIViewController *)fromVC
                                                    toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    UIView *toViewSnapshot = [toView resizableSnapshotViewFromRect:toView.frame
                                                afterScreenUpdates:YES
                                                     withCapInsets:UIEdgeInsetsZero];
    CATransform3D scale = CATransform3DIdentity;
    toViewSnapshot.layer.transform = CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
    [containerView addSubview:toViewSnapshot];
    
    CGRect leftRect = CGRectMake(0, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
    UIView *leftHandView = [fromView resizableSnapshotViewFromRect:leftRect
                                                afterScreenUpdates:NO
                                                     withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = leftRect;
    [containerView addSubview:leftHandView];
    
    CGRect rightRect = CGRectMake(fromView.frame.size.width / 2, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
    UIView *rightHandView = [fromView resizableSnapshotViewFromRect:rightRect
                                                 afterScreenUpdates:NO
                                                      withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = rightRect;
    [containerView addSubview:rightHandView];
    
    [fromView removeFromSuperview];
    
    [UIView animateWithDuration:durationTime
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         leftHandView.frame = CGRectOffset(leftHandView.frame, -leftHandView.frame.size.width, 0);
                         rightHandView.frame = CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
                         
                         toViewSnapshot.center = toView.center;
                         toViewSnapshot.frame = toView.frame;
                     }
                     completion:^(BOOL finished) {
                         UIView *addedView = [transitionContext transitionWasCancelled] ? fromView : toView;
                         [containerView addSubview:addedView];
                         [self _removeOtherViews:addedView];
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)_exitAnimationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                      transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                                 fromVC:(UIViewController *)fromVC
                                                   toVC:(UIViewController *)toVC
                                              fromeView:(UIView *)fromView
                                                 toView:(UIView *)toView
                                          containerView:(UIView *)containerView {
    [containerView addSubview:fromView];
    
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];
    
    CGRect leftRect = CGRectMake(0, 0, toView.frame.size.width / 2, toView.frame.size.height);
    UIView *leftHandView = [toView resizableSnapshotViewFromRect:leftRect
                                              afterScreenUpdates:YES
                                                   withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = leftRect;
    leftHandView.frame = CGRectOffset(leftRect, -leftRect.size.width, 0);
    [containerView addSubview:leftHandView];
    
    CGRect rightRect = CGRectMake(toView.frame.size.width / 2, 0, toView.frame.size.width / 2, toView.frame.size.height);
    UIView *rightHandView = [toView resizableSnapshotViewFromRect:rightRect
                                               afterScreenUpdates:YES
                                                    withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = rightRect;
    rightHandView.frame = CGRectOffset(rightRect, rightRect.size.width, 0);
    [containerView addSubview:rightHandView];
    
    [UIView animateWithDuration:durationTime
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         leftHandView.frame = CGRectOffset(leftHandView.frame, leftHandView.frame.size.width, 0);
                         rightHandView.frame = CGRectOffset(rightHandView.frame, -rightHandView.frame.size.width, 0);
                         
                         CATransform3D scale = CATransform3DIdentity;
                         fromView.layer.transform = CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
                     }
                     completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [self _removeOtherViews:fromView];
                         } else {
                             [self _removeOtherViews:toView];
                             toView.frame = containerView.bounds;
                         }
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)_removeOtherViews:(UIView*)viewToKeep {
    UIView *containerView = viewToKeep.superview;
    for (UIView *view in containerView.subviews) {
        if (view != viewToKeep) {
            [view removeFromSuperview];
        }
    }
}

@end
