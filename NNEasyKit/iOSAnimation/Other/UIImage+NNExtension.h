//
//  UIImage+NNExtension.h
//  NNProject
//
//  Created by 谢翼华 on 2018/8/17.
//  Copyright © 2018年 谢翼华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NNCropMode) {
    NNCropModeTopLeft,
    NNCropModeTopCenter,
    NNCropModeTopRight,
    NNCropModeBottomLeft,
    NNCropModeBottomCenter,
    NNCropModeBottomRight,
    NNCropModeLeftCenter,
    NNCropModeRightCenter,
    NNCropModeCenter
};

@interface UIImage (NNExtension)

/**
 * 根据颜色和尺寸创建一张图片，不缓存
 */
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 根据颜色从缓存中获取图片，否则使用CGSizeMake(1, 1)生成图片并缓存
 */
+ (instancetype)imageWithColor:(UIColor *)color;

///**
// * 获取竖屏启动图
// */
//+ (instancetype)portraitLaunchImage;

/*
 * 获取裁剪图片
 */
- (UIImage *)cropToSize:(CGSize)newSize usingMode:(NNCropMode)cropMode;

/**
 * 使用NNCropModeTopLeft获取裁剪图片
 */
- (UIImage *)cropToSize:(CGSize)newSize;

/*
 * Same as 'scale to fill' in IB. newSize越接近原图size，图片越清晰
 */
- (UIImage *)scaleToFillSize:(CGSize)newSize;

/**
 * Same as 'aspect fit' in IB.
 */
- (UIImage *)aspectFitSize:(CGSize)newSize;

/**
 * Same as 'aspect fill' in IB.
 */
- (UIImage *)aspectFillSize:(CGSize)newSize;

/**
 * 根据比例获取缩放图
 */
- (UIImage *)scaleByFactor:(CGFloat)scaleFactor;

@end
