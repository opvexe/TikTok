//
//  UIFont+Category.m
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)
+ (UIFont *)mediumFontOfSize:(CGFloat)fontSize{
    return [UIFont boldSystemFontOfSize:fontSize];
}

+ (UIFont *)FontOfSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)SYPingFangSCLightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

+ (UIFont *)SYPingFangSCRegularFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)SYPingFangSCMediumFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)SYPingFangSCSemiboldFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

+ (UIFont *)SYHelveticaFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"Helvetica" size:fontSize];
}
@end
