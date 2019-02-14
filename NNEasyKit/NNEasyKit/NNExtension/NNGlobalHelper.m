//
//  NNGlobalHelper.m
//  NNProject
//
//  Created by 谢翼华 on 2018/9/18.
//  Copyright © 2018年 谢翼华. All rights reserved.
//

#import "NNGlobalHelper.h"
#import <objc/runtime.h>
#import <sys/utsname.h>

#import "NNDefineMacro.h"

#import "NSString+NNExtension.h"
#import "UIColor+NNExtension.h"
#import "UIFont+NNExtension.h"

#define MainBundle                   [NSBundle mainBundle]
#define CurrentDevice                [UIDevice currentDevice]

#pragma mark - Make Sure

NSString* nn_makeSureString(NSString *string) {
    if ([string isKindOfClass:NSString.class]) {
        return string;
    }
    
    if ([string isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)string stringValue];
    }
    
    return @"";
}

NSDictionary* nn_makeSureDictionary(NSDictionary *dict) {
    return [dict isKindOfClass:NSDictionary.class] ? dict : @{};
}

NSArray* nn_makeSureArray(NSArray *array) {
    return [array isKindOfClass:NSArray.class] ? array : @[];
}

#pragma mark - Cancel Dispatch After

NNDispatchDelayBlock nn_dispatch_delay(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
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
        NN_BLOCK_EXEC(delayBlockCopy, NO);
    });
    
    return delayBlockCopy;
}

void nn_dispatch_cancel(NNDispatchDelayBlock block) {
    NN_BLOCK_EXEC(block, YES);
}

#pragma mark - Weak Associated Object

@interface _NNWeakAssociatedWrapper : NSObject

@property (nonatomic, weak) id associatedObject;

@end

@implementation _NNWeakAssociatedWrapper

@end

void nn_objc_setWeakAssociatedObject(id object, const void * key, id value) {
    _NNWeakAssociatedWrapper *wrapper = objc_getAssociatedObject(object, key);
    if (!wrapper) {
        wrapper = [_NNWeakAssociatedWrapper new];
        objc_setAssociatedObject(object, key, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    wrapper.associatedObject = value;
}

id nn_objc_getWeakAssociatedObject(id object, const void * key) {
    id wrapper = objc_getAssociatedObject(object, key);
    
    id objc = wrapper && [wrapper isKindOfClass:_NNWeakAssociatedWrapper.class] ?
    [(_NNWeakAssociatedWrapper *)wrapper associatedObject] :
    nil;
    
    return objc;
}

#pragma mark - APP Information

NSString* nn_deviceName(void) {
    return CurrentDevice.name;
}

NSString* nn_deviceModel(void) {
    return CurrentDevice.model;
}

NSString* nn_systemVersion(void) {
    return CurrentDevice.systemVersion;
}

NSString* nn_deviceModelName(void) {
    return nil;
}

NSString* nn_appName(void) {
    return MainBundle.infoDictionary[@"CFBundleDisplayName"];
}

NSString* nn_appVersion(void) {
    return MainBundle.infoDictionary[@"CFBundleShortVersionString"];
}

NSString* nn_appBuildVersion(void) {
    return MainBundle.infoDictionary[@"CFBundleVersion"];
}

