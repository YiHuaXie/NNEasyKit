//
//  EntranceViewController.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/17.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "EntranceViewController.h"
#import "NNEasyKit.h"

static ConstString kTitle = @"title";
static ConstString kPage = @"page";

@interface EntranceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *data;

@end

@implementation EntranceViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _addTableView];
    
    self.data = @[
                  @{kTitle: @"NNAlertView", kPage: @"TestNNAlertViewVC"},
                  @{kTitle: @"NNCarousel", kPage: @"TestNNCarouselVC"},
                  @{kTitle: @"NNParallaxView", kPage: @"TestNNParallaxVC"},
                  @{kTitle: @"NNLabelStyleLayout", kPage: @"TestLayoutVC"}
                  ];
}

#pragma mark - Private

- (void)_addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 45;
    [tableView nn_registerCellsWithClasses:@[UITableViewCell.class]];
    
    [self.view addSubview:tableView];
}

- (UIViewController *)_viewControllerWithName:(NSString *)name {
    Class tmpClass = NSClassFromString(name);
    
    if (![tmpClass isSubclassOfClass:UIViewController.class]) {
        return nil;
    }
    
    return [tmpClass new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.nn_classString];
    cell.textLabel.text = self.data[indexPath.row][kTitle];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc = [self _viewControllerWithName:self.data[indexPath.row][kPage]];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
