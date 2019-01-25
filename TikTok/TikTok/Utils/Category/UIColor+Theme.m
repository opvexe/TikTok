//
//  UIColor+Theme.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)
+ (UIColor *)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1.f];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

/**
 * 随机色
 */
+(UIColor *)SYColorRandom{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}


/**
 *  主色调
 */
+(UIColor *)MainColor{
    return [UIColor colorWithHex:0x51ac33];
}


/**
 * 辅助线颜色
 */
+(UIColor *)BgLineColor{
    return [UIColor colorWithHex:0xe1e1e1];
}

/**
 *  主文字颜色
 */
+(UIColor *)TextColor{
    return [UIColor colorWithHex:0x646464];
}

/**
 *  文字副标题颜色
 */
+(UIColor *)TextSubTitleColor{
    return [UIColor colorWithHex:0x999999];
}

/**
 *  文字辅助灰色颜色
 */
+(UIColor *)TextGrayColor{
    return [UIColor colorWithHex:0x777777];
}

+(UIColor *)ColorWhiteAlpha20{
    return ColorFromRGBA(255.0, 255.0, 255.0, 0.2);
}

+(UIColor *)ColorWhiteAlpha60{
    return ColorFromRGBA(255.0, 255.0, 255.0, 0.6);
}

+(UIColor *)ColorGrayLight{
    return ColorFromRGBA(40.0, 40.0, 40.0, 1.0);
}

@end
