//
// Created by 谢翼华 on 2018/11/1.
// Copyright (c) 2018 谢翼华. All rights reserved.
//

#import "NNAnimationTransition.h"

@interface NNCircleSpreadAnimationTransition : NNAnimationTransition

@property (nonatomic, assign) CGRect focusFrame;

+ (instancetype)transitionWithFocusFrame:(CGRect)focusFrame;

@end
