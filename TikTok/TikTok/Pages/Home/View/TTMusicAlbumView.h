//
//  TTMusicAlbumView.h
//  TikTok
//
//  Created by FaceBooks on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface TTMusicAlbumView : UIView

@property(nonatomic,copy)NSString *albumURL;

- (void)startAnimation:(CGFloat)rate;

-(void)resetView;

@end

NS_ASSUME_NONNULL_END
