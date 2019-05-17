//
//  TestNNAlertViewVC.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/17.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "TestNNAlertViewVC.h"
#import "CustomView.h"

@interface TestNNAlertViewVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *data1;
@property (nonatomic, copy) NSArray *data2;

@end

@implementation TestNNAlertViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NNAlertView";
    
    [self _addTableView];
    
    self.data1 = @[@"随机动画弹出", @"有蒙板", @"无阴影", @"自定义视图"];
    self.data2 = @[@"NNNormalAlertView 两个按钮", @"NNNormalAlertView 三个按钮", @"NNNormalAlertView 带图片"];
}

- (void)_addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView nn_registerCellsWithClasses:@[UITableViewCell.class]];
    [tableView nn_registerHeaderFootersWithClasses:@[UITableViewHeaderFooterView.class]];
    tableView.rowHeight = 60;
    
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.data1.count : self.data2.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = indexPath.section == 0 ? self.data1[indexPath.row] : self.data2[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(UITableViewHeaderFooterView.class)];
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"NNAlertView" : @"NNNormalAlertView";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NNAlertView *view = nil;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                view = [NNAlertView showAlertWithLayoutContent:nil animationType:arc4random() % 4];
                break;
            case 1:
                view = [NNAlertView showAlertWithLayoutContent:nil animationType:NNAlertViewAnimationTypeZoom];
                view.backgroundViewColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                break;
            case 2:
                view = [NNAlertView showAlertWithLayoutContent:nil animationType:NNAlertViewAnimationTypeDrop];
                view.backgroundViewColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                view.alertShadowHidden = YES;
                break;
            case 3: {
                CustomView *customView = [CustomView nn_createWithNib];
                view = [NNAlertView showAlertWithLayoutContent:^(UIView *contentView) {
                    // 这里只能使用约束，分为两步
                    // 1.设置子视图与contentView间的约束
                    // 2.设置contentView的宽高约束
                    [contentView addSubview:customView];
                    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(contentView);
                    }];
                    
                    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(300, 200));
                    }];
                } animationType:NNAlertViewAnimationTypeDrop];
                
                view.backgroundViewColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                view.alertShadowColor = [UIColor yellowColor];
            }
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                view = [NNNormalAlertView showAlertWithTitle:@"NNNormalAlertView"
                                                     message:@"NNNormalAlertViewNNNormalAlertView"
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@[@"1"]
                                               buttonHandler:nil];
                break;
            case 1:
                view = [NNNormalAlertView showAlertWithTitle:@"NNNormalAlertView"
                                                     message:@"NNNormalAlertViewNNNormalAlertView"
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@[@"1", @"2"]
                                               buttonHandler:nil];
                
                break;
            case 2:
                view = [NNNormalAlertView showAlertWithImage:[UIImage imageNamed:@"error"]
                                                       title:@"1"
                                                     message:@"2"
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:nil
                                               buttonHandler:nil];
                break;
            default:
                break;
        }
    }
    
    [view show];
}



@end
