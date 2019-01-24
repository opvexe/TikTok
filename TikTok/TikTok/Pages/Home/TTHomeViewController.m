//
//  TTHomeViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTHomeViewController.h"
#import "TTCommentViewController.h"
#import "TTHomeTableViewCell.h"
#import "TTNavigationView.h"
@interface TTHomeViewController ()<
UITableViewDelegate,
UITableViewDataSource,
TTPlayerTableClickDelegate,
UIViewControllerTransitioningDelegate
>
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)TTNavigationView *navgationView;
@end

@implementation TTHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    //    [self setNavigationBarTitleColor:[UIColor clearColor]];
//    //    [self setNavigationBarBackgroundColor:[UIColor clearColor]];
//    //    [self setStatusBarBackgroundColor:[UIColor clearColor]];
//    //    [self setNavigationBarBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self settingNativeItemsView];
    [self configView];
    [self refreshLoadDataSoucre];
    if (iOS11) {
        self.tableListView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
}

-(void)configView{
    
    _tableListView = ({
        UITableView *iv = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [self.view addSubview:iv];
        iv.showsVerticalScrollIndicator =NO;
        iv.showsHorizontalScrollIndicator =NO;
        iv.separatorStyle = UITableViewCellSeparatorStyleNone;
        iv.backgroundColor = [UIColor clearColor];
        iv.dataSource = self;
        iv.delegate = self;
        iv.pagingEnabled = YES;  //回弹效果
        iv.bounces = NO;
        iv.estimatedSectionFooterHeight = 0;
        iv.estimatedSectionHeaderHeight = 0;
        iv.estimatedRowHeight = 0;
        iv.tableFooterView  =[UIView new];
        iv;
    });
    
    _navgationView = ({
        TTNavigationView *iv = [[TTNavigationView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width,NumberHeight(50.0f))];
        iv.backgroundColor = [UIColor clearColor];
        [self.view addSubview:iv];
        iv;
    });
    
}

-(void)refreshLoadDataSoucre{
    NSDictionary *awemes =  [NSString readJson2DicWithFileName:@"awemes"];
    self.lists = [TTAwemeModel mj_objectArrayWithKeyValuesArray:awemes[@"data"]];
    [self.tableListView reloadData];
}

//-(void)settingNativeItemsView{
//
//    _segment = ({
//        UISegmentedControl *iv = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"北京"]];
//        iv.frame = CGRectMake(0, 0, Number(60.0f), NumberHeight(30));
//        iv.tintColor = [UIColor clearColor];
//        iv.selectedSegmentIndex = 0;
//        NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:16.0f],NSForegroundColorAttributeName : [UIColor TextGrayColor]};
//        [iv setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
//        NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont SYPingFangSCSemiboldFontOfSize:18.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
//        [iv setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
//        [iv addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//        self.navigationItem.titleView = iv;
//        iv;
//    });
//
//    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftView.frame = CGRectMake(0, 0, Number(50.0f), NumberHeight(30.0f));
//    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateNormal];
//    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateHighlighted];
//    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateSelected];
//    [leftView setImage:[UIImage imageNamed:@"iconStoryhomeCamera"] forState:UIControlStateDisabled];
//    [leftView setTitle:@"随拍" forState:UIControlStateNormal];
//    [leftView setTitle:@"随拍" forState:UIControlStateHighlighted];
//    [leftView setTitle:@"随拍" forState:UIControlStateSelected];
//    [leftView setTitle:@"随拍" forState:UIControlStateDisabled];
//    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateNormal];
//    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateHighlighted];
//    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateSelected];
//    [leftView setTitleColor:[UIColor TextGrayColor] forState:UIControlStateDisabled];
//    [leftView.titleLabel setFont:[UIFont SYHelveticaFontOfSize:14.0f]];
//    [leftView layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:3.0f];
//    self.navigationleftView = leftView;
//
//    TTRightItemView *rightView = [[TTRightItemView alloc]initWithFrame:CGRectMake(0, 0, Number(80.0f), NumberHeight(30.0f))];
//    self.navigationRightView = rightView;
//    [rightView compelet:^(TTRightItemViewClickType type) {
//        switch (type) {
//            case TTRightItemViewClickTypeSearch:{
//
//            }
//                break;
//            case TTRightItemViewClickTypeLiving:{
//
//            }
//                break;
//            default:
//                break;
//        }
//    }];
//}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTHomeTableViewCell *cell  = [TTHomeTableViewCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}


- (void)playerClickType:(TTPlayerTableClickType )type model:(TTAwemeModel *)model{
    switch (type) {
        case TTPlayerTableClickTypePlay:{
            
        }
            break;
        case TTPlayerTableClickTypeAvator:{
            
        }
            break;
            
        case TTPlayerTableClickTypeLikes:{
            
        }
            break;
        case TTPlayerTableClickTypeComment:{
            NSLog(@"评论");
            TTCommentViewController *controller = [[TTCommentViewController alloc]init];
            controller.transitioningDelegate = self;
            //            controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            //            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case TTPlayerTableClickTypeShare:{
            
        }
            break;
        case TTPlayerTableClickTypeAlbum:{
            NSLog(@"专辑");
        }
            break;
        case TTPlayerTableClickTypeNickName:{
            
        }
            break;
        default:
            break;
    }
}


@end
