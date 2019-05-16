//
//  NNNavigationController.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/16.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "NNNavigationController.h"

@interface NNNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation NNNavigationController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - Override

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count >= 1;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count == 1 ? NO : YES;
}

@end
