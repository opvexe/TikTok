//
//  TTHomeTableViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTHomeTableViewCell.h"
#import "TTMusicAlbumView.h"
#import "TTScrollLabel.h"
#import "TTPlayerView.h"
#import "TTUserModel.h"
@interface TTHomeTableViewCell()<SDCycleScrollViewDelegate,AVPlayerUpdateDelegate>
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)TTPlayerView *playerView;
@property(nonatomic,strong)UIButton *avator;
@property(nonatomic,strong)UIButton *likes;
@property(nonatomic,strong)UIButton *comment;
@property(nonatomic,strong)UIButton *shared;
@property(nonatomic,strong)TTMusicAlbumView *albumView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)TTScrollLabel *srollView;
@property(nonatomic,strong)FLAnimatedImageView *musicIcon;
@property(nonatomic,strong)FLAnimatedImageView *pauses;
@property(nonatomic,strong)TTAwemeModel *model;
@property(nonatomic,strong)CALayer *backgroudLayer;
@property(nonatomic, assign)NSTimeInterval lastTapTime;
@property(nonatomic, assign)CGPoint lastTapPoint;
@property(nonatomic,assign)BOOL isPause;
@property (nonatomic, strong) UIView                   *playerStatusBar;
@end
@implementation TTHomeTableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"TTHomeTableViewCell";
    TTHomeTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TTHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)TTSinitConfingViews{
    
    _backgroudLayer = ({
        CALayer *iv = [CALayer layer];
        iv.contents = (id)[UIImage imageNamed:@"img_video_loading"].CGImage;
        [self.contentView.layer addSublayer:iv];
        iv;
    });
    
    _playerView = ({
        TTPlayerView *iv = [TTPlayerView new];
        iv.delegate = self;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        iv;
    });
    
    _container = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        iv;
    });
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.container addGestureRecognizer:singleTapGesture];
    
    _playerStatusBar = [[UIView alloc]init];
    _playerStatusBar.backgroundColor = [UIColor whiteColor];
    [_playerStatusBar setHidden:YES];
    [_container addSubview:_playerStatusBar];
    [_playerStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).inset(49.5f + TT_TabbarSafeBottomMargin);
        make.width.mas_equalTo(1.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    _pauses = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds =YES;
        iv.hidden = YES;
        [self.container addSubview:iv];
        iv.image = [UIImage imageNamed:@"icon_play_pause"];
        iv.userInteractionEnabled = YES;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.mas_equalTo(self.container);
            make.size.mas_equalTo(CGSizeMake(52.0f, 62.0f));
        }];
        iv;
    });
    
    _avator = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateNormal];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 25.0f;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.borderWidth = 1;
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = TTPlayerTableClickTypeAvator;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.container);
            make.right.mas_equalTo(-10.0f);
            make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        }];
        iv;
    });
    
    _likes = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_home_like_before"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_home_like_after"] forState:UIControlStateSelected];
        [iv setTitle:@"1000" forState:UIControlStateNormal];
        [iv setTitle:@"1000" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        //        iv.tag = TTPlayerTableClickTypeLikes;
        [iv addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:5.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.avator);
            make.top.mas_equalTo(self.avator.mas_bottom).mas_offset(20.0f);
            make.height.mas_equalTo(60.0f);
            make.width.mas_greaterThanOrEqualTo(40.0f);
        }];
        iv;
    });
    
    _comment = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_home_comment"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_home_comment"] forState:UIControlStateHighlighted];
        [iv setTitle:@"1000" forState:UIControlStateNormal];
        [iv setTitle:@"1000" forState:UIControlStateSelected];
        [iv setTitle:@"1000" forState:UIControlStateHighlighted];
        [iv setTitle:@"1000" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.tag = TTPlayerTableClickTypeComment;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:5.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.avator);
            make.top.mas_equalTo(self.likes.mas_bottom).mas_offset(10.0f);
            make.height.mas_equalTo(60.0f);
            make.width.mas_greaterThanOrEqualTo(40.0f);
        }];
        iv;
    });
    
    _shared = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_home_share"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_home_share"] forState:UIControlStateHighlighted];
        [iv setTitle:@"1000" forState:UIControlStateNormal];
        [iv setTitle:@"1000" forState:UIControlStateSelected];
        [iv setTitle:@"1000" forState:UIControlStateHighlighted];
        [iv setTitle:@"1000" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.tag = TTPlayerTableClickTypeShare;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:5.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.avator);
            make.top.mas_equalTo(self.comment.mas_bottom).mas_offset(10.0f);
            make.height.mas_equalTo(60.0f);
            make.width.mas_greaterThanOrEqualTo(40.0f);
        }];
        iv;
    });
    
    
    _albumView = ({
        TTMusicAlbumView *iv = [[TTMusicAlbumView alloc]init];
        iv.tag = TTPlayerTableClickTypeAlbum;
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.avator);
            make.top.mas_equalTo(self.shared.mas_bottom).mas_offset(10.0f);
            make.height.mas_equalTo(50.0f);
            make.width.mas_equalTo(50.0f);
        }];
        iv;
    });
    
    
    [self.albumView WH_whenTapped:^{
        if (self.delegate) {
            [self.delegate playerClickType:self.albumView.tag model:self.model];
        }
    }];
    
    
    _musicIcon = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds =YES;
        [self.container addSubview:iv];
        iv.image = [UIImage imageNamed:@"icon_home_musicnote3"];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.bottom.mas_equalTo(-TT_TabbarHeight-10.0f);
            make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
        }];
        iv;
    });
    
    _srollView = ({
        TTScrollLabel *iv = [[TTScrollLabel alloc]init];
        iv.backgroundColor = [UIColor clearColor];
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.musicIcon.mas_right);
            make.centerY.mas_equalTo(self.musicIcon);
            make.height.mas_equalTo(30.0f);
            make.width.mas_equalTo(self.container).multipliedBy(0.5);
        }];
        iv;
    });
    
    _desc = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.container addSubview:iv];
        iv.numberOfLines = 3.0f;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:14.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.musicIcon);
            make.bottom.mas_equalTo(self.srollView.mas_top).mas_offset(-10.0f);
            make.right.mas_equalTo(-80.0f);
        }];
        iv;
    });
    
    _nickName = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.container addSubview:iv];
        iv.numberOfLines = 3.0f;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.tag = TTPlayerTableClickTypeNickName;
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:16.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.musicIcon);
            make.bottom.mas_equalTo(self.desc.mas_top).mas_offset(-10.0f);
            make.height.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(180.0f);
        }];
        iv;
    });
    
    [self.albumView WH_whenTapped:^{
        if (self.delegate) {
            [self.delegate playerClickType:self.nickName.tag model:self.model];
        }
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _backgroudLayer.frame = self.contentView.bounds;
    [CATransaction commit];
}

///MARK: 调用重用池（下一个cell的调用）
-(void)prepareForReuse {
    [super prepareForReuse];
    
    _isPlayerReady = NO;
    [_playerView cancelLoading];
    [_pauses setHidden:YES];
    [_avator setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateNormal];
    [_albumView resetView];
}
-(void)Click:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate playerClickType:sender.tag model:_model];
    }
}

