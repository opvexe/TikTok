//
//  TTAVPlayerManager.m
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTAVPlayerManager.h"
@implementation TTAVPlayerManager

+ (TTAVPlayerManager *)shareManager {
    static dispatch_once_t once;
    static TTAVPlayerManager *manager;
    dispatch_once(&once, ^{
        manager = [[TTAVPlayerManager alloc]init];
    });
    return manager;
}

//激活音频会话
+(void)setAudioMode{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _playerArray = [NSMutableArray array];
    }
    return self;
}

-(void)play:(AVPlayer *)player{
    
    [_playerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj pause];
    }];
    
    if (![_playerArray containsObject:player]) {
        [_playerArray addObject:player];
    }
    [player play];
}

-(void)pause:(AVPlayer *)player{
    
    if ([_playerArray containsObject:player]) {
        [player pause];
    }
}

-(void)pauseAll{
    
    [_playerArray enumerateObjectsUsingBlock:^(AVPlayer * obj, NSUInteger idx, BOOL *stop) {
        [obj pause];
    }];
}

-(void)replay:(AVPlayer *)player{
    
    [_playerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj pause];
    }];
    
    if ([_playerArray containsObject:player]) {
        [player seekToTime:kCMTimeZero];
        [self play:player];
    }else{
        [_playerArray addObject:player];
        [self play:player];
    }
}

-(void)removeAllPlayers{
    [_playerArray removeAllObjects];
}

@end
