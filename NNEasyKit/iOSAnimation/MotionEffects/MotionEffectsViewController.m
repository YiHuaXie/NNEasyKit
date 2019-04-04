//
//  MotionEffectsViewController.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/30.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "MotionEffectsViewController.h"

#pragma mark - MyMotionEffect

@interface MyMotionEffect : UIMotionEffect

@end

@implementation MyMotionEffect

- (nullable NSDictionary<NSString *, id> *)keyPathsAndRelativeValuesForViewerOffset:(UIOffset)viewerOffset {
    //打印设备水平角度
    NSLog(@"x:%f,y:%f", viewerOffset.horizontal, viewerOffset.vertical);
    //返回对象是一个字典类型，key是修改UIView的键路径，value是修改的值
    return @{@"center.y": @(fabs(viewerOffset.horizontal * 1000))};
}

@end

#pragma mark - MotionEffectsViewController

@interface MotionEffectsViewController ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UIImageView *mgb1;
@property (weak, nonatomic) IBOutlet UIImageView *mgb2;
@property (weak, nonatomic) IBOutlet UIImageView *ship;
@property (weak, nonatomic) IBOutlet UIImageView *text404;
@property (weak, nonatomic) IBOutlet UIImageView *octocat;

@property (nonatomic, strong) UIView *myView;

@end

@implementation MotionEffectsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupView];
    [self _motionEffects];

//    [self _customMotionEffects];
}


#pragma mark - Private

- (void)_setupView {
    self.bg.frame = CGRectMake(-100, -100, self.width + 200, self.height + 200);
    self.mgb1.frame = CGRectMake(self.width - 250, self.height / 2 - 100, 200, 75);
    self.mgb2.frame = CGRectMake(self.width - 140, self.height / 2 - 150, 120, 50);
    self.ship.frame = CGRectMake(self.width / 3.0, self.height / 2.0, self.width / 3 * 2, self.width / 3.0);
    self.text404.frame = CGRectMake(20, self.height / 3 * 2, self.width / 3.0, self.width / 3.0);
    self.octocat.frame = CGRectMake(self.width / 2 - self.width / 6 + 40,
                                    self.height / 3 * 2,
                                    self.width / 3,
                                    self.width / 3 * 1.2);
}

// 自定义的MotionEffect效果
- (void)_customMotionEffects {
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.myView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.myView];

    [self.myView addMotionEffect:[MyMotionEffect new]];
}

- (void)_motionEffects {
    [self _addInterpolatingMotionEffectWithScope:100 target:self.bg];
    [self _addInterpolatingMotionEffectWithScope:120 target:self.mgb2];
    [self _addInterpolatingMotionEffectWithScope:160 target:self.mgb1];
    [self _addInterpolatingMotionEffectWithScope:480 target:self.ship];
    [self _addInterpolatingMotionEffectWithScope:20 target:self.octocat];
    [self _addInterpolatingMotionEffectWithScope:50 target:self.text404];
}

// UIInterpolatingMotionEffect 是 UIMotionEffect的一个子类，是具体的实现类，实现设备水平角度变化对UI元素的属性

- (void)_addInterpolatingMotionEffectWithScope:(int)scope target:(UIImageView *)target {
    // 水平方向的UIInterpolatingMotionEffect
    UIInterpolatingMotionEffect *xInterpolation = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xInterpolation.minimumRelativeValue = @(-scope);
    xInterpolation.maximumRelativeValue = @(scope);

    // 垂直方向的UIInterpolatingMotionEffect
    UIInterpolatingMotionEffect *yInterpolation = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    yInterpolation.minimumRelativeValue = @(-scope / 2.0);
    yInterpolation.maximumRelativeValue = @(scope / 2.0);

    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xInterpolation, yInterpolation];

    // 将MotionEffe绑定到UI元素上
    [target addMotionEffect:group];
}

#pragma mark - Getter

- (CGFloat)width {
    return self.view.frame.size.width;
}

- (CGFloat)height {
    return self.view.frame.size.height;
}

@end