- (void)startDownloadBackgroundTask {
    [_playerView startDownloadTask:[[NSURL alloc] initWithString:_model.video.play_addr_lowbr.url_list.firstObject] isBackground:NO];
    [_playerView setPlayerWithUrl:_model.video.play_addr_lowbr.url_list.firstObject];
}


-(void)InitDataWithModel:(TTAwemeModel *)model{
    _model = model;
    _isPause = YES;
    self.desc.text = model.desc;
    self.nickName.text = [NSString stringWithFormat:@"@ %@",model.author.nickname];
    [self.comment setTitle:[NSString formatCount:[model.statistics.comment_count integerValue]] forState:UIControlStateNormal];
    [self.shared setTitle:[NSString formatCount:[model.statistics.share_count integerValue]] forState:UIControlStateNormal];
    [self.likes setTitle:[NSString formatCount:[model.statistics.digg_count integerValue]] forState:UIControlStateNormal];
    [self.avator sd_setImageWithURL:[NSURL URLWithString:model.author.avatar_medium.url_list.firstObject] forState:UIControlStateNormal];
    [self.albumView.album  sd_setImageWithURL:[NSURL URLWithString:model.music.cover_thumb.url_list.firstObject]];
    [self.albumView startAnimation:model.rate];
}


-(void)likeClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}


- (void)singleTapGesture:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:_container];
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    
    if (time - _lastTapTime > 0.25f) {
        
        NSLog(@"pause");
        [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
    }else{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
        [self showLikeAnimation:point old:_lastTapPoint];
        [_playerView updatePlayerState];
    }
    
    _lastTapPoint = point;
    _lastTapTime = time;
}

- (void)singleTapAction {
    
    ///mark: 暂停
    if (_isPause) {
        
        _pauses.hidden = NO;
        _pauses.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        _pauses.alpha = 1.0f;
        [self pauseItems];
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.pauses.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:^(BOOL finished) {
            
            self.isPause = NO;
            [self setNeedsLayout];
        }];
        
    }else{
        
            [self play];
        [UIView animateWithDuration:0.25f animations:^{
            
            self.pauses.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.pauses setHidden:YES];
            self.isPause = YES;
        }];
    }
}

-(void)showLikeAnimation:(CGPoint)new old:(CGPoint)old{
    
    UIImageView *likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_like_after"]];
    CGFloat K = ((old.y - new.y))/((old.x -new.x));
    K = fabs(K)<0.5?K:(K > 0 ? 0.5f : -0.5f);
    CGFloat angle = M_PI_4 * -K;
    likeImageView.frame = CGRectMake(new.x, new.y, 80.0f, 80.0f);
    likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 0.8, 1.80f);
    [self.container addSubview:likeImageView];
    
    [UIView animateWithDuration:0.2f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 3.0f, 3.0f);
                             likeImageView.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [likeImageView removeFromSuperview];
                             [self setNeedsLayout];
                         }];
    }];
    
}


//播放进度更新回调方法
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total{
    
    
}

//播放状态更新回调方法
-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status{
    
    switch (status) {
        case AVPlayerItemStatusUnknown:
       
            break;
        case AVPlayerItemStatusReadyToPlay:
                _isPlayerReady = YES;
            
            if(_onPlayerReady) {
                _onPlayerReady();
            }
            break;
        case AVPlayerItemStatusFailed:
            NSLog(@"加载失败");
        
            break;
        default:
            break;
    }
}

- (void)play {
    [_playerView play];
    [_pauses setHidden:YES];
}

- (void)pauseItems {
    [_playerView pause];
    [_pauses setHidden:NO];
}

- (void)replay {
    [_playerView replay];
    [_pauses setHidden:YES];
}


-(void)startLoadingPlayItemAnim:(BOOL)isStart {
    if (isStart) {
        
        _playerStatusBar.backgroundColor = [UIColor whiteColor];
        [_playerStatusBar setHidden:NO];
        [_playerStatusBar.layer removeAllAnimations];
        
        CABasicAnimation *group =[[CABasicAnimation alloc]init];
        group.duration = 0.5f;
        group.beginTime = CACurrentMediaTime() +0.5f;
        group.repeatCount = MAXFLOAT;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        
        
        
    }else{
        [self.playerStatusBar.layer removeAllAnimations];
        [self.playerStatusBar setHidden:YES];
    }
}
@end
