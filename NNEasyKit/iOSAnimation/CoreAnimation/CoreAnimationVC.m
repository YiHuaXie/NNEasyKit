//
//  CoreAnimationVC.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/29.
//  Copyright © 2018 NeroXie. All rights reserved.
//

// CAAnimation：核心动画的基础类，不能直接使用，负责动画运行时间、速度的控制，本身实现了CAMediaTiming协议。
// CAPropertyAnimation：属性动画的基类（通过属性进行动画设置，注意是可动画属性），不能直接使用。
// CAAnimationGroup：动画组，动画组是一种组合模式设计，可以通过动画组来进行所有动画行为的统一控制，组中所有动画效果可以并发执行。
// CATransition：转场动画，主要通过滤镜进行动画效果设置。
// CABasicAnimation：基础动画，通过属性修改进行动画参数控制，只有初始状态和结束状态。
// CAKeyframeAnimation：关键帧动画，同样是通过属性进行动画参数控制，但是同基础动画不同的是它可以有多个状态控制。

#import "CoreAnimationVC.h"

@interface CoreAnimationVC () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;

@end

@implementation CoreAnimationVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.grayColor;

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    view1.backgroundColor = UIColor.redColor;
    [self.view addSubview:view1];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_view1Clicked:)]];

    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.imageView.image = [UIImage imageNamed:@"x1"];
    self.imageView.hidden = YES;
    [self.view addSubview:self.imageView];
}

#pragma mark - Private

- (void)_view1Clicked:(id)sender {
//    [self _caBaseAnimationTest:sender];
//    [self _groupAnimationTest:sender];
    [self _keyFrameTest:sender];
//    [self _transformAnimationTest:sender];
}

#pragma mark - CABasicAnimation

/// 动画完成后layer的位置已经发生变化，但是UIView的位置没有发生变化，即frame没有变化，所以点击区域也没有变化
- (void)_caBaseAnimationTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    CGPoint point = CGPointMake(theView.layer.position.x + 100, theView.layer.position.y);

    CABasicAnimation *ca = [CABasicAnimation animationWithKeyPath:@"position"];
    ca.fromValue = [NSValue valueWithCGPoint:theView.layer.position];//起点
    ca.toValue = [NSValue valueWithCGPoint:point];//终点：绝对位置
//    ca.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 0)];//终点：相对位置

    ca.duration = 0.2;
    ca.repeatCount = 1;
    ca.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//加速运动
//    ca.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0 :0.9 :0.7];//自定义加速曲线

    /// 这两个属性若不设置，动画执行后回复位
    ca.removedOnCompletion = NO;
    ca.fillMode = kCAFillModeForwards;

    ca.delegate = self;
    // 在动画中缓存
    [ca setValue:[NSValue valueWithCGPoint:theView.layer.position] forKey:@"startPoint"];
    [ca setValue:[NSValue valueWithCGPoint:point] forKey:@"endPoint"];
    [ca setValue:theView forKey:@"view"];
    /// 开始动画
    [theView.layer addAnimation:ca forKey:@"theViewMoveRight100"];
}

#pragma mark - CABasicAnimation 组合动画

- (void)_groupAnimationTest:(UITapGestureRecognizer *)tap {
    UIView *theView = tap.view;
    CGPoint point = CGPointMake(theView.layer.position.x + 100, theView.layer.position.y);

    //X平移
    CABasicAnimation *xCa = [CABasicAnimation animationWithKeyPath:@"position"];
    xCa.toValue = [NSValue valueWithCGPoint:point];

    //X轴旋转
    CABasicAnimation *xRCa = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    xRCa.byValue = @(M_PI * 500);
    xRCa.duration = 1.5;

    //Y轴旋转
    CABasicAnimation *yRCa = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    yRCa.byValue = @(M_PI * 200);

    //缩放
    CABasicAnimation *sCa = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    sCa.autoreverses = YES;// 动画结束时执行逆动画
    sCa.fromValue = @(0.1); // 开始时的倍率
    sCa.toValue = @(1.5); // 结束时的倍率

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 3.0;
    group.repeatCount = 1;
    group.animations = @[xRCa, yRCa, sCa, xCa];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    group.delegate = self;
    [group setValue:[NSValue valueWithCGPoint:point] forKey:@"endPoint"];
    [group setValue:theView forKey:@"view"];

    [theView.layer addAnimation:group forKey:@"groupAnmation"];
}

#pragma mark - 关键帧动画

