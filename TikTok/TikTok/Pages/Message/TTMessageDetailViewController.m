//
//  TTMessageDetailViewController.m
//  TikTok
//
//  Created by FaceBooks on 2019/2/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMessageDetailViewController.h"
#import "TTPopShowView.h"
@interface TTMessageDetailViewController ()

@end

@implementation TTMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
    [iv setTitle:@"按钮" forState:UIControlStateNormal];
    iv.frame = CGRectMake(100, 100, 100, 100);
    iv.backgroundColor = [UIColor redColor];
    [self.view addSubview:iv];
    [iv addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)Click{
//    TTPopShowView *popShow = [[TTPopShowView alloc]initWithComment:@"解约后，蒋停用缴费代扣功能，\n请您留意账单信息，及时缴费！"];
    
    TTPopShowView *popShow = [[TTPopShowView alloc]initWithComment:@"该缴费编号已开通账单提醒，\n为避免重复缴费，请先关闭账单\n提醒功能后再签约代扣服务。"];
    
    [popShow show];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
