//
//  TTTabBarControllerConfig.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTTabBarControllerConfig.h"
#import "TTBaseNavigationViewController.h"
#import "TTHomeViewController.h"
#import "TTAttentionViewController.h"
#import "TTMessageViewController.h"
#import "TTMineViewController.h"
@interface TTTabBarControllerConfig ()
@property (nonatomic, strong) CYLTabBarController *tabBarController;
@end
@implementation TTTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        TTRootViewController *tabBarController = [TTRootViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                               imageInsets:imageInsets
                                                                                   titlePositionAdjustment:titlePositionAdjustment];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}
- (NSArray *)viewControllers {
    TTHomeViewController *homeViewController = [[TTHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[TTBaseNavigationViewController alloc]
                                                  initWithRootViewController:homeViewController];
    
    TTAttentionViewController *attentionViewController = [[TTAttentionViewController alloc] init];
    UIViewController *attentionNavigationController = [[TTBaseNavigationViewController alloc]
                                                       initWithRootViewController:attentionViewController];
    
    TTMessageViewController *messageViewController = [[TTMessageViewController alloc] init];
    UIViewController *messageNavigationController = [[TTBaseNavigationViewController alloc]
                                                     initWithRootViewController:messageViewController];
    TTMineViewController *mineViewController = [[TTMineViewController alloc] init];
    UIViewController *mineNavigationController = [[TTBaseNavigationViewController alloc]
                                                  initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 attentionNavigationController,
                                 messageNavigationController,
                                 mineNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *homeTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, -14.0f)]
                                                };
    
    NSDictionary *attentionTabBarItemsAttributes = @{
                                                     CYLTabBarItemTitle : @"关注",
                                                     CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, -14.0f)]
                                                     };
    
    NSDictionary *messageTabBarItemsAttributes = @{
                                                   CYLTabBarItemTitle : @"消息",
                                                   CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, -14.0f)]
                                                   };
    NSDictionary *mineTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"我",
                                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, -14.0f)]
                                                };
    
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       attentionTabBarItemsAttributes,
                                       messageTabBarItemsAttributes,
                                       mineTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    tabBarController.tabBarHeight = TT_TabbarHeight;
    
    ///普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15.0f];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}


@end
