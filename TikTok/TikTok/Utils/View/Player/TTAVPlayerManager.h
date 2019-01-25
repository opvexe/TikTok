//
//  TTAVPlayerManager.h
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTAVPlayerManager : NSObject

@property (nonatomic, strong) NSMutableArray<AVPlayer *> *playerArray;

+ (TTAVPlayerManager *)shareManager;
+ (void)setAudioMode;
- (void)play:(AVPlayer *)player;
- (void)pause:(AVPlayer *)player;
- (void)pauseAll;
- (void)replay:(AVPlayer *)player;
- (void)removeAllPlayers;

@end

NS_ASSUME_NONNULL_END
