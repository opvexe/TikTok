//
//  TTTools.h
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTools : NSObject


+(CGFloat)getHeightContain:(NSString *)string font:(UIFont *)font Width:(CGFloat) width;


+(CGFloat)getWidthContain:(NSString *)string font:(UIFont *)font Height:(CGFloat) height;

@end

NS_ASSUME_NONNULL_END
