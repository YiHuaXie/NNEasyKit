//
//  NNInteractionTransition.h
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/7.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NNTransition.h"

@interface NNInteractionTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, readonly, weak) UIViewController *viewController;

- (void)addToViewController:(UIViewController *)viewController;

@end
