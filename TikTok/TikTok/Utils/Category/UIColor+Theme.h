//
//  UIColor+Theme.h
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

/**
 * 随机色
 */
+(UIColor *)AT_ColorRandom;

/**
 *  主色调
 */
+(UIColor *)AT_MainColor;
/**
 *  整体背景颜色
 */
+(UIColor *)AT_BgColor;
/**
 * 辅助线颜色
 */
+(UIColor *)AT_BgLineColor;
/**
 *  主文字颜色
 */
+(UIColor *)AT_TextColor;
/**
 *  文字辅助灰色颜色
 */
+(UIColor *)AT_TextGrayColor;
/**
 *  文字副标题颜色
 */
+(UIColor *)AT_TextSubTitleColor;
/**
 *  TableView整体背景颜色
 */
+(UIColor *)AT_BgTableViewColor;

@end
