//
//  TTCommentShowView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTCommentShowView.h"
#import "TTBaseTableViewCell.h"
@interface TTCommentTableViewCell : TTBaseTableViewCell

@end
@implementation TTCommentTableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"TTCommentTableViewCell";
    TTCommentTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TTCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)TTSinitConfingViews{
    
    
}

@end

@interface TTCommentShowView()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *closed;
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *comments;
@property(nonatomic,strong)UIView *textView;
@end
@implementation TTCommentShowView

- (instancetype)initWithCommentId:(NSString *)commentId{
    self = [super init];
    if (self) {
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
            iv.frame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*3/4);
            [self addSubview:iv];
            iv;
        });
        
        ///MARK:贝尔函数绘制左右圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3/4) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15.0f, 15.0f)];
        CAShapeLayer *layer =[[CAShapeLayer alloc] init];
        [layer setPath:path.CGPath];
        self.container.layer.mask = layer;
        
        ///MARK:
        _label = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor = [UIColor whiteColor];
            iv.text = @"0条评论";
            iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:13.0f];
            iv.textAlignment = NSTextAlignmentCenter;
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.container);
                make.top.mas_equalTo(10.0f);
                make.width.mas_lessThanOrEqualTo(180.0f);
                make.height.mas_equalTo(20.0f);
            }];
            iv;
        });
        
        _closed = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setImage:[UIImage imageNamed:@"icon_closetopic"] forState:UIControlStateNormal];
            [iv setImage:[UIImage imageNamed:@"icon_closetopic"] forState:UIControlStateHighlighted];
            iv.clipsToBounds = YES;
            iv.showsTouchWhenHighlighted =NO;
            [iv addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            [self.container addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20.0f);
                make.centerY.mas_equalTo(self.label);
                make.size.mas_equalTo(CGSizeMake(12.0f, 12.0f));
            }];
            iv;
        });
        
        _tableListView = ({
            UITableView *iv = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3/4 - 40.0f - 50.0f - TT_TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
            [self.container addSubview:iv];
            iv.separatorStyle = UITableViewCellSeparatorStyleNone;
            iv.backgroundColor = [UIColor clearColor];
            iv.dataSource = self;
            iv.delegate = self;
            iv;
        });
    }
    return self;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<0) {
        self.frame = CGRectMake(0, -offsetY, self.frame.size.width, self.frame.size.height);
    }
    
    if (scrollView.dragging&&offsetY<-40.0f) {
        [self dismiss];
    }
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:NSStringFromClass([TTCommentTableViewCell class])]) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCommentTableViewCell *cell  = [TTCommentTableViewCell CellWithTableView:tableView];
    return cell;
}


#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark  --- 消失
-(void)dismiss{
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y + frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(void)show{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{  ///快进慢出
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y - frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)Tap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_closed];
    if([_closed.layer containsPoint:point]) {
        [self dismiss];
    }
}

@end
