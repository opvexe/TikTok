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
typedef void (^OnPlayerReady)(void);

typedef NS_ENUM(NSUInteger, TTPlayerTableClickType) {
    TTPlayerTableClickTypePlay,
    TTPlayerTableClickTypeAvator,
    TTPlayerTableClickTypeLikes,
    TTPlayerTableClickTypeComment,
    TTPlayerTableClickTypeShare,
    TTPlayerTableClickTypeAlbum,
    TTPlayerTableClickTypeNickName,
};

@protocol TTPlayerTableClickDelegate
@optional
- (void)playerClickType:(TTPlayerTableClickType )type model:(TTBaseModel *)model;
@end

@interface TTHomeTableViewCell : TTBaseTableViewCell

@property(nonatomic,weak) id <TTPlayerTableClickDelegate>delegate;

- (void)startDownloadBackgroundTask;
- (void)startDownloadHighPriorityTask;
- (void)play;
- (void)pause;
- (void)replay;
@property (nonatomic, strong) OnPlayerReady    onPlayerReady;
@property (nonatomic, assign) BOOL             isPlayerReady;
@end

NS_ASSUME_NONNULL_END
