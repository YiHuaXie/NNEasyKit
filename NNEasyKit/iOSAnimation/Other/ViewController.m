//
//  ViewController.m
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/29.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "ViewController.h"
#import "NNTransitionViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleData;

@property (nonatomic, copy) NSArray *classData;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    self.tableView.rowHeight = 50.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = self.titleData[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls = NSClassFromString(self.classData[indexPath.row]);
    if (indexPath.row == 5) {
        NNTransitionViewController *vc = [cls new];
        vc.showCloseButton = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];
        [self presentViewController:nav animated:YES completion:nil];
        
        return;
    }
    
    [self.navigationController pushViewController:[cls new] animated:YES];
}

#pragma mark - Getter

- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"UIView动画", @"Core Animation", @"UIKit 力学行为", @"MotionEffects", @"自定义转场", @"NNTransition"];
    }
    
    return _titleData;
}

- (NSArray *)classData {
    if (!_classData) {
        _classData = @[
                @"UIViewAnimationVC",
                @"CoreAnimationVC",
                @"UIKitDynamicsVC",
                @"MotionEffectsViewController",
                @"AViewController",
                @"NNTransitionViewController",
        ];
    }
    
    return _classData;
}

@end
