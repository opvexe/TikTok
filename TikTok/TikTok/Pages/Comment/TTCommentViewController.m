//
//  TTCommentViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTCommentViewController.h"
@interface TTCommentViewController()
@property(nonatomic,strong)UIView *bgView;
@end
@implementation TTCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _bgView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor redColor];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0.0f);
            make.bottom.mas_equalTo(0.0f);
            make.centerY.mas_equalTo(self.view);
        }];
        iv;
    });
}
@end
