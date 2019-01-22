//
//  TTSlideTabBar.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TTSlideTabBarDelegate
@required
- (void)onTabTapAction:(NSInteger)index;

@end
@interface TTSlideTabBar : UIView

@property (nonatomic, weak) id <TTSlideTabBarDelegate> delegate;

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
