//
//  TTPublishViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTPublishViewController.h"
#import "TTCameraToolView.h"
@interface TTPublishViewController ()<AVCaptureFileOutputRecordingDelegate>
//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession *session;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
//照片输出流对象
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutPut;
//视频输出流
@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutPut;
//预览图层，显示相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//聚焦图
@property (nonatomic, strong) UIImageView *focusCursorImageView;
//录制视频保存的url
@property (nonatomic, strong) NSURL *videoUrl;
//MARK:
@property (nonatomic, assign) AVCaptureVideoOrientation orientation;
@property(nonatomic,strong)TTCameraToolView *cameraView;
@end

@implementation TTPublishViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.session startRunning];
    [self setFocusCursorWithPoint:self.view.center];  ///MARK:摄像头聚焦
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (self.session) {
        [self.session stopRunning];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self setupCamera];
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (!granted) {
                    [self popBack];
                } else {
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive) name:UIApplicationWillResignActiveNotification object:nil];
                }
            }];
        } else {
            [self popBack];
        }
    }];
    
    ///MARK: 暂停其他音乐
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

-(void)configView{
    _cameraView = ({
        TTCameraToolView *iv = [[TTCameraToolView alloc]init];
        iv.backgroundColor = [UIColor blackColor];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.edges.mas_equalTo(self.view.safeAreaInsets);
            }else{
                make.edges.mas_equalTo(self.view);
            }
        }];
        iv;
    });
    
    _focusCursorImageView = ({
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focusing_button"]];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.clipsToBounds = YES;
        iv.frame = CGRectMake(0, 0, 65.0f, 65.0f);
        iv.alpha = 0;
        [self.view addSubview:iv];
        iv;
    });
    
    __weak typeof (self) wself = self;
    [self.cameraView setCameraBlock:^(TTCameraType type) {
        switch (type) {
            case TTCameraTypeClose:{
                [wself popBack];
            }
                break;
            case TTCameraTypeMusic:{
                
            }
                break;
            case TTCameraTypePostion:{
                [wself ChangeCameraAction];
            }
                break;
            default:
                break;
        }
    }];
    
    ///MARK:添加平移手势(调整焦距)
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(adjustCameraFocus:)];
    [self.view addGestureRecognizer:pan];
}

-(void)setupCamera{
    
    ///MARK:创建session
    self.session = [[AVCaptureSession alloc] init];
    
    //相机画面输入流
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self backCamera] error:nil];
    
    //照片输出流
    self.imageOutPut = [[AVCaptureStillImageOutput alloc] init];
    
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *dicOutputSetting = [NSDictionary dictionaryWithObject:AVVideoCodecJPEG forKey:AVVideoCodecKey];
    [self.imageOutPut setOutputSettings:dicOutputSetting];
    
    //音频输入流
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio].firstObject;
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:nil];
    
    //视频输出流
    //设置视频格式
    NSString *preset = [self transformSessionPreset];
    if ([self.session canSetSessionPreset:preset]) {
        self.session.sessionPreset = preset;
    } else {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    
    self.movieFileOutPut = [[AVCaptureMovieFileOutput alloc] init];
    
    //将视频及音频输入流添加到session
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddInput:audioInput]) {
        [self.session addInput:audioInput];
    }
    //将输出流添加到session
    if ([self.session canAddOutput:self.imageOutPut]) {
        [self.session addOutput:self.imageOutPut];
    }
    if ([self.session canAddOutput:self.movieFileOutPut]) {
        [self.session addOutput:self.movieFileOutPut];
    }
    //预览层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.view.layer setMasksToBounds:YES];
    
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections{
    
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error{
    
}

/*
 * 手势事件
 */
#pragma mark 点击屏幕聚焦
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.session.isRunning) return;
    
    CGPoint point = [touches.anyObject locationInView:self.view];
    if (point.y > [UIScreen mainScreen].bounds.size.height-150-TT_TabbarSafeBottomMargin) {
        return;
    }
    [self setFocusCursorWithPoint:point];
}

