//
//  TTPopShowView.h
//  TikTok
//
//  Created by FaceBooks on 2019/2/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TTPopShowType) {
        TTPopShowTypeCancle,
        TTPopShowTypeSure,
};

@interface TTPopShowView : UIView

- (instancetype)initWithComment:(NSString *)comment;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
