//
//  Test1ViewController.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/11/1.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "Test1ViewController.h"
#import "NNEasyAnimatedTransition.h"
#import "UIViewController+NNTransition.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"x0"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];

    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [preBtn setTitle:@"present" forState:UIControlStateNormal];
    preBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    preBtn.backgroundColor = UIColor.orangeColor;
    preBtn.frame = CGRectMake(100, 100, 50, 30);
    [preBtn addTarget:self
               action:@selector(_didPreBtnPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preBtn];
}

#pragma mark - Private

- (void)_didPreBtnPressed:(id)sender {
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[Test2ViewController new]];
//    NNAnimationTransition *transition = [NNEasyAnimatedTransition transitionWithDurationTime:0.8
//                                                                          animationType:NNTransitionAnimationTypeZoom];
//    [self nn_presentViewController:nav
//                animatedTransition:transition
//                          animated:YES
//                        completion:nil];
}

@end
