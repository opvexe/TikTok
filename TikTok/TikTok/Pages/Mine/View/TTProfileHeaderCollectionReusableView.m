//
//  TTProfileHeaderCollectionReusableView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTProfileHeaderCollectionReusableView.h"
#import "TTUserModel.h"
@interface TTProfileHeaderCollectionReusableView()
@property(nonatomic,strong)UIImageView *topBackgroundImageView;
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UIView *bottomBackgroundView;
@property(nonatomic,strong)UIButton *avatar;
@property(nonatomic,strong)UIButton *setting;
@property(nonatomic,strong)UIButton *adds;
@property(nonatomic,strong)UIButton *focus;
@property(nonatomic,strong)UIButton *sendMessage;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *tikTokID;
@property(nonatomic,strong)UILabel *brief;
@property(nonatomic,strong)UIButton *age;
@property(nonatomic,strong)UIButton *city;
@property(nonatomic,strong)UIButton *school;
@property(nonatomic,strong)UIButton *likeNum;
@property(nonatomic,strong)UIButton *forceNum;
@property(nonatomic,strong)UIButton *followedNum;
@property(nonatomic,strong)TTUserModel *model;
@end
@implementation TTProfileHeaderCollectionReusableView

- (void)TTSinitConfingViews{
    
    _topBackgroundImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0.0f);
            make.top.mas_equalTo(0.0f);
            make.height.mas_equalTo(50.0f+NavBarHeight);
        }];
        iv;
    });
    
    _bottomBackgroundView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor blackColor];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0.0f);
            make.bottom.mas_equalTo(0.0f);
            make.top.mas_equalTo(40.0f+NavBarHeight);
        }];
        iv;
    });
    
    _containerView = ({
        UIView *iv = [[UIView alloc]init];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        iv;
    });
    
    
    _avatar = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.containerView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"img_find_default"] forState:UIControlStateDisabled];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.layer.cornerRadius = 50.0f;
        iv.tag = TTUserHeaderDidClickTypeAvatar;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Number(15.0f));
            make.top.mas_equalTo(30.0f+NavBarHeight);
            make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
        }];
        iv;
    });
    
    _setting = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.containerView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_whitemore"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_whitemore"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_whitemore"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_whitemore"] forState:UIControlStateDisabled];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.tag = TTUserHeaderDidClickTypeSetting;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-Number(15.0f));
            make.centerY.mas_equalTo(self.avatar);
            make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        }];
        iv;
    });
    
    _adds = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.containerView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_addfriend"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_addfriend"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_addfriend"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_titlebar_addfriend"] forState:UIControlStateDisabled];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.tag = TTUserHeaderDidClickTypeAddsFriends;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.setting.mas_left).mas_offset(-5.0f);
            make.centerY.mas_equalTo(self.avatar);
            make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        }];
        iv;
    });
    
    _sendMessage = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.containerView addSubview:iv];
        [iv setTitle:@"发消息" forState:UIControlStateNormal];
        [iv setTitle:@"发消息" forState:UIControlStateHighlighted];
        [iv setTitle:@"发消息" forState:UIControlStateSelected];
        [iv setTitle:@"发消息" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:14.0f]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.tag = TTUserHeaderDidClickTypeSendMessage;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.adds.mas_left).mas_offset(-5.0f);
            make.centerY.mas_equalTo(self.avatar);
            make.size.mas_equalTo(CGSizeMake(Number(80.0f), 40.0f));
        }];
        iv;
    });
    
    _focus = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self.containerView addSubview:iv];
        [iv setTitle:@"关注" forState:UIControlStateNormal];
        [iv setTitle:@"关注" forState:UIControlStateHighlighted];
        [iv setTitle:@"关注" forState:UIControlStateSelected];
        [iv setTitle:@"关注" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:14.0f]];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.hidden = YES;
        iv.tag = TTUserHeaderDidClickTypeFocusAction;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-Number(15.0f));
            make.centerY.mas_equalTo(self.avatar);
            make.size.mas_equalTo(CGSizeMake(Number(80.0f), 40.0f));
        }];
        iv;
    });
    
    _nickName = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.containerView addSubview:iv];
        iv.text = @"小蘑菇头";
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:20.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Number(15.0f));
            make.width.mas_equalTo(Number(180.0f));
            make.height.mas_equalTo(20.0f);
            make.top.mas_equalTo(self.avatar.mas_bottom).mas_offset(NumberHeight(15.0f));
        }];
        iv;
    });
    
    _tikTokID = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.containerView addSubview:iv];
        iv.text = @"抖音号:173065975";
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor whiteColor];
        iv.font = [UIFont SYHelveticaFontOfSize:14.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickName);
            make.width.mas_equalTo(Number(180.0f));
            make.height.mas_equalTo(20.0f);
            make.top.mas_equalTo(self.nickName.mas_bottom).mas_offset(NumberHeight(5.0f));
        }];
        iv;
    });
    
    UIView *splitView = [[UIView alloc] init];
    splitView.backgroundColor = [UIColor ColorWhiteAlpha20];
    [self.containerView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tikTokID.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0.0f);
        make.height.mas_equalTo(0.5);
    }];
    
    
    _brief = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.containerView addSubview:iv];
        iv.text = @"底气来自实力";
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor = [UIColor ColorWhiteAlpha60];
        iv.font = [UIFont SYHelveticaFontOfSize:14.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickName);
            make.width.mas_equalTo(Number(180.0f));
            make.height.mas_equalTo(20.0f);
            make.top.mas_equalTo(splitView.mas_bottom).mas_offset(10.0f);
        }];
        iv;
    });
    
    
    _age = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"iconUserProfileGirl"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"iconUserProfileGirl"] forState:UIControlStateHighlighted];
        [iv setImage:[UIImage imageNamed:@"iconUserProfileGirl"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"iconUserProfileGirl"] forState:UIControlStateDisabled];
        [iv setTitle:@"8岁" forState:UIControlStateNormal];
        [iv setTitle:@"8岁" forState:UIControlStateHighlighted];
        [iv setTitle:@"8岁" forState:UIControlStateSelected];
        [iv setTitle:@"8岁" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.tag = TTUserHeaderDidClickTypeAboutMe;
        [iv layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:3.0f];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_greaterThanOrEqualTo(40.0f);
            make.left.mas_equalTo(self.nickName);
            make.top.mas_equalTo(self.brief.mas_bottom).mas_offset(10.0f);
        }];
        iv;
    });
    
    _city = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setTitle:@"北京.西城" forState:UIControlStateNormal];
        [iv setTitle:@"北京.西城" forState:UIControlStateHighlighted];
        [iv setTitle:@"北京.西城" forState:UIControlStateSelected];
        [iv setTitle:@"北京.西城" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.layer.cornerRadius = 2;
        iv.tag = TTUserHeaderDidClickTypeAboutMe;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_greaterThanOrEqualTo(40.0f);
            make.left.mas_equalTo(self.age.mas_right).mas_offset(5.0f);
            make.top.mas_equalTo(self.brief.mas_bottom).mas_offset(10.0f);
        }];
        iv;
    });
    
    _school = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setTitle:@"+ 增加学校标签" forState:UIControlStateNormal];
        [iv setTitle:@"+ 增加学校标签" forState:UIControlStateHighlighted];
        [iv setTitle:@"+ 增加学校标签" forState:UIControlStateSelected];
        [iv setTitle:@"+ 增加学校标签" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor ColorWhiteAlpha60] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYHelveticaFontOfSize:12.0f]];
        iv.layer.backgroundColor = [UIColor ColorWhiteAlpha20].CGColor;
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        iv.tag = TTUserHeaderDidClickTypeAboutMe;
        iv.layer.cornerRadius = 2;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_greaterThanOrEqualTo(100.0f);
            make.left.mas_equalTo(self.city.mas_right).mas_offset(5.0f);
            make.top.mas_equalTo(self.brief.mas_bottom).mas_offset(10.0f);
        }];
        iv;
    });
    
    
    _likeNum = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setTitle:@"100 获赞" forState:UIControlStateNormal];
        [iv setTitle:@"100 获赞" forState:UIControlStateHighlighted];
        [iv setTitle:@"100 获赞" forState:UIControlStateSelected];
        [iv setTitle:@"100 获赞" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCSemiboldFontOfSize:16.0f]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        iv.tag = TTUserHeaderDidClickTypeLikes;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.left.mas_equalTo(self.nickName);
            make.top.mas_equalTo(self.age.mas_bottom).mas_offset(15.0f);
        }];
        iv;
    });
    
    _forceNum = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setTitle:@"9 关注" forState:UIControlStateNormal];
        [iv setTitle:@"9 关注" forState:UIControlStateHighlighted];
        [iv setTitle:@"9 关注" forState:UIControlStateSelected];
        [iv setTitle:@"9 关注" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCSemiboldFontOfSize:16.0f]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
         iv.tag = TTUserHeaderDidClickTypeFocuse;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.left.mas_equalTo(self.likeNum.mas_right).mas_offset(10.0f);
            make.top.mas_equalTo(self.likeNum);
        }];
        iv;
    });
    
    _followedNum = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:iv];
        [iv setTitle:@"9 粉丝" forState:UIControlStateNormal];
        [iv setTitle:@"9 粉丝" forState:UIControlStateHighlighted];
        [iv setTitle:@"9 粉丝" forState:UIControlStateSelected];
        [iv setTitle:@"9 粉丝" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCSemiboldFontOfSize:16.0f]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        iv.tag = TTUserHeaderDidClickTypeFollowed;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.left.mas_equalTo(self.forceNum.mas_right).mas_offset(10.0f);
            make.top.mas_equalTo(self.likeNum);
        }];
        iv;
    });
    
    _slideTabBar = ({
        TTSlideTabBar *iv = [[TTSlideTabBar alloc]initWithFrame:CGRectZero];
        [self.containerView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.right.bottom.equalTo(self);
        }];
        iv;
    });
    [_slideTabBar setLabels:@[@"作品 9",@"动态 9",@"喜欢 9"] tabIndex:0];
}

