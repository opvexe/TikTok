//
//  TTProfileCollectionViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTProfileCollectionViewCell.h"
#
@interface TTProfileCollectionViewCell()
@property(nonatomic,strong)FLAnimatedImageView *cover;
@property(nonatomic,strong)UIButton *likeNum;
@end
@implementation TTProfileCollectionViewCell

- (void)TTSinitConfingViews{
    
    _cover = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds =YES;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        iv;
    });
    
    _likeNum = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.contentView addSubview:iv];
        [iv setTitle:@"0" forState:UIControlStateNormal];
        [iv setTitle:@"0" forState:UIControlStateHighlighted];
        [iv setTitle:@"0" forState:UIControlStateSelected];
        [iv setTitle:@"0" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv setImage:[UIImage imageNamed:@"icon_home_likenum"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_home_likenum"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"icon_home_likenum"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_home_likenum"] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:10.0f]];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:3.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.bottom.mas_equalTo(-10.0f);
            make.width.mas_greaterThanOrEqualTo(60.0f);
            make.height.mas_equalTo(15.0f);
        }];
        iv;
    });
    
}

-(void)Click:(UIButton *)sender{
    NSLog(@"点赞");
}

-(void)InitDataWithModel:(TTAwemeModel *)model{
    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.video.origin_cover.url_list.firstObject] placeholderImage:[UIImage imageNamed:@"baixue"]];
    [self.likeNum setTitle:[NSString formatCount:[model.statistics.digg_count integerValue]] forState:UIControlStateNormal];
}

@end
