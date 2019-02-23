//
//  TTPopShowView.m
//  TikTok
//
//  Created by FaceBooks on 2019/2/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTPopShowView.h"
#import "TTTools.h"
@interface TTPopShowView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *closed;
@property(nonatomic,strong)UIButton *cancel;
@property(nonatomic,strong)UIView *spliteLine;
@end

@implementation TTPopShowView

- (instancetype)initWithComment:(NSString *)comment{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.frame = [UIScreen mainScreen].bounds;
        
        ///MARK:添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        CGFloat height = [TTTools getHeightContain:comment font:[UIFont systemFontOfSize:18.0] Width:[UIScreen mainScreen].bounds.size.width - 120.0f] +130.0f;
        
        
        ///MARK:背景试图
        _container = ({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = [UIColor whiteColor];
            iv.frame = CGRectMake(40.0f, CGRectGetMidY(self.frame) - height/2, [UIScreen mainScreen].bounds.size.width - 80.0f,height);
            [self addSubview:iv];
            iv;
        });
        
        ///MARK:贝尔函数绘制左右圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width-80.0f,height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.0f, 5.0f)];
        CAShapeLayer *layer =[[CAShapeLayer alloc] init];
        [layer setPath:path.CGPath];
        self.container.layer.mask = layer;
        
        _title = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor = [UIColor blackColor];
            iv.text = @"风险提示";
            iv.font = [UIFont boldSystemFontOfSize:18.0f];
            iv.textAlignment = NSTextAlignmentCenter;
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.container);
                make.top.mas_equalTo(20.0f);
                make.width.mas_lessThanOrEqualTo(180.0f);
                make.height.mas_equalTo(20.0f);
            }];
            iv;
        });
        
        _label = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor = [UIColor lightGrayColor];
            iv.text = comment;
            iv.font = [UIFont systemFontOfSize:18.0];
            iv.textAlignment = NSTextAlignmentCenter;
            iv.numberOfLines = 0;
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.title.mas_bottom).mas_offset(20.0f);
                make.left.mas_equalTo(20.0f);
                make.right.mas_equalTo(-20.0f);
            }];
            iv;
        });
        
        
        _spliteLine =({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = [UIColor lightGrayColor];
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0.0f);
                make.height.mas_equalTo(0.5f);
                make.top.mas_equalTo(self.label.mas_bottom).mas_offset(19.0f);
            }];
            iv;
        });
        
        _closed = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setTitle:@"确定解约" forState:UIControlStateNormal];
            [iv setTitle:@"确定解约" forState:UIControlStateHighlighted];
            iv.titleLabel.textAlignment = NSTextAlignmentCenter;
            [iv setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            [iv setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:iv];
            iv.tag = TTPopShowTypeSure;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0.0f);
                make.top.mas_equalTo(self.label.mas_bottom).mas_offset(20.0f);
                make.height.mas_equalTo(50.0f);
                make.width.mas_equalTo(self.container).multipliedBy(0.5);
            }];
            iv;
        });
        
        UIView *spliteLine = [[UIView alloc]init];
        spliteLine.backgroundColor = [UIColor lightGrayColor];
        spliteLine.layer.zPosition = 10;
        [self.container addSubview:spliteLine];
        [spliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.closed.mas_right);
            make.width.mas_equalTo(0.5f);
            make.centerY.mas_equalTo(self.closed);
            make.height.mas_equalTo(20.0f);
        }];
        
        _cancel = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setTitle:@"取消" forState:UIControlStateNormal];
            [iv setTitle:@"取消" forState:UIControlStateHighlighted];
            iv.titleLabel.textAlignment = NSTextAlignmentCenter;
            [iv setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            [iv setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:iv];
            iv.tag = TTPopShowTypeCancle;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.closed.mas_right);
                make.top.mas_equalTo(self.closed.mas_top);
                make.height.mas_equalTo(50.0f);
                make.width.mas_equalTo(self.container).multipliedBy(0.5);
            }];
            iv;
        });
        
    }
    return self;
}


-(void)Click:(UIButton *)sender{
    
    
}
#pragma mark  --- 消失
-(void)dismiss{
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.container.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(void)show{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    self.container.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    self.container.alpha = 1.0f;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{  ///快进慢出
        self.container.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)Tap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
}

@end
