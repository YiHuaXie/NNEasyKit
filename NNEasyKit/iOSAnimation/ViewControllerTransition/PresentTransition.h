//
//  PresentTransition.h
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePresent,
    TransitionTypeDismiss,
};

@interface PresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(TransitionType)type;
- (instancetype)initWithTransitionType:(TransitionType)type;

@end

