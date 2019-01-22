//
//  TTBaseCollectionViewCellProtocol.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TTBaseModel;
@protocol TTBaseCollectionViewCellProtocol <NSObject>

@optional

- (void)TTSinitConfingViews;

-(void)TTConfigSignalDataSoucre;

-(void)InitDataWithModel:(TTBaseModel *)model;

+(CGFloat)getCellHeight:(TTBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
