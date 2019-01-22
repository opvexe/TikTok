//
//  TTBaseNavigationViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseNavigationViewController.h"
@interface TTBaseNavigationViewController()
<
UIGestureRecognizerDelegate,
UINavigationControllerDelegate
>
@end
@implementation TTBaseNavigationViewController
+ (void)load{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [navigationBarAppearance setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
    if (@available(iOS 11.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2.0, -0.4) forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -2) forBarMetrics:UIBarMetricsDefault];
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageWithColor:[UIColor blackColor]];
        
        textAttributes = @{
                           NSFontAttributeName :[UIFont systemFontOfSize:14.0],
                           NSForegroundColorAttributeName :[UIColor whiteColor],
                           };
        
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageWithColor:[UIColor blackColor]];
        textAttributes = @{
                           UITextAttributeFont : [UIFont systemFontOfSize:14.0]),
                           UITextAttributeTextColor :[UIColor whiteColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

@end
