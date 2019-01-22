//
//  AppDelegate+Category.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "AppDelegate+Category.h"
#import "TTTabBarControllerConfig.h"
@implementation AppDelegate (Category)

-(void)switchRootController{
    TTTabBarControllerConfig  *tabBarControllerConfig = [TTTabBarControllerConfig new];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
}

@end
