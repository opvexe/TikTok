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
@interface TTHomeTableViewCell()<SDCycleScrollViewDelegate>
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
@property(nonatomic,strong)FLAnimatedImageView *pause;
@property(nonatomic,strong)TTAwemeModel *model;
@property(nonatomic,strong)CALayer *backgroudLayer;
@property(nonatomic, assign)NSTimeInterval lastTapTime;
@property(nonatomic, assign)CGPoint lastTapPoint;
@property(nonatomic,assign)BOOL isPause;
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
        TTPlayerView *iv = [[TTPlayerView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:iv];
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
    
    _pause = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds =YES;
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
    self.backgroudLayer.frame = self.contentView.bounds;
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


-(void)Click:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate playerClickType:sender.tag model:_model];
    }
}

-(void)InitDataWithModel:(TTAwemeModel *)model{
    _model = model;
    self.desc.text = model.desc;
    self.nickName.text = [NSString stringWithFormat:@"@ %@",model.author.nickname];
    [self.comment setTitle:[NSString formatCount:[model.statistics.comment_count integerValue]] forState:UIControlStateNormal];
    [self.shared setTitle:[NSString formatCount:[model.statistics.share_count integerValue]] forState:UIControlStateNormal];
    [self.likes setTitle:[NSString formatCount:[model.statistics.digg_count integerValue]] forState:UIControlStateNormal];
    [self.avator sd_setImageWithURL:[NSURL URLWithString:model.author.avatar_medium.url_list.firstObject] forState:UIControlStateNormal];
    [self.albumView.album  sd_setImageWithURL:[NSURL URLWithString:model.music.cover_thumb.url_list.firstObject]];
    [self.albumView startAnimation:model.rate];
    
    [_playerView setPlayerWithUrl:model.video.play_addr.url_list.firstObject];
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
    }
    
    _lastTapPoint = point;
    _lastTapTime = time;
}

- (void)singleTapAction {
    
    ///mark: 暂停
    if (_isPause) {
        
        _pause.hidden = NO;
        _pause.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        _pause.alpha = 1.0f;
        
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.pause.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:^(BOOL finished) {
            
            self.isPause = NO;
            [self setNeedsLayout];
        }];
        
    }else{
        
        [UIView animateWithDuration:0.25f animations:^{
            
            self.pause.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.pause setHidden:YES];
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

@end
