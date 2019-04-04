//
// Created by 谢翼华 on 2018/11/1.
// Copyright (c) 2018 谢翼华. All rights reserved.
//

#import "NNCircleSpreadAnimationTransition.h"

static NSString *const kTransitionContext = @"TransitionContext";
static NSString *const kAnimatonKeyPath = @"path";

@interface NNCircleSpreadAnimationTransition () <CAAnimationDelegate>

@end

@implementation NNCircleSpreadAnimationTransition

#pragma mark - Init

+ (instancetype)transitionWithFocusFrame:(CGRect)focusFrame {
    NNCircleSpreadAnimationTransition *transition = [self new];
    transition.focusFrame = focusFrame;
    transition.durationTime = 0.7;
    
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
    UIView *addLayerView = nil;
    UIBezierPath *startPath = nil;
    UIBezierPath *endPath = nil;
    
    if (self.state == NNTransitionStateEnter) {
        [containerView insertSubview:toView aboveSubview:fromView];
        addLayerView = toView;
        
        CGFloat x = MAX(self.focusFrame.origin.x, containerView.frame.size.width - self.focusFrame.origin.x);
        CGFloat y = MAX(self.focusFrame.origin.y, containerView.frame.size.height - self.focusFrame.origin.y);
        CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
        startPath = [UIBezierPath bezierPathWithOvalInRect:self.focusFrame];
        endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center
                                                 radius:radius
                                             startAngle:0
                                               endAngle:M_PI * 2
                                              clockwise:YES];
    } else {
        [containerView insertSubview:toView belowSubview:fromView];
        addLayerView = fromView;
        
        CGFloat radius = sqrtf(pow(containerView.frame.size.height, 2) + pow(containerView.frame.size.width, 2));
        startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center
                                                   radius:radius
                                               startAngle:0
                                                 endAngle:M_PI * 2
                                                clockwise:YES];
        endPath =  [UIBezierPath bezierPathWithOvalInRect:self.focusFrame];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kAnimatonKeyPath];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = durationTime;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:kTransitionContext];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    addLayerView.layer.mask = maskLayer;
    [maskLayer addAnimation:animation forKey:kAnimatonKeyPath];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UITransitionContextViewControllerKey key = self.state == NNTransitionStateEnter ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
    
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:kTransitionContext];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    [transitionContext viewControllerForKey:key].view.layer.mask = nil;
}

@end
