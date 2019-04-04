//
//  AViewController.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
#import "PresentTransition.h"
#import "InteractiveTransition.h"
#import "NavigationTransition.h"

@interface AViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) InteractiveTransition *interactiveTransition;
@end

@implementation AViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Private

- (IBAction)_didPushButtonPressed:(id)sender {
    BViewController *vc = [BViewController new];
     self.navigationController.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)_didPresentButtonPressed:(id)sender {
    BViewController *vc = [BViewController new];
    vc.transitioningDelegate = self;

    self.interactiveTransition = [InteractiveTransition new];
    [self.interactiveTransition addToViewController:vc];

    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentTransition alloc] initWithTransitionType:TransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[PresentTransition alloc] initWithTransitionType:TransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    NTransitionType type = operation == UINavigationControllerOperationPush ? NTransitionTypePush : NTransitionTypePop;
    return [NavigationTransition transitionWithType:type];
}

@end
