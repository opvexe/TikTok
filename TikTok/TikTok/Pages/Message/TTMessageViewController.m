//
//  TTMessageViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMessageViewController.h"
#import "TTMessageDetailViewController.h"
#import "TTPopShowView.h"
#import "TTSliderContentViewController.h"
#import "TTMessageHoldViewController.h"
@interface TTMessageViewController ()<TTSlideTabBarDelegate>

@end

@implementation TTMessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"消息" ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    NSArray *titleArr = @[@"缴费代扣",@"账单提醒"];
    NSMutableArray *ctrlArr = [NSMutableArray array];
    [titleArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTMessageDetailViewController *controller = [TTMessageDetailViewController new];
        controller.title = obj;
        [ctrlArr addObject:controller];
    }];
    
    TTSliderContentViewController *sliderController = [[TTSliderContentViewController alloc] initWithCtrltitle:ctrlArr];
    sliderController.view.backgroundColor = [UIColor whiteColor];
    sliderController.titleScrollviewBackColor = [UIColor whiteColor];
    sliderController.sliderBackColor= [UIColor purpleColor]; //滑块颜色
    sliderController.btnNormolColor = [UIColor blackColor]; //正常时的颜色
    sliderController.btnSlectColor =  [UIColor purpleColor]; //选中时的颜色
    sliderController.delegate =  self;
    
    [self addChildViewController:sliderController];
    sliderController.view.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view addSubview:sliderController.view];
    
}


- (void)onTabTapAction:(NSInteger)index{
    
    NSLog(@"选中:==%ld",index);
}

-(void)Click{
    TTPopShowView *popShow = [[TTPopShowView alloc]initWithComment:@"解约后，蒋停用缴费代扣功能，\n请您留意账单信息，及时缴费！"];
    
    [popShow show];
    
}

@end
