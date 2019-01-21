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
    UIImage *normalButtonImage = [UIImage imageNamed:@"post_highlight"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"post_highlight"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    button.frame = CGRectMake(0.0, 0.0, 55, 59);
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    TTPublishViewController *pushVC = [[TTPublishViewController alloc]init];
    pushVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    TTBaseNavigationViewController *pushNavgationController = [[TTBaseNavigationViewController alloc] initWithRootViewController:pushVC];
    [viewController presentViewController:pushNavgationController animated:YES completion:nil];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}

@end
