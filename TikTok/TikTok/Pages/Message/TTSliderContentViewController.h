//
//  TTSliderContentViewController.h
//  TikTok
//
//  Created by FaceBooks on 2019/2/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTSlideTabBarDelegate
@required
- (void)onTabTapAction:(NSInteger)index;

@end

@interface TTSliderContentViewController : UIViewController

@property (nonatomic,assign)NSInteger ScorllviewIndex;

@property (nonatomic,copy)UIColor *sliderBackColor;

@property (nonatomic,copy)UIColor *titleScrollviewBackColor;

@property (nonatomic,copy)UIColor *btnNormolColor;

@property (nonatomic,copy)UIColor *btnSlectColor;

-(instancetype)initWithCtrltitle:(NSArray *)viewCtrl;

@property(nonatomic,weak)id <TTSlideTabBarDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
