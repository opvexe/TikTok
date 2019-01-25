//
//  TTCacheManager.m
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTCacheManager.h"

@implementation TTCacheManager

+ (TTCacheManager *)sharedWebCache {
    static dispatch_once_t once;
    static TTCacheManager *instance;
    dispatch_once(&once, ^{
        instance = [[TTCacheManager alloc]init];
    });
    return instance;
}

@end
