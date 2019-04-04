//
//  NNInteractionTransition.m
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/7.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNInteractionTransition.h"

@interface NNInteractionTransition()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation NNInteractionTransition

#pragma mark - Lifecycle

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

#pragma mark - Public

- (void)addToViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    viewController.interactionTransition = self;

    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
