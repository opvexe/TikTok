//
//  TTShareShowView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/25.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTShareShowView.h"
#import "TTAnimationButton.h"
@interface TTShareShowView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *container;
@property(nonatomic,copy)void(^compteleBlock)(NSInteger selectIndexPath);
@property(nonatomic,strong)UILabel *share;
@property(nonatomic,strong)UIButton *cancel;
@end
@implementation TTShareShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *topIconsName = @[
                                  @"icon_profile_share_wxTimeline",
                                  @"icon_profile_share_wechat",
                                  @"icon_profile_share_qqZone",
                                  @"icon_profile_share_qq",
                                  @"icon_profile_share_weibo",
                                  @"iconHomeAllshareXitong"
                                  ];
        NSArray *topTexts = @[
                              @"朋友圈",
                              @"微信好友",
                              @"QQ空间",
                              @"QQ好友",
                              @"微博",
                              @"更多分享"
                              ];
        NSArray *bottomIconsName = @[
                                     @"icon_home_allshare_report",
                                     @"icon_home_allshare_download",
                                     @"icon_home_allshare_copylink",
                                     @"icon_home_all_share_dislike"
                                     ];
        NSArray *bottomTexts = @[
                                 @"举报",
                                 @"保存至相册",
                                 @"复制链接",
                                 @"不感兴趣"
                                 ];
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        ///MARK:添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        ///MARK:背景试图
        _container = ({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = [UIColor blackColor];
            iv.frame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,254.0f);
            [self addSubview:iv];
            iv;
        });
        
        ///MARK:贝尔函数绘制左右圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 254.0f) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15.0f, 15.0f)];
        CAShapeLayer *layer =[[CAShapeLayer alloc] init];
        [layer setPath:path.CGPath];
        self.container.layer.mask = layer;
        
        
        _share = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor = [UIColor whiteColor];
            iv.text = @"分享到";
            iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:14.0f];
            iv.textAlignment = NSTextAlignmentCenter;
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.container);
                make.top.mas_equalTo(5.0f);
                make.width.mas_lessThanOrEqualTo(60.0f);
                make.height.mas_equalTo(20.0f);
            }];
            iv;
        });
        
        CGFloat itemWidth = 68.0f;
        
        UIScrollView *topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 30.0f, [UIScreen mainScreen].bounds.size.width, 90.0f)];
        topScrollView.contentSize = CGSizeMake(itemWidth*topIconsName.count, 80.0f);
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [self.container addSubview:topScrollView];
        UIButton *lastButton = nil;
        for (NSInteger i =0; i<topIconsName.count; i++) {
            TTAnimationButton *iv = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
            [topScrollView addSubview:iv];
            [iv setImage:[UIImage imageNamed:topIconsName[i]] forState:UIControlStateNormal];
            [iv setImage:[UIImage imageNamed:topIconsName[i]] forState:UIControlStateSelected];
            [iv setImage:[UIImage imageNamed:topIconsName[i]] forState:UIControlStateHighlighted];
            [iv setTitle:topTexts[i] forState:UIControlStateNormal];
            [iv setTitle:topTexts[i] forState:UIControlStateSelected];
            [iv setTitle:topTexts[i] forState:UIControlStateHighlighted];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
            [iv.titleLabel setTextAlignment:NSTextAlignmentCenter];
            iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            iv.tag = 100+i;
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:5.0f];
            [iv showItemsAnimate:0.03*i];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(80.0f);
                make.width.mas_equalTo(60.0f);
                make.centerY.mas_equalTo(topScrollView);
                if (lastButton) {
                    make.left.mas_equalTo(lastButton.mas_right).mas_offset(10.0f);
                }else{
                    make.left.mas_equalTo(topScrollView).mas_offset(10.0f);
                }
            }];
            lastButton = iv;
        }
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(topScrollView.frame), [UIScreen mainScreen].bounds.size.width, 90.0f)];
        bottomScrollView.contentSize = CGSizeMake(itemWidth*bottomIconsName.count, 90.0f);
        bottomScrollView.showsHorizontalScrollIndicator = NO;
        bottomScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [self.container addSubview:bottomScrollView];
        UIButton *lastBottomButton = nil;
        for (NSInteger i =0; i<bottomIconsName.count; i++) {
            TTAnimationButton *iv = [TTAnimationButton buttonWithType:UIButtonTypeCustom];
            [bottomScrollView addSubview:iv];
            [iv setImage:[UIImage imageNamed:bottomIconsName[i]] forState:UIControlStateNormal];
            [iv setImage:[UIImage imageNamed:bottomIconsName[i]] forState:UIControlStateSelected];
            [iv setImage:[UIImage imageNamed:bottomIconsName[i]] forState:UIControlStateHighlighted];
            [iv setTitle:bottomTexts[i] forState:UIControlStateNormal];
            [iv setTitle:bottomTexts[i] forState:UIControlStateSelected];
            [iv setTitle:bottomTexts[i] forState:UIControlStateHighlighted];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            [iv setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
            [iv.titleLabel setTextAlignment:NSTextAlignmentCenter];
            iv.titleLabel.font = [UIFont SYHelveticaFontOfSize:12.0f];
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            iv.tag = 100+topIconsName.count + i;
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv layoutTextWithImageButtonStyle:LayoutTextUnderImageButton withSpace:5.0f];
            [iv showItemsAnimate:0.03*i];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(80.0f);
                make.width.mas_equalTo(60.0f);
                make.centerY.mas_equalTo(bottomScrollView);
                if (lastBottomButton) {
                    make.left.mas_equalTo(lastBottomButton.mas_right).mas_offset(10.0f);
                }else{
                    make.left.mas_equalTo(bottomScrollView).mas_offset(10.0f);
                }
            }];
            lastBottomButton = iv;
        }
        
        _cancel = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setTitle:@"取消" forState:UIControlStateNormal];
            [iv setTitle:@"取消" forState:UIControlStateSelected];
            [iv setTitle:@"取消" forState:UIControlStateHighlighted];
            [iv setTitle:@"取消" forState:UIControlStateDisabled];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            iv.titleLabel.textAlignment = NSTextAlignmentCenter;
            iv.backgroundColor = [UIColor ColorGrayLight];
            iv.clipsToBounds = YES;
            iv.showsTouchWhenHighlighted =NO;
            [iv addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0.0f);
                make.bottom.mas_equalTo(-TT_TabbarSafeBottomMargin);
                make.height.mas_equalTo(44.0f);
            }];
            iv;
        });
        
    }
    return self;
}

-(void)Click:(UIButton *)sender{
    
    if (self.compteleBlock) {
        self.compteleBlock(sender.tag);
    }
}

+(TTShareShowView *)creatViewComplelte:(void(^)(NSInteger selectIndexPath))complete{
    TTShareShowView *share  = [[TTShareShowView alloc]init];
    [share showComplete:complete];
    [share show];
    return share;
}

-(void)showComplete:(void(^)(NSInteger selectIndexPath))complete{
    self.compteleBlock = complete;
}

-(void)show{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y - frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        [self layoutIfNeeded];
    }];
}

-(void)dismiss{
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y + frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


-(void)Tap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_cancel];
    if([_cancel.layer containsPoint:point]) {
        [self dismiss];
    }
}

@end