- (void)_keyFrameTest:(UITapGestureRecognizer *)tap {
    CAKeyframeAnimation *ca = [CAKeyframeAnimation animationWithKeyPath:@"position"];

//    ca.values = @[
//            [NSValue valueWithCGPoint:CGPointMake(10, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(30, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(30, 120)],
//            [NSValue valueWithCGPoint:CGPointMake(60, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(60, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(106, 210)],
//            [NSValue valueWithCGPoint:CGPointMake(106, 410)],
//            [NSValue valueWithCGPoint:CGPointMake(300, 310)]
//    ];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 50, 50);
    CGPathAddCurveToPoint(path, nil, 50, 50, 700, 300, 30, 50);
    ca.path = path;

    ca.duration = 1.0;
    ca.beginTime = CACurrentMediaTime() + 2; /// 延迟两秒执行

    [tap.view.layer addAnimation:ca forKey:@"keyframeAnimation"];

    /**
     * 其他控制帧动画的参数：
     *
     * keyTimes：各个关键帧的时间控制
     *
     * caculationMode：动画计算模式。
     * kCAAnimationLinear: 线性模式，默认值
     * kCAAnimationDiscrete: 离散模式
     * kCAAnimationPaced:均匀处理，会忽略keyTimes
     * kCAAnimationCubic:平滑执行，对于位置变动关键帧动画运行轨迹更平滑
     * kCAAnimationCubicPaced:平滑均匀执行
     */
}

#pragma mark - 转场动画

- (void)_transformAnimationTest:(UITapGestureRecognizer *)tap {
    self.imageView.hidden = NO;
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_leftSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
}

- (void)_leftSwipe:(UISwipeGestureRecognizerDirection *)tap {
    /*
    kCATransitionFade：淡入淡出，默认效果
    kCATransitionMoveIn：新视图移动到就是图上方
    kCATransitionPush:新视图推开旧视图
    kCATransitionReveal：移走旧视图然后显示新视图

    //苹果未公开的私有转场效果
    cube:立方体
    suckEffect:吸走的效果
    oglFlip:前后翻转效果
    rippleEffect:波纹效果
    pageCurl:翻页起来
    pageUnCurl:翻页下来
    cameraIrisHollowOpen:镜头开
    cameraIrisHollowClose:镜头关
    */
    NSArray *types = @[
            kCATransitionFade,
            kCATransitionMoveIn,
            kCATransitionPush,
            kCATransitionReveal,
            @"cube",
            @"suckEffect",
            @"oglFlip",
            @"rippleEffect",
            @"pageCurl",
            @"pageUnCurl",
            @"cameraIrisHollowOpen",
            @"cameraIrisHollowClose"];

    CATransition *ca = [CATransition animation];
    ca.type = types[arc4random() % 11];
    ca.subtype = kCATransitionFromLeft;
    ca.duration = 1.0;

    self.imageView.image = [self fetchImage];
    [self.imageView.layer addAnimation:ca forKey:@"leftSwipe"];
}

#pragma mark - Getter

- (UIImage *)fetchImage {
    NSString *imageName = [NSString stringWithFormat:@"x%d", arc4random() % 5];

    return [UIImage imageNamed:imageName];
}

#pragma mark - CAAnimationDelegate

/// 动画开始
- (void)animationDidStart:(CAAnimation *)theAnimation {
    NSLog(@"begin %@", NSStringFromCGPoint([[theAnimation valueForKey:@"startPoint"] CGPointValue]));
}

/// 动画结束
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    UIView *theView = (UIView *)[theAnimation valueForKey:@"view"];
    CGPoint endPoint = [[theAnimation valueForKey:@"endPoint"] CGPointValue];
    theView.layer.position = endPoint;

    NSLog(@"end");
}

/*
 可选的KeyPath
 transform.scale = 比例轉換
 transform.scale.x
 transform.scale.y
 transform.rotation = 旋轉
 transform.rotation.x
 transform.rotation.y
 transform.rotation.z
 transform.translation
 transform.translation.x
 transform.translation.y
 transform.translation.z
 
 opacity = 透明度
 margin
 zPosition
 backgroundColor 背景颜色
 cornerRadius 圆角
 borderWidth
 bounds
 contents
 contentsRect
 cornerRadius
 frame
 hidden
 mask
 masksToBounds
 opacity
 position
 shadowColor
 shadowOffset
 shadowOpacity
 shadowRadius
 */


/**
 1、UIView动画与核心动画的区别？
 
   核心动画只能添加到CALayer
 
   核心动画一切都是假象，并不会改变真实的值。
 
 2、什么时候使用UIView的动画？
 
   当需要与用户交互的时候使用UIView动画
 
 3、什么时候使用核心动画？
 
   当动画只是展示，不需要和用户交互时使用，大多数用于转场动画，路径动画等
 */
@end
