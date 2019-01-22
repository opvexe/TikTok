//
//  TTRightItemView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTRightItemView.h"

typedef void(^CompleteBlock)(TTRightItemViewClickType type);
@interface TTRightItemView ()
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIButton *liveButton;
@property(nonatomic,copy)CompleteBlock comlpete;
@end

@implementation TTRightItemView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self TTSAddSubviews];
    }
    return self;
}

-(void)TTSAddSubviews{
    
    _searchButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icHomeSearch"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icHomeSearch"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icHomeSearch"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag =TTRightItemViewClickTypeSearch;
        iv;
    });
    
    _liveButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        iv.showsTouchWhenHighlighted =NO;
        iv.clipsToBounds = YES;
        [self addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"icon_live_small"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"icon_live_small"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"icon_live_small"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag =TTRightItemViewClickTypeLiving;
        iv;
    });
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(Number(36.0f), Number(36.0f)));
        make.centerY.mas_equalTo(self);
    }];
    [self.liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.searchButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(Number(38.0f), Number(20.0f)));
        make.centerY.mas_equalTo(self);
    }];
}

-(void)Click:(UIButton *)sender{
    if (self.comlpete) {
        self.comlpete(sender.tag);
    }
}

-(void)compelet:(void(^)(TTRightItemViewClickType type))completed{
    self.comlpete = completed;
}

@end
