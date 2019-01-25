//
//  TTPlayerView.m
//  TikTok
//
//  Created by FaceBooks on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTPlayerView.h"
#import "TTAVPlayerManager.h"
@interface TTPlayerView ()<AVAssetResourceLoaderDelegate>
@property (nonatomic ,strong) NSURL         *sourceURL;              //视频路径
@property (nonatomic ,strong) NSString      *sourceScheme;           //路径Scheme
@property (nonatomic ,strong) AVPlayer      *player;                 //视频播放器
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;            //视频播放器图形化载体
@property (nonatomic ,strong) AVURLAsset    *urlAsset;               //视频资源
@property (nonatomic ,strong) AVPlayerItem  *playerItem;             //视频资源载体


@property (nonatomic, strong) dispatch_queue_t  cancelLoadingQueue;

@property (nonatomic, copy) NSString         *cacheFileKey;           //缓存文件key值

@end
@implementation TTPlayerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化播放器
        _player = [[AVPlayer alloc]init];
        
        //试图展示载体
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _playerLayer.frame = self.layer.bounds;
        [self.layer addSublayer:_playerLayer];
        
        //初始化取消队列
        _cancelLoadingQueue = dispatch_queue_create("com.start.cancelloadingqueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

//设置播放路径
-(void)setPlayerWithUrl:(NSString *)url{
    
    self.sourceURL = [NSURL URLWithString:url];
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self.sourceURL resolvingAgainstBaseURL:NO];
    self.sourceScheme = components.scheme;
    
    //路径作为视频缓存key
    _cacheFileKey = self.sourceURL.absoluteString;
    
     __weak __typeof(self) wself = self;
    
    //初始化AVURLAsset
    wself.urlAsset = [AVURLAsset URLAssetWithURL:wself.sourceURL options:nil];
    //设置AVAssetResourceLoaderDelegate代理
    [wself.urlAsset.resourceLoader setDelegate:wself queue:dispatch_get_main_queue()];
    //初始化AVPlayerItem
    wself.playerItem = [AVPlayerItem playerItemWithAsset:wself.urlAsset];
    //观察playerItem.status属性
//    [wself.playerItem addObserver:wself forKeyPath:@"status" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    //切换当前AVPlayer播放器的视频源
    wself.player = [[AVPlayer alloc] initWithPlayerItem:wself.playerItem];
    wself.playerLayer.player = wself.player;
    
}





//播放
- (void)play{
       [[TTAVPlayerManager shareManager] play:_player];
}

//暂停
- (void)pause{
         [[TTAVPlayerManager shareManager] pause:_player];
}

//重新播放
- (void)replay{
         [[TTAVPlayerManager shareManager] replay:_player];
}

//播放速度
- (CGFloat)rate{
    return [_player rate];
}

//重新请求
- (void)retry{
    
}
@end
