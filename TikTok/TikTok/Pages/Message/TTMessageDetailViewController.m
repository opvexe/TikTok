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
