//
//  NNExplodeAnimationTransition.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/5.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNExplodeAnimationTransition.h"

float RandomFloat(float smallNumber, float bigNumber) {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@implementation NNExplodeAnimationTransition

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                              toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView {
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    CGSize size = toView.frame.size;
    
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    for (CGFloat x = 0; x < size.width; x += size.width / xFactor) {
        for (CGFloat y = 0; y < size.height; y += size.height / yFactor) {
            CGRect snapshotRect = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRect
                                                            afterScreenUpdates:NO
                                                                 withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRect;
            [containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [containerView sendSubviewToBack:fromView];
    
    [UIView animateWithDuration:durationTime
                     animations:^{
                         for (UIView *view in snapshots) {
                             float xOffset = RandomFloat(-100.0, 100.0);
                             float yOffset = RandomFloat(-100.0, 100.0);
                             view.frame = CGRectOffset(view.frame, xOffset, yOffset);
                             view.alpha = 0.0;
                             view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(RandomFloat(-10.0, 10.0)), 0.01, 0.01);
                         }
                     }
                     completion:^(BOOL finished) {
                         for (UIView *view in snapshots) {
                             [view removeFromSuperview];
                         }
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
