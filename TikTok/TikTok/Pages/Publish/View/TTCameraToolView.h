//
//  TTCameraView.h
//  TikTok
//
//  Created by FaceBook on 2019/2/2.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

typedef NS_ENUM(NSUInteger, TTCameraType) {
    TTCameraTypeClose, //关闭视图
    TTCameraTypeMusic, //选择音乐
    TTCameraTypePostion,///前后摄像头
};
NS_ASSUME_NONNULL_BEGIN

typedef void (^CameraBlock)(TTCameraType type);

@interface TTCameraToolView : TTBaseView

@property(nonatomic,copy)CameraBlock cameraBlock;

@end

NS_ASSUME_NONNULL_END
