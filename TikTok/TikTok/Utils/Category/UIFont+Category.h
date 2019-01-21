//
//  UIFont+Category.h
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Category)

/**
 粗体字体
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)mediumFontOfSize:(CGFloat)fontSize;

/**
 正常字体
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)FontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Light
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)SYPingFangSCLightFontOfSize:(CGFloat)fontSize;


/**
 PingFangSC
 
 @param fontSize  设置字体大小
 @return return value description
 */
+ (UIFont *)SYPingFangSCRegularFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Medium
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)SYPingFangSCMediumFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Semibold
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)SYPingFangSCSemiboldFontOfSize:(CGFloat)fontSize;

/**
 SYHelveticaFontOfSize
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)SYHelveticaFontOfSize:(CGFloat)fontSize;

@end
