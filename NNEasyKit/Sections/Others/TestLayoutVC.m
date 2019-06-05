//
//  TestLayoutVC.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/17.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "TestLayoutVC.h"
#import "NNLabelStyleLayout.h"
#import "NNEasyKit.h"

static ConstString kContentLabel = @"ContentLabel";

@interface TestLayoutVC () <NNLabelStyleLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *data;

@end

@implementation TestLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NNLabelStyleLayout";
    
    NNLabelStyleLayout *layout = [[NNLabelStyleLayout alloc] init];
    layout.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.interitemSpacing = 10;
    layout.lineSpacing = 10;
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView nn_registerCellsWithClasses:@[UICollectionViewCell.class]];
    
    [self.view addSubview:self.collectionView];
    
    [self _requestData];
}

- (void)_requestData {
    self.data = @[@"AAA", @"BBBB", @"dsdasdas", @"adadasdasdas", @"sdgdfgdfgd", @"rfdccsddasdadaas", @"sadasdagsdagsdhgdhajsgdahdgasjhdgsajhdasjhdasdsajdgasa", @"djfdjfk", @"你好", @"阿萨德基督教好就好"];
    
//    CGFloat collectionViewH = [NNLabelStyleLayout heightForCollectionViewWithCount:self.data.count
//                                                                      contentInset:UIEdgeInsetsMake(10, 10, 10, 10) contentMAXWidth:self.view.nn_width
//                                                                       lineSpacing:10
//                                                                  interitemSpacing:10
//                                                                       sizeForItem:^CGSize(NSInteger row) {
//                                                                           return [self labelStyleLayout:nil sizeForItemAtIndex:row];
//                                                                       }];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.nn_classString forIndexPath:indexPath];
    
    UILabel *contentLabel = (UILabel *) [cell.contentView nn_viewWithStringTag:kContentLabel];
    if (!contentLabel) {
        contentLabel = [[UILabel alloc] init];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.nn_stringTag = kContentLabel;
        contentLabel.layer.cornerRadius = 3;
        contentLabel.layer.borderWidth = 0.5;
        contentLabel.font = nn_regularFontSize(13);
        contentLabel.layer.borderColor = nn_colorHexString(@"FF8c07").CGColor;
        contentLabel.layer.backgroundColor = nn_colorHexString(@"FFFFFF").CGColor;
        contentLabel.textColor = nn_colorHexString(@"FF8c07");
        [cell.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    contentLabel.text = self.data[indexPath.item];
    
    return cell;
}

- (CGSize)labelStyleLayout:(UICollectionView *)collectionView sizeForItemAtIndex:(NSUInteger)index {
    CGFloat width = [NSString nn_widthWithString:self.data[index]
                                       maxHeight:20
                                      attributes:@{NSFontAttributeName:nn_regularFontSize(13)}];
    
    CGFloat maxWidth = self.view.nn_width - 10;
    return CGSizeMake(MIN(ceil(width), maxWidth), 20);
}

@end
