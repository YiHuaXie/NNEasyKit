//
//  NNCarouselCell.m
//  NNCarousel
//
//  Created by NeroXie on 2019/2/18.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "NNCarouselCell.h"

@interface NNCarouselCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation NNCarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (void)addLabel {
    self.label = [[UILabel alloc]init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.label];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}

@end
