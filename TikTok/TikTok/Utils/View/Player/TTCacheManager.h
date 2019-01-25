//
//  TTCacheManager.h
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTCacheManager : NSObject

//缓存管理类
+ (TTCacheManager *)sharedWebCache;

@end

NS_ASSUME_NONNULL_END
