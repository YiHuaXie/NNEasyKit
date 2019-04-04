//
// Created by 谢翼华 on 2018/11/2.
// Copyright (c) 2018 NeroXie. All rights reserved.
//

#import "NNAnimationTransition.h"

typedef NS_ENUM(NSUInteger, NNTransitionAnimationType) {
    NNTransitionAnimationTypeZoom,
    NNTransitionAnimationTypeFade,
    NNTransitionAnimationTypeSlideLTR,
    NNTransitionAnimationTypeSlideRTL,
    NNTransitionAnimationTypeFlip
};

@interface NNEasyAnimatedTransition : NNAnimationTransition

@property (nonatomic, assign) NNTransitionAnimationType animationType;

+ (instancetype)transitionWithAnimationType:(NNTransitionAnimationType)animationType;

+ (instancetype)transitionWithDurationTime:(NSTimeInterval)durationTime
                             animationType:(NNTransitionAnimationType)animationType;

@end
