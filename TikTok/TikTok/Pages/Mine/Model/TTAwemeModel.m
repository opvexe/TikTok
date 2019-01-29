//
//  TTAwemeModel.m
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTAwemeModel.h"

@implementation TTAwemeModel

+(NSDictionary*)mj_objectClassInArray{
    return @{@"author":@"TTUserModel",@"video":@"TTAwemeVideoModel",@"statistics":@"TTAwemeStatisticsModel",@"music":@"TTAwemeMusicModel"};
}

@end



@implementation TTAwemeVideoModel
+(NSDictionary*)mj_objectClassInArray{
    return @{@"dynamic_cover":@"TTAwemeCoverModel",@"play_addr_lowbr":@"TTAwemeCoverModel"};
}

@end





@implementation TTAwemeCoverModel


@end



@implementation TTAwemeStatisticsModel


@end


@implementation TTAwemeMusicModel
+(NSDictionary*)mj_objectClassInArray{
    return @{@"cover_thumb":@"TTAwemeCoverModel"};
}

@end


