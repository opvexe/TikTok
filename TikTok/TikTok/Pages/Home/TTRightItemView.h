//
//  TTRightItemView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TTRightItemViewClickType) {
    TTRightItemViewClickTypeSearch,
    TTRightItemViewClickTypeLiving,
};

@interface TTRightItemView : TTBaseView

-(void)compelet:(void(^)(TTRightItemViewClickType type))completed;

@end

NS_ASSUME_NONNULL_END
