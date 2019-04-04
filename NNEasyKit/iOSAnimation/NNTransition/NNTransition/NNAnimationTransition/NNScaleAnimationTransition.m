//
// Created by NeroXie on 2018/11/6.
// Copyright (c) 2018 NeroXie. All rights reserved.
//

#import "NNScaleAnimationTransition.h"

@implementation NNScaleAnimationTransition

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                              toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    float scale = self.scale <= 0 ? 2.0f : self.scale;
    if (self.state == NNTransitionStateEnter) {
        [containerView insertSubview:toView aboveSubview:fromView];
        toView.alpha = 0;
        toView.transform = CGAffineTransformScale(toView.transform, scale, scale);
    } else {
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
    [UIView animateWithDuration:durationTime
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         if (self.state == NNTransitionStateEnter) {
                             toView.alpha = 1.0;
                             toView.transform = CGAffineTransformScale(toView.transform, 1 / scale, 1 / scale);
                         } else {
                             fromView.alpha = 0;
                             fromView.transform = CGAffineTransformScale(fromView.transform, scale, scale);
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
