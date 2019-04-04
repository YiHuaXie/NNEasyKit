//
// Created by 谢翼华 on 2018/11/1.
// Copyright (c) 2018 谢翼华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNAnimationTransition;
@class NNInteractionTransition;

@interface UIViewController (NNTransition) <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NNInteractionTransition *interactionTransition;

- (void)nn_presentViewController:(UIViewController *)viewControllerToPresent
                   animatedTransition:(NNAnimationTransition *)animatedTransition
                        animated:(BOOL)animated
                      completion:(void (^)(void))completion;

@end

@interface UINavigationController (NNTransition) <UINavigationControllerDelegate>

- (void)nn_pushViewController:(UIViewController *)viewController
                animatedTransition:(NNAnimationTransition *)animatedTransition
                     animated:(BOOL)animated;

@end