- (void)adjustCameraFocus:(UIPanGestureRecognizer *)pan{
    //TODO: 录像中，点击屏幕聚焦，暂时没有思路，1.若添加tap手势 无法解决pan和tap之间的冲突； 2.使用系统touchesBegan方法，触发pan手势后 touchesBegan 无效
    
}
///MARK: 摄像头聚焦
- (void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursorImageView.center = point;
    self.focusCursorImageView.alpha = 1;
    self.focusCursorImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 animations:^{
        self.focusCursorImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursorImageView.alpha=0;
    }];
    
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

//设置聚焦点
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    AVCaptureDevice * captureDevice = [self.videoInput device];
    NSError * error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if (![captureDevice lockForConfiguration:&error]) {
        return;
    }
    //聚焦模式
    if ([captureDevice isFocusModeSupported:focusMode]) {
        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    //聚焦点
    if ([captureDevice isFocusPointOfInterestSupported]) {
        [captureDevice setFocusPointOfInterest:point];
    }
    //曝光模式
    if ([captureDevice isExposureModeSupported:exposureMode]) {
        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    //曝光点
    if ([captureDevice isExposurePointOfInterestSupported]) {
        [captureDevice setExposurePointOfInterest:point];
    }
    [captureDevice unlockForConfiguration];
}


#pragma mark  摄像头事件
///MARK: 切换摄像头
- (void)ChangeCameraAction{
    NSUInteger cameraCount = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count;
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = self.videoInput.device.position;
        if (position == AVCaptureDevicePositionBack) {
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        } else if (position == AVCaptureDevicePositionFront) {
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        } else {
            return;
        }
        
        if (newVideoInput) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                self.videoInput = newVideoInput;
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"切换前后摄像头失败");
        }
    }
}

///MARK: 前置摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

///MARK: 后置摄像头
- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

///MARK: 判断摄像头位置
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

#pragma mark  拍照事件
- (void)onTakePicture{
    AVCaptureConnection * videoConnection = [self.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
    videoConnection.videoOrientation = self.orientation;
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.imageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        NSLog(@"拍照图片:%@",image);
        [weakSelf.session stopRunning];
    }];
}

#pragma mark 录制视频事件
- (void)onStartRecord{
    AVCaptureConnection *movieConnection = [self.movieFileOutPut connectionWithMediaType:AVMediaTypeVideo];
    movieConnection.videoOrientation = self.orientation;
    [movieConnection setVideoScaleAndCropFactor:1.0];
    if (![self.movieFileOutPut isRecording]) {
        NSURL *url = [NSURL fileURLWithPath:[self getVideoExportFilePath:self.videoType]];
        [self.movieFileOutPut startRecordingToOutputFileURL:url recordingDelegate:self];
    }
}

///MARK: 录制视频存储地址
 -(NSString *)getVideoExportFilePath:(ZLExportVideoType)type{
    NSString *format = (type == ZLExportVideoTypeMov ? @"mov" : @"mp4");
    NSString *exportFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", [NSString getUniqueStrByUUID], format]];
    return exportFilePath;
}


- (NSString *)transformSessionPreset{
    switch (self.sessionPreset) {
        case ZLCaptureSessionPreset325x288:
            return AVCaptureSessionPreset352x288;
            
        case ZLCaptureSessionPreset640x480:
            return AVCaptureSessionPreset640x480;
            
        case ZLCaptureSessionPreset1280x720:
            return AVCaptureSessionPreset1280x720;
            
        case ZLCaptureSessionPreset1920x1080:
            return AVCaptureSessionPreset1920x1080;
            
        case ZLCaptureSessionPreset3840x2160:
            return AVCaptureSessionPreset3840x2160;
    }
}

- (void)willResignActive{
    if ([self.session isRunning]) {
        [self popBack];
    }
}



- (void)dealloc{
    if ([_session isRunning]) {
        [_session stopRunning];
    }
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