-(void)Click:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate clickUserWithType:sender.tag withUser:self.model];
    }
}

- (void)InitDataWithModel:(TTUserModel *)model{
    _model = model;
    [self.topBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pb3.pstatp.com/obj/dbc1001cd29ccc479f7f"] placeholderImage:[UIImage imageNamed:@"baixue"]];
    self.nickName.text = convertToString(model.nickname);
    self.tikTokID.text = [NSString stringWithFormat:@"抖音: %@",convertToString(model.short_id)];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar_medium.url_list.firstObject] forState:UIControlStateNormal];
    self.brief.text = convertToString(model.signature);
    [self.age setTitle:[NSString stringWithFormat:@"0岁"] forState:UIControlStateNormal];
    [self.city setTitle:@"北京" forState:UIControlStateNormal];
    [self.likeNum setTitle:[NSString stringWithFormat:@"%@ 获赞",convertToString(model.total_favorited)] forState:UIControlStateNormal];
    [self.forceNum setTitle:[NSString stringWithFormat:@"%@ 关注",convertToString(model.favoriting_count)] forState:UIControlStateNormal];
    [self.followedNum setTitle:[NSString stringWithFormat:@"%@ 粉丝",convertToString(model.favoriting_count)] forState:UIControlStateNormal];
    [self.slideTabBar setLabels:@[[NSString stringWithFormat:@"作品 %@",convertToString(model.aweme_count)],[NSString stringWithFormat:@"动态 %@",convertToString(model.favoriting_count)],[NSString stringWithFormat:@"喜欢 %@",convertToString(model.favoriting_count)]] tabIndex:0];
}

- (void)overScrollAction:(CGFloat) offsetY {
    CGFloat scaleRatio = fabs(offsetY)/370.0f;
    CGFloat overScaleHeight = (370.0f * scaleRatio)/2;
    self.topBackgroundImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(scaleRatio + 1.0f, scaleRatio + 1.0f), CGAffineTransformMakeTranslation(0, -overScaleHeight));
}

- (void)scrollToTopAction:(CGFloat) offsetY {
    CGFloat alphaRatio = offsetY/(370.0f - 44 - StatusBarHeight - TT_TabbarHeight);
    self.containerView.alpha = 1.0f - alphaRatio;
}

@end
