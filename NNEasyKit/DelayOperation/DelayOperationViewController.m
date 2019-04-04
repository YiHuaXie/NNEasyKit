//
//  DelayOperationViewController.m
//  DelayOperation
//
//  Created by NeroXie on 2018/11/28.
//  Copyright © 2018 NeroXie. All rights reserved.
//

#import "DelayOperationViewController.h"

typedef void (^NNDispatchDelayBlock) (BOOL cancel);

NNDispatchDelayBlock NNDispatchDelay(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
    if (!block) {
        return nil;
    }
    
    __block dispatch_block_t blockCopy = [block copy];
    __block NNDispatchDelayBlock delayBlockCopy = nil;
   
    NNDispatchDelayBlock delayBlock = ^(BOOL cancel) {
        if (!cancel && blockCopy) {
            blockCopy();
        }
        
        blockCopy = nil;
        delayBlockCopy = nil;
    };
    
    delayBlockCopy = [delayBlock copy];
    
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(when, queue, ^{
        if (delayBlockCopy) delayBlockCopy(NO);
    });
    
    return delayBlockCopy;
}

void NNDispatchCancel(NNDispatchDelayBlock block) {
    if (!block) {
        return;
    }
    
    block(YES);
}

@interface DelayOperationViewController ()

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy) NNDispatchDelayBlock delayBlock;

@end

@implementation DelayOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)_didDispatchAfterPressed:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%s", __func__);
    });
}

- (IBAction)_didPerformSelectorPressed:(id)sender {
    [self performSelector:@selector(_testPerformSelector) withObject:nil afterDelay:2.0];
}

- (IBAction)_didNSTimerPressed:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(_testTimerFired) userInfo:nil repeats:NO];
}

- (IBAction)_didDispatchAfterCancelPressed:(id)sender {
    NNDispatchCancel(self.delayBlock);
    self.delayBlock = NNDispatchDelay(2.0, dispatch_get_main_queue(), ^{
        NSLog(@"%s", __func__);
    });
    
//    NNDispatchDelay(0.0, dispatch_get_main_queue(), ^{
//        NSLog(@"%s", __func__);
//    });
}

- (IBAction)_didPerformSelectorCancelPressed:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_testPerformSelector) object:nil];
    [self performSelector:@selector(_testPerformSelector) withObject:nil afterDelay:2.0];
}

- (IBAction)_didNSTimerCancelPressed:(id)sender {
    [self.timer invalidate];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(_testTimerFired) userInfo:nil repeats:NO];
    self.timer = timer;
}

- (void)_testPerformSelector {
    NSLog(@"%s", __func__);
}

- (void)_testTimerFired {
    NSLog(@"%s", __func__);
}

@end



