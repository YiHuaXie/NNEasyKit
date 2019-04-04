//
// Created by 谢翼华 on 2018/11/2.
// Copyright (c) 2018 NeroXie. All rights reserved.
//

#import "NNEasyAnimatedTransition.h"

@implementation NNEasyAnimatedTransition

#pragma mark - Init

+ (instancetype)transitionWithAnimationType:(NNTransitionAnimationType)animationType {
    NNEasyAnimatedTransition *transition = [NNEasyAnimatedTransition new];
    transition.animationType = animationType;
    
    return transition;
};

+ (instancetype)transitionWithDurationTime:(NSTimeInterval)durationTime
                             animationType:(NNTransitionAnimationType)animationType {
    NNEasyAnimatedTransition *transition = [NNEasyAnimatedTransition new];
    transition.durationTime = durationTime;
    transition.animationType = animationType;
    
    return transition;
}

#pragma mark - Override

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
                                                     fromeView:fromView
                                                        toView:toView
                                                 containerView:containerView];
    } else {
        [self _exitAnimationTransitionHandlerWithDurationTime:durationTime
                                             transitionContext:transitionContext
                                                     fromeView:fromView
                                                        toView:toView
                                                 containerView:containerView];
    }
}

#pragma mark - Private

- (void)_enterAnimationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    [containerView insertSubview:toView aboveSubview:fromView];
    
    switch (self.animationType) {
        case NNTransitionAnimationTypeZoom:
            toView.transform = CGAffineTransformScale(toView.transform, 0.1, 0.1);
            break;
        case NNTransitionAnimationTypeFade:
            toView.alpha = 0;
            break;
        case NNTransitionAnimationTypeSlideLTR: {
            CGRect frame = toView.frame;
            toView.frame = CGRectOffset(frame, -CGRectGetWidth(frame), 0);
        }
            break;
        case NNTransitionAnimationTypeSlideRTL: {
            CGRect frame = toView.frame;
            toView.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
        }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:durationTime
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         switch (self.animationType) {
                             case NNTransitionAnimationTypeZoom:
                                 toView.transform = CGAffineTransformScale(toView.transform, 10, 10);
                                 break;
                             case NNTransitionAnimationTypeFade:
                                 toView.alpha = 1.0;
                                 break;
                             case NNTransitionAnimationTypeSlideLTR: {
                                 CGRect frame = toView.frame;
                                 toView.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
                             }
                                 break;
                             case NNTransitionAnimationTypeSlideRTL: {
                                 CGRect frame = toView.frame;
                                 toView.frame = CGRectOffset(frame, -CGRectGetWidth(frame), 0);
                             }
                                 break;
                             default:
                                 break;
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)_exitAnimationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    [containerView insertSubview:toView belowSubview:fromView];
    
    [UIView animateWithDuration:durationTime
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         switch (self.animationType) {
                             case NNTransitionAnimationTypeZoom:
                                 fromView.transform = CGAffineTransformScale(fromView.transform, 0.01, 0.01);
                                 break;
                             case NNTransitionAnimationTypeFade:
                                 fromView.alpha = 0.0;
                                 break;
                             case NNTransitionAnimationTypeSlideLTR: {
                                 CGRect frame = fromView.frame;
                                 fromView.frame = CGRectOffset(frame, -CGRectGetWidth(frame), 0);
                             }
                                 break;
                             case NNTransitionAnimationTypeSlideRTL: {
                                 CGRect frame = fromView.frame;
                                 fromView.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
                             }
                                 break;
                             default:
                                 break;
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
