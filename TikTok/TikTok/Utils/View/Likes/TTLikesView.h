//
//  TTLikesView.h
//  TikTok
//
//  Created by FaceBook on 2019/2/2.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTLikesView : TTBaseView

@property (nonatomic, strong) UIImageView      *favoriteBefore;
@property (nonatomic, strong) UIImageView      *favoriteAfter;

- (void)resetView;

@end

NS_ASSUME_NONNULL_END
