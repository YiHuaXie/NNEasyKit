//
//  TestNNCarouselVC.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/17.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "TestNNCarouselVC.h"
#import "NNCarousel.h"
#import "NNCarouselCell.h"
#import "NNEasyKit.h"

@interface TestNNCarouselVC () <NNCarouselDataSource, NNCarouselDelegate>

@property (nonatomic, strong) NNCarousel *carousel1;
@property (nonatomic, strong) NNCarousel *carousel2;
@property (nonatomic, strong) NNCarousel *carousel3;
@property (nonatomic, strong) NNCarousel *carousel4;
@property (nonatomic, strong) NNCarousel *carousel5;

@property (nonatomic, copy) NSArray *data;

@end

@implementation TestNNCarouselVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NNCarousel";
    
    [self addCarousel];
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.carousel1.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 100);
    self.carousel2.frame = CGRectMake(0, 165, CGRectGetWidth(self.view.frame), 100);
    self.carousel3.frame = CGRectMake(0, 265, CGRectGetWidth(self.view.frame), 100);
    self.carousel4.frame = CGRectMake(0, 365, CGRectGetWidth(self.view.frame), 100);
    self.carousel5.frame = CGRectMake(0, 465, CGRectGetWidth(self.view.frame), 100);
}

#pragma mark - Private

- (void)addCarousel {
    self.carousel1 = [self _createCarousel];
    self.carousel1.carouselScrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.carousel1.autoScrollInterval = 1.0;
    self.carousel1.infiniteLoop = YES;
    
    self.carousel2 = [self _createCarousel];
    self.carousel2.timerSrollDirection = NNCarouselScrollDirectionRTL;
    self.carousel2.layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    self.carousel2.autoScrollInterval = 1.0;
    self.carousel2.layout.itemSpacing = 0;

    self.carousel3 = [self _createCarousel];
    self.carousel3.timerSrollDirection = NNCarouselScrollDirectionBTT;
    self.carousel3.autoScrollInterval = 1.0;
    self.carousel3.layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 100);

    self.carousel4 = [self _createCarousel];
    self.carousel4.timerSrollDirection = NNCarouselScrollDirectionTTB;
    self.carousel4.autoScrollInterval = 1.0;
    self.carousel4.layout.itemSize = CGSizeMake(self.view.nn_width * 0.8, 100 * 0.8);
    self.carousel4.layout.itemSpacing = 5;
    
    self.carousel5 = [self _createCarousel];
    self.carousel5.autoScrollInterval = 1.0;
    self.carousel5.layout.itemSize = CGSizeMake(self.view.nn_width * 0.8, 100 * 0.8);
    self.carousel5.layout.itemSpacing = 5;
    self.carousel5.infiniteLoop = NO;
    self.carousel5.firstOrLastItemCenterWhenNotInfiniteLoop = YES;
}

- (NNCarousel *)_createCarousel {
    NNCarousel *carousel = [[NNCarousel alloc] init];
    carousel.layer.borderWidth = 1;
    carousel.infiniteLoop = YES;
    carousel.autoScrollInterval = 0.0;
    carousel.dataSource = self;
    carousel.delegate = self;
    
    carousel.layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 0.8, 100 * 0.8);
    carousel.layout.itemSpacing = 10;
    
    [carousel registerClass:[NNCarouselCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:carousel];
    
    return carousel;
}

- (UILabel *)_createLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.nn_width - 30, 15)];
    label.textColor = UIColor.blackColor;
    label.font = nn_regularFontSize(14);
    
    [self.view addSubview:label];
    
    return label;
}

- (void)loadData {
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
        if (i == 0) {
            [data addObject:[UIColor redColor]];
            continue;
        }
        
        [data addObject: nn_rgba(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0)];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.data = [data copy];
        [self.carousel1 reloadData];
        [self.carousel1 scrollToItem:1 animated:NO];
        [self.carousel2 reloadData];
        [self.carousel3 reloadData];
        [self.carousel4 reloadData];
        [self.carousel5 reloadData];
    });
}

- (NSInteger)numberOfItemsInCarousel:(NNCarousel *)carousel {
    return self.data.count;
}

- (UICollectionViewCell *)carousel:(NNCarousel *)carousel cellForItem:(NSInteger)item {
    NNCarouselCell *cell = [carousel dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:item];
    cell.backgroundColor = self.data[item];
    cell.label.textColor = UIColor.blackColor;
    cell.label.text = [NSString stringWithFormat:@"item->%ld", item];
    
    return cell;
}

- (void)carousel:(NNCarousel *)carousel didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

@end
