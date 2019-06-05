//
//  TestNNParallaxVC.m
//  NNEasyKit
//
//  Created by NeroXie on 2019/5/17.
//  Copyright © 2019 NeroXie. All rights reserved.
//

#import "TestNNParallaxVC.h"
#import "NNParallaxView.h"
#import "NNEasyKit.h"

@interface TestNNParallaxVC ()

@end

@implementation TestNNParallaxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NNParallaxView";
    
    NNParallaxView *parallaxView = [[NNParallaxView alloc] initWithFrame:CGRectMake(0, 100, self.view.nn_width, 300)];
    parallaxView.smoothFactor = 0.03;
    [parallaxView setMaxOffsetHorizontal:100 vertical:100];
    parallaxView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    parallaxView.imageView.image = [UIImage imageNamed:@"zaizai.jpg"];
    parallaxView.clipsToBounds = YES;
    [parallaxView startUpdates];
    
    [self.view addSubview:parallaxView];
}

@end
