//
//  NNAnimationTransition.h
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/5.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NNTransition.h"

typedef NS_ENUM(NSUInteger, NNTransitionState) {
    NNTransitionStateEnter,
    NNTransitionStateExit,
};

@interface NNAnimationTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval durationTime; //默认是0.5s
@property (nonatomic, assign) NNTransitionState state; //默认是Enter

- (void)animationTransitionHandlerWithDurationTime:(NSTimeInterval)durationTime
                                 transitionContext:(id <UIViewControllerContextTransitioning>)transitionContext
                                            fromVC:(UIViewController *)fromVC
                                              toVC:(UIViewController *)toVC
                                         fromeView:(UIView *)fromView
                                            toView:(UIView *)toView
                                     containerView:(UIView *)containerView;

@end

