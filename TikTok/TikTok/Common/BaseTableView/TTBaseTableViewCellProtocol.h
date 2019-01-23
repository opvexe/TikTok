//
//  TTBaseTableViewCellProtocol.h
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TTBaseModel;
@protocol TTBaseTableViewCellProtocol <NSObject>
@optional
/**
 *  初始视图
 */
- (void)TTSinitConfingViews;
/**
 *  配置数据
 */
- (void)TTSetupViewModel;
/**
 *  配置信号数据
 */
-(void)TTConfigSignalDataSoucre;

-(void)InitDataWithModel:(TTBaseModel *)model;

+(CGFloat)getCellHeight:(TTBaseModel *)model;
@end

NS_ASSUME_NONNULL_END
