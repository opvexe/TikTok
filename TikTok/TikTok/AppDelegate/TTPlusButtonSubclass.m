//
//  TTPlusButtonSubclass.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTPlusButtonSubclass.h"
#import <CYLTabBarController.h>
#import "TTBaseNavigationViewController.h"
#import "TTPublishViewController.h"
@implementation TTPlusButtonSubclass

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    // 控件大小,间距大小
//    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
//    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
//    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
//
//    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
//    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
//    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
//
//    // imageView 和 titleLabel 中心的 Y 值
//    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
//    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
//
//    //imageView position 位置
//    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
//    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
//
//    //title position 位置
//    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
//    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
//}

+ (id)plusButton {
    TTPlusButtonSubclass *button = [[TTPlusButtonSubclass alloc] init];
    [button setImage:[UIImage imageNamed:@"btn_home_add"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn_home_add"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"btn_home_add"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"btn_home_add"] forState:UIControlStateDisabled];
    button.frame = CGRectMake(0.0, 0.0, 44.0f, 34.0f);
    [button addTarget:button action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)Click:(UIButton *)sender{
    [UIView animateWithDuration:0.20 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformIdentity;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CYLTabBarController *tabBarController = [self cyl_tabBarController];
            UIViewController *viewController = tabBarController.selectedViewController;
            TTPublishViewController *pushVC = [[TTPublishViewController alloc]init];
            pushVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            TTBaseNavigationViewController *pushNavgationController = [[TTBaseNavigationViewController alloc] initWithRootViewController:pushVC];
            [viewController presentViewController:pushNavgationController animated:YES completion:nil];
        });
    }];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.5;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  0.0f;
}

@end
