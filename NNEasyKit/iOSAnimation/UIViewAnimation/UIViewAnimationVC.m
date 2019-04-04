//
//  UIViewAnimationVC.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/29.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "UIViewAnimationVC.h"
#import "UIImage+NNExtension.h"

@interface UIViewAnimationVC ()

@end

@implementation UIViewAnimationVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.grayColor;

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    view1.backgroundColor = UIColor.redColor;
    [self.view addSubview:view1];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_view1Clicked:)]];

}

#pragma mark - Private

- (void)_view1Clicked:(id)sender {
//    [self _beginAndCommitTest:sender];
//    [self _animationBlockTest:sender];
//    [self _springAnimationTest:sender];
//    [self _keyframeAnimationTest:sender];
    [self _transformAnmationTest:sender];
}

#pragma mark - UIView类方法动画

- (void)_beginAndCommitTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    [UIView beginAnimations:@"view1Animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    /*
     缓动方式
     EaseInOut // slow at beginning and end
     EaseIn // slow at beginning
     EaseOut // slow at end
     Linear
     */
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    theView.frame = CGRectMake(theView.frame.origin.x + 100,
            theView.frame.origin.y,
            theView.frame.size.width,
            theView.frame.size.height);
    theView.backgroundColor = UIColor.greenColor;
    theView.alpha = 0.5;
    [UIView commitAnimations];
}

#pragma mark - UIView Anmation Block

//与上面的类方法动画是一样的m，只是使用了Block方式
- (void)_animationBlockTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         theView.frame = CGRectMake(theView.frame.origin.x + 100,
                                 theView.frame.origin.y,
                                 theView.frame.size.width,
                                 theView.frame.size.height);
                         theView.backgroundColor = UIColor.greenColor;
                         theView.alpha = 0.5;
                     }
                     completion:nil];
}

#pragma mark - Spring Anmation

// Spring Animation 是线性动画或 ease-out 动画的理想替代品
- (void)_springAnimationTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    // usingSpringWithDamping 范围0.0f~1.0f，数值越小「弹簧」的振动效果越明显。

    // initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快。
    // 值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
    [UIView animateWithDuration:0.35
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         theView.frame = CGRectMake(theView.frame.origin.x + 200,
                                 theView.frame.origin.y,
                                 theView.frame.size.width,
                                 theView.frame.size.height);
                         theView.backgroundColor = UIColor.greenColor;
                         theView.alpha = 0.5;
                     }
                     completion:nil];
}

#pragma mark - Keyframe 帧动画（逐帧动画，连贯的UIView动画）

// 关键帧动画有个问题：支持属性关键帧，不支持路径关键帧
- (void)_keyframeAnimationTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;

    /*
     * UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
     * UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
     * UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
     * UIViewAnimationOptionRepeat                   //无限重复执行动画
     * UIViewAnimationOptionAutoreverse              //执行动画回路
     * UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
     * UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
     *
     * UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
     * UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
     * UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
     * UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
     * UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
     * */
    [UIView animateKeyframesWithDuration:9.0
                                   delay:0.f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  // relativeStartTime: 动画开始的时间(占总时间的比例)
                                  // relativeDuration: 动画持续时间(占总时间的比例)
                                  [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0 / 4 animations:^{
                                      theView.backgroundColor = UIColor.orangeColor;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:1.0 / 4 relativeDuration:1.0 / 4 animations:^{
                                      theView.backgroundColor = UIColor.yellowColor;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:2.0 / 4 relativeDuration:1.0 / 4 animations:^{
                                      theView.backgroundColor = UIColor.greenColor;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
                                      theView.backgroundColor = UIColor.blueColor;
                                  }];
                              }
                              completion:^(BOOL finished) {
                                  NSLog(@"动画结束");
                              }];
}

#pragma mark - 转场动画

- (void)_transformAnmationTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    // 单个视图的转场
//    [UIView transitionWithView:theView
//                      duration:1.0
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        theView.backgroundColor = UIColor.greenColor;
//                    }
//                    completion:^(BOOL finished) {
//                        NSLog(@"动画结束");
//                    }];

    // 多个视图的转场
    UIImageView *newView = [[UIImageView alloc] initWithFrame:self.view.frame];
    newView.image = [UIImage imageWithColor:UIColor.blueColor];
    [UIView transitionFromView:theView
                        toView:newView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        NSLog(@"动画结束");
                    }];
}

@end
