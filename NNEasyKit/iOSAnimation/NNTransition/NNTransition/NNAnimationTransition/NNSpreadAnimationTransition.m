//
//  NNSpreadAnimationTransition.m
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/7.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNSpreadAnimationTransition.h"

static NSString *const kTransitionContext = @"TransitionContext";
static NSString *const kAnimatonKeyPath = @"path";

/**
 获取动画结束后的frame

 @param animationStartFrame 动画开始时候的frame
 @param direction 方向
 @return frame
 */
CGRect AnimationEndFrame(CGRect animationStartFrame, SpreadDirection direction) {
    switch (direction) {
        case SpreadDirectionFromTop:
            return CGRectOffset(animationStartFrame, 0, -CGRectGetHeight(animationStartFrame));
        case SpreadDirectionFromBottom:
            return CGRectOffset(animationStartFrame, 0, CGRectGetHeight(animationStartFrame));
        case SpreadDirectionFromLeft:
            return CGRectOffset(animationStartFrame, -CGRectGetWidth(animationStartFrame), 0);
        default:
            return CGRectOffset(animationStartFrame, CGRectGetWidth(animationStartFrame), 0);
    }
}

@interface NNSpreadAnimationTransition() <CAAnimationDelegate>

@end

@implementation NNSpreadAnimationTransition

#pragma mark - Init

+ (instancetype)transitionWithDirection:(SpreadDirection)direction {
    NNSpreadAnimationTransition *transiton = [self new];
    transiton.direction = direction;
    
    return transiton;
}

#pragma mark - Override

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                            toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    CGRect startFrame = CGRectZero;
    CGRect endFrame = CGRectZero;
    UIView *addLayerView = nil;
    
    if (self.state == NNTransitionStateEnter) {
        [containerView insertSubview:toView aboveSubview:fromView];
        endFrame = [UIScreen mainScreen].bounds;
        startFrame = AnimationEndFrame(endFrame, self.direction);
        addLayerView = toView;
    } else {
        [containerView insertSubview:toView belowSubview:fromView];
        startFrame = [UIScreen mainScreen].bounds;
        endFrame = AnimationEndFrame(startFrame, self.direction);
        addLayerView = fromView;
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:startFrame];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:endFrame];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kAnimatonKeyPath];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = durationTime;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:kTransitionContext];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    addLayerView.layer.mask = maskLayer;
    [maskLayer addAnimation:animation forKey:kAnimatonKeyPath];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:kTransitionContext];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    if ([transitionContext transitionWasCancelled]) {
        UITransitionContextViewControllerKey key = self.state == NNTransitionStateEnter ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
        [transitionContext viewControllerForKey:key].view.layer.mask = nil;
    }
}

@end
