//
//  NNAnimationTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/5.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNAnimationTransition.h"

#define BLOCK_EXEC(block, ...)      if (block) { block(__VA_ARGS__); };

static NSTimeInterval const defaultDurationTime = 0.5;

@implementation NNAnimationTransition

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        self.state = NNTransitionStateEnter;
        self.durationTime = defaultDurationTime;
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.durationTime >= 0.0 ? self.durationTime : defaultDurationTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval time = [self transitionDuration:transitionContext];
    
    [self animationTransitionHandlerWithDurationTime:time
                                   transitionContext:transitionContext
                                              fromVC:fromVC
                                                toVC:toVC
                                           fromeView:fromVC.view
                                              toView:toVC.view
                                       containerView:containerView];
}

#pragma mark - Public

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id <UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                              toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
