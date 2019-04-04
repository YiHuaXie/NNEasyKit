//
//  NNHorizontalSwipeInteractionTransition.m
//  iOSAnimation
//
//  Created by NeroXie on 2018/11/7.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "NNHorizontalSwipeInteractionTransition.h"

@interface NNHorizontalSwipeInteractionTransition ()

@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation NNHorizontalSwipeInteractionTransition

#pragma mark - Public

- (void)addToViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(_handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

#pragma mark - Private

- (void)_handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.y / 400.0;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
@end
