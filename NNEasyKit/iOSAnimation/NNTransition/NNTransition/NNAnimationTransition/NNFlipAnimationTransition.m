//
//  NNFlipAnimationTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/5.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNFlipAnimationTransition.h"

CATransform3D CATransform3DMake(CGFloat angle) {
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}

@implementation NNFlipAnimationTransition

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                            toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    [containerView addSubview:toView];
    float factor = self.state == NNTransitionStateEnter ? 1.0 : -1.0;
    toView.frame = fromView.frame;
    toView.layer.transform = CATransform3DMake(factor * -M_PI_2);
    
    [UIView animateKeyframesWithDuration:durationTime
                                   delay:0.0
                                 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    fromView.layer.transform = CATransform3DMake(factor * M_PI_2);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    toView.layer.transform = CATransform3DMake(0.0);
                                                                }];
                              }
                              completion:^(BOOL finished) {
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              }];
}

@end
