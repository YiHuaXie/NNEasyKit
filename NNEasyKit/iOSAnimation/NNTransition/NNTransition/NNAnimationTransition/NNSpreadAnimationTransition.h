//
//  NNSpreadAnimationTransition.h
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/7.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNAnimationTransition.h"

typedef NS_ENUM(NSInteger, SpreadDirection) {
    SpreadDirectionFromTop,
    SpreadDirectionFromBottom,
    SpreadDirectionFromLeft,
    SpreadDirectionFromRight
};

@interface NNSpreadAnimationTransition : NNAnimationTransition

@property (nonatomic, assign) SpreadDirection direction;

+ (instancetype)transitionWithDirection:(SpreadDirection)direction;

@end
