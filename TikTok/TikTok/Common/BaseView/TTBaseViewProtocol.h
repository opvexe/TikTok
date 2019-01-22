//
//  TTBaseViewProtocol.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TTBaseModel;
@protocol TTBaseViewProtocol <NSObject>
@optional
/**
 *  获取数据
 */
-(void)TTSGetDataSoucre;
/**
 *  添加视图
 */
-(void)TTSAddSubviews;
/**
 *  初始视图
 */
- (void)TTSInitConfingViews;
/**
 *  配置数据
 */
- (void)TTSSetupViewModel;

-(void)InitDataWithModel:(TTBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
