//
//  InteractiveTransition.h
//  iOSAnimation
//
//  Created by 谢翼华 on 2018/10/31.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, readonly, assign) BOOL interacting;
@property (nonatomic, readonly, assign) BOOL shouldComplete;

- (void)addToViewController:(UIViewController *)viewController;

@end
