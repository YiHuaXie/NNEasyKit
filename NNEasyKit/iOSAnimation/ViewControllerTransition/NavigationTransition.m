//
//  NavigationTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NavigationTransition.h"

@interface UIView (anchorPoint)

@end

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end

@interface NavigationTransition()

@property (nonatomic, assign) NTransitionType type;

@end

@implementation NavigationTransition

#pragma mark - Init

+ (instancetype)transitionWithType:(NTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(NTransitionType)type {
    if (self = [super init]) {
        self.type = type;
    }

    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval timeInterval = [self transitionDuration:transitionContext];

    switch (self.type) {
        case NTransitionTypePush:
            [self _pushAnimation:transitionContext durationTime:timeInterval];
            break;
        default:
            [self _popAnimation:transitionContext durationTime:timeInterval];
            break;
    }
}

#pragma mark - Private

- (void)_pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
          durationTime:(NSTimeInterval)durationTime {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transfrom3d;
    //增加阴影
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = fromVC.view.bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
            (id)[UIColor blackColor].CGColor];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
    fromGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    fromShadow.backgroundColor = [UIColor clearColor];
    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
    fromShadow.alpha = 0.0;
    [tempView addSubview:fromShadow];
    CAGradientLayer *toGradient = [CAGradientLayer layer];
    toGradient.frame = fromVC.view.bounds;
    toGradient.colors = @[(id)[UIColor blackColor].CGColor,
            (id)[UIColor blackColor].CGColor];
    toGradient.startPoint = CGPointMake(0.0, 0.5);
    toGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    toShadow.backgroundColor = [UIColor clearColor];
    [toShadow.layer insertSublayer:toGradient atIndex:1];
    toShadow.alpha = 1.0;
    [toVC.view addSubview:toShadow];
    [UIView animateWithDuration:durationTime
                     animations:^{
                         tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
                         fromShadow.alpha = 1.0;
                         toShadow.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if ([transitionContext transitionWasCancelled]) {
                             [tempView removeFromSuperview];
                             fromVC.view.hidden = NO;
                         }
                     }];
}

- (void)_popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
        durationTime:(NSTimeInterval)durationTime {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //拿到push时候的
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:durationTime
                     animations:^{
                         tempView.layer.transform = CATransform3DIdentity;
                         fromVC.view.subviews.lastObject.alpha = 1.0;
                         tempView.subviews.lastObject.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             [transitionContext completeTransition:YES];
                             [tempView removeFromSuperview];
                             toVC.view.hidden = NO;
                         }
                     }];

}

@end
