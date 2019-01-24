//
//  TTNavigationView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTNavigationView.h"
@interface TTNavigationView()
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)UIButton *shot;
@end
@implementation TTNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self TTSAddSubviews];
    }
    return self;
}

-(void)TTSAddSubviews{
    
    _segment = ({
        UISegmentedControl *iv = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"北京"]];
        iv.frame = CGRectMake(CGRectGetMidX(self.frame) - Number(40.0f), 20.0f, Number(80.0f), NumberHeight(30));
        iv.tintColor = [UIColor clearColor];
        iv.selectedSegmentIndex = 0;
        NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:16.0f],NSForegroundColorAttributeName : [UIColor TextGrayColor]};
        [iv setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
        NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:18.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
        [iv setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
        [iv addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:iv];
        iv;
    });
    
    _shot = ({
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        leftView.frame = CGRectMake(Number(10.0f), 20.0f, Number(50.0f), NumberHeight(30.0f));
        [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateNormal];
        [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateHighlighted];
        [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateSelected];
        [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateDisabled];
        [leftView setTitle:@"随拍" forState:UIControlStateNormal];
        [leftView setTitle:@"随拍" forState:UIControlStateHighlighted];
        [leftView setTitle:@"随拍" forState:UIControlStateSelected];
        [leftView setTitle:@"随拍" forState:UIControlStateDisabled];
        [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateNormal];
        [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateHighlighted];
        [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateSelected];
        [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateDisabled];
        [leftView.titleLabel setFont:[UIFont SYHelveticaFontOfSize:14.0f]];
        [leftView layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:3.0f];
        [leftView addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftView];
        leftView;
    });
    
    _rightView = ({
        TTRightItemView *iv = [[TTRightItemView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - Number(90.0f), 20.0f, Number(80.0f), NumberHeight(30.0f))];
        [self addSubview:iv];
        iv;
    });
}


-(void)segmentAction:(UISegmentedControl *)segment{
    if (self.clickBlock) {
        self.clickBlock(TTNavigationClickTypeSegment, segment.selectedSegmentIndex);
    }
}

-(void)Click:(UIButton *)sender{
    if (self.clickBlock) {
        self.clickBlock(TTNavigationClickTypeShot, sender.tag);
    }
}

@end
