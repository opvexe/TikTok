//
//  TTAwemeModel.h
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TTUserModel;
@class TTAwemeMusicModel;
@class TTAwemeVideoModel;
@class TTAwemeCoverModel;
@class TTAwemeStatisticsModel;
@interface TTAwemeModel : TTBaseModel

@property(nonatomic,strong)TTUserModel *author;

@property(nonatomic,strong)TTAwemeVideoModel *video;

@property(nonatomic,strong)TTAwemeStatisticsModel *statistics;

@property(nonatomic,strong)TTAwemeMusicModel *music;

@property(nonatomic,copy)NSString *desc;
@end


@interface TTAwemeVideoModel :TTBaseModel

@property(nonatomic,strong)TTAwemeCoverModel *origin_cover;

@end



@interface TTAwemeCoverModel :TTBaseModel

@property(nonatomic,strong)NSArray *url_list;

@end

@interface TTAwemeStatisticsModel :TTBaseModel

@property(nonatomic,copy)NSString *digg_count;

@property(nonatomic,copy)NSString *share_count;

@property(nonatomic,copy)NSString *comment_count;

@end

@interface TTAwemeMusicModel : TTBaseModel

@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)TTAwemeCoverModel *cover_thumb;
@end

NS_ASSUME_NONNULL_END
