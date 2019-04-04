//
//  PresentTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "PresentTransition.h"

@interface PresentTransition()

@property (nonatomic, assign) TransitionType type;

@end

@implementation PresentTransition

#pragma mark - Init

+ (instancetype)transitionWithTransitionType:(TransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType)type {
    if (self = [super init]) {
        self.type = type;
    }

    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval timeInterval = [self transitionDuration:transitionContext];

    switch (self.type) {
        case TransitionTypePresent:
            [self _showAnimation:transitionContext durationTime:timeInterval];
            break;
        default:
            [self _dismissAnimation:transitionContext durationTime:timeInterval];
            break;
    }
}

#pragma mark - Private

- (void)_showAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
          durationTime:(NSTimeInterval)durationTime {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;

    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    //开始Zoom动画
    toVC.view.transform = CGAffineTransformScale(toVC.view.transform, 0.1, 0.1);
    [UIView animateWithDuration:durationTime
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.transform = CGAffineTransformScale(toVC.view.transform, 10, 10);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)_dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
             durationTime:(NSTimeInterval)durationTime {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;

    [containerView insertSubview:toVC.view belowSubview:fromVC.view];

    [UIView animateWithDuration:durationTime
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
