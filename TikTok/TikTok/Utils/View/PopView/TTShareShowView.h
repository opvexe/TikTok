//
//  TTShareShowView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTShareShowView : TTBaseView

+(TTShareShowView *)creatViewComplelte:(void(^)(NSInteger selectIndexPath))complete;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
