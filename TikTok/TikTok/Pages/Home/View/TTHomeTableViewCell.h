//
//  TTHomeTableViewCell.h
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseTableViewCell.h"
#import "TTAwemeModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TTPlayerTableClickType) {
    TTPlayerTableClickTypePause,
    TTPlayerTableClickTypeAvator,
    TTPlayerTableClickTypeLikes,
    TTPlayerTableClickTypeComment,
    TTPlayerTableClickTypeShare,
    TTPlayerTableClickTypeNickName,
};

@interface TTHomeTableViewCell : TTBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
