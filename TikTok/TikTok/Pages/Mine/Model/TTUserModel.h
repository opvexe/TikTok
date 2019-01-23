//
//  TTUserModel.h
//  TikTok
//
//  Created by FaceBooks on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TTUserAvatarModel;
@interface TTUserModel : TTBaseModel

@property(nonatomic,copy)NSString *uid;

/**
 * 抖音号
 */
@property(nonatomic,copy)NSString *short_id;

/**
 * 关注数||粉丝数
 */
@property(nonatomic,copy)NSString *following_count;

/**
 * 用户头像
 */
@property(nonatomic,strong)TTUserAvatarModel *avatar_medium;

/**
 * 用户性别 1：男性 2 女性
 */
@property(nonatomic,copy)NSString *gender;

/**
 * 获赞数
 */
@property(nonatomic,copy)NSString *total_favorited;

/**
 * 作品数
 */
@property(nonatomic,copy)NSString *aweme_count;

/**
 * 动态数
 */
@property(nonatomic,copy)NSString *favoriting_count;

/**
 * 学校名
 */
@property(nonatomic,copy)NSString *school_name;

/**
 * 签名
 */
@property(nonatomic,copy)NSString *signature;

/**
 * 用户名
 */
@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *cover_thumb;
@end


@interface TTUserAvatarModel : TTBaseModel

@property(nonatomic,strong)NSArray *url_list;

@end


NS_ASSUME_NONNULL_END
