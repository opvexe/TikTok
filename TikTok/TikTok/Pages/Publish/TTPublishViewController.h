//
//  TTPublishViewController.h
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZLCaptureSessionPreset) {
    ZLCaptureSessionPreset325x288,
    ZLCaptureSessionPreset640x480,
    ZLCaptureSessionPreset1280x720,
    ZLCaptureSessionPreset1920x1080,
    ZLCaptureSessionPreset3840x2160,
};

//导出视频类型
typedef NS_ENUM(NSUInteger, ZLExportVideoType) {
    ZLExportVideoTypeMov,
    ZLExportVideoTypeMp4,
};

@interface TTPublishViewController : TTBaseViewController

@property (nonatomic, assign) CFTimeInterval maxRecordTime;

@property (nonatomic, assign) BOOL allowTakePhoto;

@property (nonatomic, assign) BOOL allowRecordVideo;

@property (nonatomic, assign) NSInteger maxRecordDuration;

@property (nonatomic, strong) UIColor *circleProgressColor;

@property (nonatomic, assign) ZLCaptureSessionPreset sessionPreset;

@property (nonatomic, assign) ZLExportVideoType videoType;

@property (nonatomic, copy) void (^doneBlock)(UIImage *image, NSURL *videoUrl);

@end

NS_ASSUME_NONNULL_END
