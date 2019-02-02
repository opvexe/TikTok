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
#import "TTAVPlayerManager.h"
@interface TTHomeViewController ()<
UITableViewDelegate,
UITableViewDataSource,
TTPlayerTableClickDelegate,
UIScrollViewDelegate,
UIViewControllerTransitioningDelegate
>
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)TTNavigationView *navgationView;
@property (nonatomic, assign) BOOL                              isCurPlayerPause;
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

    _isCurPlayerPause = NO;
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
        [self.tableListView scrollToRowAtIndexPath:curIndexPath atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:NO];
        [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    });
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
    [cell startDownloadBackgroundTask];
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

#pragma ScrollView delegate   ///用户已经停止拖拽scrollView，就会调用这个方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
     dispatch_async(dispatch_get_main_queue(), ^{
         
         CGPoint transPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
         
         //UITableView禁止响应其他滑动手势
         scrollView.panGestureRecognizer.enabled = NO;
         
         NSLog(@"%@", NSStringFromCGPoint(transPoint));
        
         if (transPoint.y < -50 &&self.currentIndex < self.lists.count - 1) {
             self.currentIndex ++ ; ///向下
         }else if (transPoint.y>50&&self.currentIndex>0){
             self.currentIndex -- ; ///向上
         }
        
         [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
             
             [self.tableListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
         } completion:^(BOOL finished) {
             //UITableView可以响应其他滑动手势
             scrollView.panGestureRecognizer.enabled = YES;
         }];
     });
}

#pragma KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //观察currentIndex变化
    if ([keyPath isEqualToString:@"currentIndex"]) {
        //设置用于标记当前视频是否播放的BOOL值为NO
        _isCurPlayerPause = NO;
        //获取当前显示的cell
        TTHomeTableViewCell *cell = [self.tableListView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
        __weak typeof (cell) wcell = cell;
        __weak typeof (self) wself = self;
        //判断当前cell的视频源是否已经准备播放
        if(cell.isPlayerReady) {
            //播放视频
            [cell replay];
        }else {
            [[TTAVPlayerManager shareManager] pauseAll];
            //当前cell的视频源还未准备好播放，则实现cell的OnPlayerReady Block 用于等待视频准备好后通知播放
            cell.onPlayerReady = ^{
                NSIndexPath *indexPath = [wself.tableListView indexPathForCell:wcell];
                if(!wself.isCurPlayerPause && indexPath && indexPath.row == wself.currentIndex) {
                    [wcell play];
                }
            };
        }
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
