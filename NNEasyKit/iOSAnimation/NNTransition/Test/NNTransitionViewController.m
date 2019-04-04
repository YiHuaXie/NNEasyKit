//
//  NNTransitionViewController.m
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/8.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNTransitionViewController.h"
#import "NNCircleSpreadAnimationTransition.h"
#import "NNPortalAnimationTransition.h"
#import "NNExplodeAnimationTransition.h"
#import "NNFlipAnimationTransition.h"
#import "NNScaleAnimationTransition.h"
#import "NNSpreadAnimationTransition.h"

@interface NNTransitionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *titles;

@end

@implementation NNTransitionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.showCloseButton) {
         [self _addCloseButton];
    }
   
    NSString *imageName = [NSString stringWithFormat:@"x%d", arc4random() % 5];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
    self.tableView.backgroundView = imageView;
    self.tableView.rowHeight = 50;
    self.titles = @[@"system push", @"circelSpread", @"portal", @"Explode", @"Flip", @"Scale", @"SpreadFromTop", @"SpreadFromBottom", @"SpreadFromLeft", @"SpreadFromRight"];
    self.data = @[];
}

#pragma mark - Private

- (void)_addCloseButton {
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(_didCloseItemPressed:)];
    self.navigationItem.leftBarButtonItem = closeItem;
}

- (void)_didCloseItemPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
        cell.textLabel.textColor = UIColor.blackColor;
        cell.backgroundColor = UIColor.clearColor;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NNTransitionViewController *vc = [NNTransitionViewController new];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:vc animated:YES];
        return;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return;
    }
    
   
    NNAnimationTransition *transition = [self _transitionWithRow:indexPath.row];
    if (indexPath.section == 0) {
        [self.navigationController nn_pushViewController:vc
                                      animatedTransition:transition
                                                animated:YES];
    } else {
        
    }
}

- (NNAnimationTransition *)_transitionWithRow:(NSInteger)row {
    NNAnimationTransition *transition = nil;
    switch (row) {
        case 1:
            transition = [NNCircleSpreadAnimationTransition transitionWithFocusFrame:CGRectMake(100, 100, 30, 30)];
            break;
        case 2:
            transition = [NNPortalAnimationTransition new];
            break;
        case 3:
            transition = [NNExplodeAnimationTransition new];
            transition.durationTime = 0.5;
            break;
        case 4:
            transition = [NNFlipAnimationTransition new];
            break;
        case 5: {
            NNScaleAnimationTransition *tmp = [NNScaleAnimationTransition new];
            tmp.scale = 3.0;
            transition = tmp;
        }
            break;
        case 6:
        case 7:
        case 8:
        case 9: {
            NNSpreadAnimationTransition *tmp = [NNSpreadAnimationTransition transitionWithDirection:row - 6];
            tmp.durationTime = 0.8;
            transition = tmp;
        }
            break;
        default:
            break;
    }
    
    return transition;
}

@end
