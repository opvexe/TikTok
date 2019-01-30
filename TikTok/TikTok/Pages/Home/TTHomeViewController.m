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
#import "TTCommentShowView.h"
#import "TTShareShowView.h"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self refreshLoadDataSoucre];
    
    NSLog(@"测试 == 分支1");
    NSLog(@"测试 == 分支1");
    NSLog(@"测试 == 分支1");
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
        if (iOS11) {
            iv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets =NO;
        }
        iv;
    });
    
    _navgationView = ({
        TTNavigationView *iv = [[TTNavigationView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width,NumberHeight(50.0f))];
        iv.backgroundColor = [UIColor clearColor];
        [self.view addSubview:iv];
        iv;
    });
    
    
    [self.navgationView.rightView compelet:^(TTRightItemViewClickType type) {
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
    
    [self.navgationView setClickBlock:^(TTNavigationClickType type, NSInteger selectedSegmentIndex) {
        switch (type) {
            case TTNavigationClickTypeSegment:{
                
            }
                break;
            case TTNavigationClickTypeShot:{
                
            }
                break;
            default:
                break;
        }
    }];
}

-(void)refreshLoadDataSoucre{
    NSDictionary *awemes =  [NSString readJson2DicWithFileName:@"awemes"];
    self.lists = [TTAwemeModel mj_objectArrayWithKeyValuesArray:awemes[@"data"]];
    [self.tableListView reloadData];
}

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
            TTCommentShowView *comment = [[TTCommentShowView alloc]initWithCommentId:model.aweme_id];
            [comment show];
        }
            break;
        case TTPlayerTableClickTypeShare:{
            TTShareShowView *share = [TTShareShowView creatViewComplelte:^(NSInteger selectIndexPath) {
                
            }];
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
