//
//  TTMessageViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMessageViewController.h"
#import "TTPopShowView.h"
@implementation TTMessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}


-(void)Click{
    TTPopShowView *popShow = [[TTPopShowView alloc]initWithComment:@"解约后，蒋停用缴费代扣功能，\n请您留意账单信息，及时缴费！"];
    
    [popShow show];
    
}

@end
