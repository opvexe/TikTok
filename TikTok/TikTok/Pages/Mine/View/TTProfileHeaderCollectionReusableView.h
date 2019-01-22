//
//  TTProfileHeaderCollectionReusableView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseCollectionReusableView.h"
#import "TTSlideTabBar.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TTUserHeaderDidClickType) {
    TTUserHeaderDidClickTypeAvatar,
    TTUserHeaderDidClickTypeSetting,
    TTUserHeaderDidClickTypeAddsFriends,
    TTUserHeaderDidClickTypeSendMessage,
    TTUserHeaderDidClickTypeFocusAction,
    TTUserHeaderDidClickTypeAboutMe,
    TTUserHeaderDidClickTypeLikes,
    TTUserHeaderDidClickTypeFocuse,
    TTUserHeaderDidClickTypeFollowed,
};

@protocol TTUserHeaderDelegate
@optional
- (void)clickUserWithType:(TTUserHeaderDidClickType )type withUser:(TTBaseModel *)model;
@end

@interface TTProfileHeaderCollectionReusableView : TTBaseCollectionReusableView

@property(nonatomic,weak)id <TTUserHeaderDelegate> delegate;

@property(nonatomic,strong)TTSlideTabBar *slideTabBar;

- (void)overScrollAction:(CGFloat) offsetY;

- (void)scrollToTopAction:(CGFloat) offsetY;

@end

NS_ASSUME_NONNULL_END
