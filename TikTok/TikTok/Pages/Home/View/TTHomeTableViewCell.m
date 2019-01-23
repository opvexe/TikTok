//
//  TTHomeTableViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTHomeTableViewCell.h"
#import "TTUserModel.h"
@interface TTHomeTableViewCell()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UIView *playerView;
@property(nonatomic,strong)UIButton *avator;
@property(nonatomic,strong)UIButton *likes;
@property(nonatomic,strong)UIButton *comment;
@property(nonatomic,strong)UIButton *shared;
@property(nonatomic,strong)UIView *music;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)SDCycleScrollView *cycleSrollView;
@property(nonatomic,strong)FLAnimatedImageView *musicIcon;
@property(nonatomic,strong)UIButton *pause;
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
    
    _playerView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
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
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.container addGestureRecognizer:singleTapGesture];
    
    _pause = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        iv.hidden = YES;
        [self.container addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateDisabled];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
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
        [iv setTitle:@"0" forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateHighlighted];
        [iv setTitle:@"0" forState:UIControlStateSelected];
        [iv setTitle:@"0" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
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
        [iv setImage:[UIImage imageNamed:@"icon_home_comment"] forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateHighlighted];
        [iv setTitle:@"0" forState:UIControlStateSelected];
        [iv setTitle:@"0" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
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
        [iv setImage:[UIImage imageNamed:@"icon_home_share"] forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateHighlighted];
        [iv setTitle:@"0" forState:UIControlStateSelected];
        [iv setTitle:@"0" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
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
    
    
    _music = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor yellowColor];
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.avator);
            make.top.mas_equalTo(self.shared.mas_bottom).mas_offset(10.0f);
            make.height.mas_equalTo(50.0f);
            make.width.mas_equalTo(50.0f);
        }];
        iv;
    });
    
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
    
    _cycleSrollView = ({
        SDCycleScrollView *iv = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        iv.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        iv.backgroundColor = [UIColor clearColor];
        iv.onlyDisplayText = YES;
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
        iv.text = @"一个tableview,一个view。两个界面都加载在self.view上，tableview覆盖在view界面上，tableview有个弹簧效果，背景颜色设置透明向下拉伸会看到view一点一点出现，但是因为弹簧效果的原因，拉伸到一定程度松手又会回弹覆盖掉view，有什么办法能让tableview的弹簧效果悬停一下，上滑tableview才会弹回覆盖掉view。有点类似下拉刷新，下拉会出现刷新文字的view，悬停然后向上滑动tableview彻底覆盖掉view。";
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:14.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.musicIcon);
            make.bottom.mas_equalTo(self.cycleSrollView.mas_top).mas_offset(-10.0f);
            make.right.mas_equalTo(-100.0f);
        }];
        iv;
    });
    
    _nickName = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.container addSubview:iv];
        iv.text = @"@ 白皮胖";
        iv.numberOfLines = 3.0f;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:16.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.musicIcon);
            make.bottom.mas_equalTo(self.desc.mas_top).mas_offset(-10.0f);
            make.height.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(180.0f);
        }];
        iv;
    });
    
}

-(void)Click:(UIButton *)sender{
    
    
}

-(void)InitDataWithModel:(TTAwemeModel *)model{
    
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:0];
    [urls addObject:[NSString stringWithFormat:@"%@ - %@", model.music.title, model.music.author]];
    [urls addObject:[NSString stringWithFormat:@"%@ - %@", model.music.title, model.music.author]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleSrollView.titlesGroup = urls;
    });
    
    self.desc.text = model.desc;
    self.nickName.text = [NSString stringWithFormat:@"@ %@",model.author.nickname];
    [self.comment setTitle:model.statistics.comment_count forState:UIControlStateNormal];
    [self.shared setTitle:model.statistics.share_count forState:UIControlStateNormal];
    [self.likes setTitle:model.statistics.digg_count forState:UIControlStateNormal];
    [self.avator sd_setImageWithURL:[NSURL URLWithString:model.author.avatar_medium.url_list.firstObject] forState:UIControlStateNormal];
}


#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld 滚动文字",index);
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    
}

@end
