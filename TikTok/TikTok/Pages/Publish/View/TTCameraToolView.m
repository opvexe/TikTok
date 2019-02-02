//
//  TTCameraView.m
//  TikTok
//
//  Created by FaceBook on 2019/2/2.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTCameraToolView.h"
@interface TTCameraToolView()
@property(nonatomic,strong)UIButton *close;
@property(nonatomic,strong)UIButton *music;
@property(nonatomic,strong)UIButton *rotate;
@property(nonatomic,strong)UIButton *speed;
@property(nonatomic,strong)UIButton *beautify;
@property(nonatomic,strong)UIButton *countDown;///倒计时
@property(nonatomic,strong)UIButton *stage;///道具
@property(nonatomic,strong)UIButton *upload;///上传
@end
@implementation TTCameraToolView

-(void)TTSAddSubviews{
    
    _close = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"iconStorywhiteClose"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"iconStorywhiteClose"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = TTCameraTypeClose;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Number(15.0f));
            make.top.mas_equalTo(NumberHeight(40.0f));
            make.size.mas_equalTo(CGSizeMake(27.0f, 27.0f));
        }];
        iv;
    });
    
    _music = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"music_note_1"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"music_note_1"] forState:UIControlStateSelected];
        [iv setTitle:@"选择音乐" forState:UIControlStateNormal];
        [iv setTitle:@"选择音乐" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:14.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.tag =TTCameraTypeMusic;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:5.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.close);
            make.width.mas_lessThanOrEqualTo(Number(80.0f));
            make.height.mas_equalTo(NumberHeight(20.0f));
        }];
        iv;
    });
    
    _rotate = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_reversal_front"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_reversal_front"] forState:UIControlStateSelected];
        [iv setTitle:@"旋转" forState:UIControlStateNormal];
        [iv setTitle:@"旋转" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:3.0f];
        iv.tag =TTCameraTypePostion;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.close);
            make.right.mas_equalTo(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        }];
        iv;
    });
    
    _speed = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"iconSpecial2"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"iconSpecial2"] forState:UIControlStateSelected];
        [iv setTitle:@"快慢速" forState:UIControlStateNormal];
        [iv setTitle:@"快慢速" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:3.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.rotate.mas_bottom).mas_offset(Number(20.0f));
            make.right.mas_equalTo(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        }];
        iv;
    });
    
    
    _beautify = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"iconBeautyOff2"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"iconBeautyOff2"] forState:UIControlStateSelected];
        [iv setTitle:@"美化" forState:UIControlStateNormal];
        [iv setTitle:@"美化" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:3.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.speed.mas_bottom).mas_offset(Number(20.0f));
            make.right.mas_equalTo(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        }];
        iv;
    });
    
    _countDown = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"iconBeautyOff2"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"iconBeautyOff2"] forState:UIControlStateSelected];
        [iv setTitle:@"倒计时" forState:UIControlStateNormal];
        [iv setTitle:@"倒计时" forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:3.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.beautify.mas_bottom).mas_offset(Number(20.0f));
            make.right.mas_equalTo(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        }];
        iv;
    });
    
}

-(void)Click:(UIButton *)sender{
    if (self.cameraBlock) {
        self.cameraBlock(sender.tag);
    }
}

@end
