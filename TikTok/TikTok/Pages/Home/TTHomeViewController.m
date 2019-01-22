//
//  TTHomeViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTHomeViewController.h"
#import "TTRightItemView.h"
@interface TTHomeViewController ()
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation TTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNativeItemsView];
    [self configView];
}

-(void)configView{
    
    
}

-(void)settingNativeItemsView{
    
    _segment = ({
        UISegmentedControl *iv = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"北京"]];
        iv.frame = CGRectMake(0, 0, Number(60.0f), NumberHeight(30));
        iv.tintColor = [UIColor clearColor];
        iv.selectedSegmentIndex = 0;
        NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:16.0f],NSForegroundColorAttributeName : [UIColor TextGrayColor]};
        [iv setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
        NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:18.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
        [iv setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
        [iv addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = iv;
        iv;
    });
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    leftView.frame = CGRectMake(0, 0, Number(50.0f), NumberHeight(30.0f));
    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateNormal];
    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateHighlighted];
    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateSelected];
    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateDisabled];
    [leftView setTitle:@"随拍" forState:UIControlStateNormal];
    [leftView setTitle:@"随拍" forState:UIControlStateHighlighted];
    [leftView setTitle:@"随拍" forState:UIControlStateSelected];
    [leftView setTitle:@"随拍" forState:UIControlStateDisabled];
    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateNormal];
    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateHighlighted];
    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateSelected];
    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateDisabled];
    [leftView.titleLabel setFont:[UIFont SYHelveticaFontOfSize:14.0f]];
    [leftView layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:3.0f];
    self.navigationleftView = leftView;
    
    TTRightItemView *rightView = [[TTRightItemView alloc]initWithFrame:CGRectMake(0, 0, Number(80.0f), NumberHeight(30.0f))];
    self.navigationRightView = rightView;
    [rightView compelet:^(TTRightItemViewClickType type) {
        switch (type) {
            case TTRightItemViewClickTypeSearch:{
                
            }
                break;
            case TTRightItemViewClickTypeLiving:{
                
            }
                break;
            default:
                break;
        }
    }];
}



-(void)segmentAction:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        
        
    }else if (segment.selectedSegmentIndex == 1){
        
        
    }
}

@end
