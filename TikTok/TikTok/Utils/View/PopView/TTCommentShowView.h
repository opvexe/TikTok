//
//  TTCommentShowView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTCommentShowView : TTBaseView

- (instancetype)initWithCommentId:(NSString *)commentId;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
