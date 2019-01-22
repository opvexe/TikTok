//
//  TTProfileCollectionViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTProfileCollectionViewCell.h"
@interface TTProfileCollectionViewCell()
@property(nonatomic,strong)UIImageView *cover;
@property(nonatomic,strong)UIButton *likeNum;
@end
@implementation TTProfileCollectionViewCell

- (void)TTSinitConfingViews{
    
    _cover = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = YES;
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
        [iv layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:5.0];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.bottom.mas_equalTo(-10.0f);
            make.width.mas_lessThanOrEqualTo(60.0f);
            make.height.mas_equalTo(15.0f);
        }];
        iv;
    });
    
}

-(void)Click:(UIButton *)sender{
    
}


-(void)InitDataWithModel:(TTBaseModel *)model{
    
}

@end
