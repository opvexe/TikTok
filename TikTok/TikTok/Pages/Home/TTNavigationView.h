//
//  TTNavigationView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"
#import "TTRightItemView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TTNavigationClickType) {
    TTNavigationClickTypeShot,
    TTNavigationClickTypeSegment,
};

@interface TTNavigationView : TTBaseView

@property(nonatomic,strong)TTRightItemView *rightView;


@property(nonatomic,copy)void(^clickBlock)(TTNavigationClickType type,NSInteger selectedSegmentIndex);

@end

NS_ASSUME_NONNULL_END
