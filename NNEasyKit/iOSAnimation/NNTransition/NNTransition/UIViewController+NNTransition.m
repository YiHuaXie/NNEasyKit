//
// Created by 谢翼华 on 2018/11/1.
// Copyright (c) 2018 谢翼华. All rights reserved.
//

#import "UIViewController+NNTransition.h"
#import "NNAnimationTransition.h"
#import "NNInteractionTransition.h"
#import <objc/runtime.h>

#define CurrentDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]

@interface UIViewController()

@property (nonatomic, strong) NNAnimationTransition *animatedTransition;

@end

@implementation UIViewController (NNTransition)

//+ (void)load {
//    if (CurrentDeviceVersion < 9.0) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            [self _methodSwizzling];
//        });
//    }
//}

//#pragma mark - Method Swizzling
//
//+ (void)_methodSwizzling {
//    Class aClass = [self class];
//    SEL originalSelector = @selector(viewWillDisappear:);
//    SEL swizzledSelector = @selector(nn_viewWillDisappear:);
//
//    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
//
//    BOOL didAddMethod = class_addMethod(aClass,
//                                        originalSelector,
//                                        method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(aClass,
//                            swizzledSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}

//- (void)nn_viewWillDisappear:(BOOL)animated {
//    if (self.navigationController.delegate == self && self.animatedTransition) {
//        self.navigationController.delegate = nil;
//    }
//
//    [self nn_viewWillDisappear:animated];
//}

#pragma mark - Public

- (void)nn_addInteractionTransition:(NNInteractionTransition *)interactionTransition {
    self.interactionTransition = interactionTransition;
    
}

- (void)nn_presentViewController:(UIViewController *)viewControllerToPresent
              animatedTransition:(NNAnimationTransition *)animatedTransition
                        animated:(BOOL)animated
                      completion:(void (^)(void))completion {
    self.animatedTransition = animatedTransition;
    viewControllerToPresent.transitioningDelegate = self;
    [self presentViewController:viewControllerToPresent animated:animated completion:completion];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.animatedTransition.state = NNTransitionStateEnter;

    return self.animatedTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animatedTransition.state = NNTransitionStateExit;

    return self.animatedTransition;
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactionTransition;
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactionTransition;
//}

#pragma mark - Setter & Getter

- (void)setAnimatedTransition:(NNAnimationTransition *)animatedTransition {
    objc_setAssociatedObject(self,
            @selector(animatedTransition),
            animatedTransition,
            OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNAnimationTransition *)animatedTransition {
    return objc_getAssociatedObject(self, @selector(animatedTransition));
}

- (void)setInteractionTransition:(NNInteractionTransition *)interactionTransition {
    objc_setAssociatedObject(self,
                             @selector(interactionTransition),
                             interactionTransition,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NNInteractionTransition *)interactionTransition {
    return objc_getAssociatedObject(self, @selector(interactionTransition));
}

@end

#pragma mark - UINavigationController (NNTransition)

@implementation UINavigationController (NNTransition)

- (void)nn_pushViewController:(UIViewController *)viewController
           animatedTransition:(NNAnimationTransition *)animatedTransition
                     animated:(BOOL)animated {
    viewController.animatedTransition = animatedTransition;
    self.delegate = self;
    
    [self pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    NNAnimationTransition *transition = nil;
    if (operation == UINavigationControllerOperationPush) {
        transition = toVC.animatedTransition;
        transition.state = NNTransitionStateEnter;
    } else {
        transition = fromVC.animatedTransition;
        transition.state = NNTransitionStateExit;
    }
    
    return transition;
}

@end
