//
//  TTDismissingAnimator.h
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTDismissingAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect centerFrame;

@end

NS_ASSUME_NONNULL_END
