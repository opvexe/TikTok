//
//  TTPlayerView.h
//  TikTok
//
//  Created by FaceBooks on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TTPlayerView : UIView

//设置播放路径
-(void)setPlayerWithUrl:(NSString *)url;


//播放
- (void)play;

//暂停
- (void)pause;

//重新播放
- (void)replay;

//播放速度
- (CGFloat)rate;

//重新请求
- (void)retry;

@end

NS_ASSUME_NONNULL_END
