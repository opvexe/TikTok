//
//  TTInteractiveTransition.h
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTHomeViewController.h"
NS_ASSUME_NONNULL_BEGIN

///MARK: 创建交互手势
@interface TTInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

-(void)wireToViewController:(TTBaseViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
