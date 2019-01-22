//
//  TTSlideTabBar.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTSlideTabBar.h"
@interface TTSlideTabBar ()
@property (nonatomic, strong) UIView                           *slideLightView;
@property (nonatomic, strong) NSMutableArray<UILabel *>        *labels;
@property (nonatomic, strong) NSMutableArray<NSString *>       *titles;
@property (nonatomic, assign) NSInteger                        tabIndex;
@property (nonatomic, assign) CGFloat                          itemWidth;
@end
@implementation TTSlideTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        _labels = [NSMutableArray array];
        _titles = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if(_titles.count == 0) {
        return;
    }
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView removeFromSuperview];
    }];
    [_labels removeAllObjects];
    
    CGFloat itemWidth = _itemWidth = [UIScreen mainScreen].bounds.size.width/_titles.count;
    [_titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.textColor = [UIColor ColorWhiteAlpha60];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont SYPingFangSCSemiboldFontOfSize:16.0f];
        label.tag = idx;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
        [self.labels addObject:label];
        [self addSubview:label];
        label.frame = CGRectMake(idx*itemWidth, 0, itemWidth, self.bounds.size.height);
        if(idx != self.titles.count - 1) {
            UIView *spliteLine = [[UIView alloc] initWithFrame:CGRectMake((idx+1)*itemWidth - 0.25f, 12.5f, 0.5f, self.bounds.size.height - 25.0f)];
            spliteLine.backgroundColor = [UIColor ColorWhiteAlpha20];
            spliteLine.layer.zPosition = 10;
            [self addSubview:spliteLine];
        }
    }];
    _labels[_tabIndex].textColor = [UIColor whiteColor];
    
    _slideLightView = [[UIView alloc] init];
    _slideLightView.backgroundColor = [UIColor yellowColor];
    _slideLightView.frame = CGRectMake(_tabIndex * itemWidth + 15, self.bounds.size.height-2, itemWidth - 30, 2);
    [self addSubview:_slideLightView];
}

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex {
    [_titles removeAllObjects];
    [_titles addObjectsFromArray:titles];
    _tabIndex = tabIndex;
}

- (void)onTapAction:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    if(_delegate) {
        [UIView animateWithDuration:0.10
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.slideLightView.frame;
                             frame.origin.x = self.itemWidth * index + 15;
                             [self.slideLightView setFrame:frame];
                             [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
                                 label.textColor = index == idx ? [UIColor whiteColor] : [UIColor ColorWhiteAlpha60];
                             }];
                         } completion:^(BOOL finished) {
                             [self.delegate onTabTapAction:index];
                         }];
        
    }
}

@end
