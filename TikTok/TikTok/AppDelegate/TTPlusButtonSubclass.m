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


+ (id)plusButton {
    UIImage *buttonImage = [UIImage imageNamed:@"btn_home_add"];
    UIImage *highlightImage = [UIImage imageNamed:@"btn_home_add"];
    TTPlusButtonSubclass* button = [TTPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
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
    return 0.0f;
}

@end
