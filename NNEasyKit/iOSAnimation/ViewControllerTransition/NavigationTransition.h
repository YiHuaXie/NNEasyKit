//
//  NavigationTransition.h
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NTransitionType) {
    NTransitionTypePush,
    NTransitionTypePop
};

@interface NavigationTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly, assign) NTransitionType type;

+ (instancetype)transitionWithType:(NTransitionType)type;
- (instancetype)initWithTransitionType:(NTransitionType)type;

@end

