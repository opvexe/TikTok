//
//  TTMineViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMineViewController.h"
#import "TTHoverViewFlowLayout.h"
#import "TTProfileCollectionViewCell.h"
#import "TTProfileHeaderCollectionReusableView.h"
#import "TTUserModel.h"
#define TTHeaderHeight          350 + NavBarHeight
#define kSlideTabBarHeight      40
@interface TTMineViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate,
TTSlideTabBarDelegate,
TTUserHeaderDelegate
>
@property(nonatomic,strong)UICollectionView *profileCollectionView;
@property(nonatomic,strong)TTProfileHeaderCollectionReusableView *Header;
@property(nonatomic,strong)TTUserModel *userModel;
@property(nonatomic,assign)NSInteger  tabIndex;
@property(nonatomic,strong)NSMutableArray *lists;
@end
@implementation TTMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self refreshLoadDataSoucre];
}

-(void)configView{
    
    _profileCollectionView = ({
        TTHoverViewFlowLayout *layout =[[TTHoverViewFlowLayout alloc]initWithTopHeight:NavBarHeight + kSlideTabBarHeight];
        layout.minimumInteritemSpacing = 0.0f;
        layout.minimumLineSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        iv.backgroundColor = [UIColor whiteColor];
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator = NO;
        iv.alwaysBounceVertical = YES;
        iv.dataSource = self;
        iv.delegate = self;
        [self.view addSubview:iv];
        [iv registerClass:[TTProfileCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TTProfileCollectionViewCell class])];
        [iv registerClass:[TTProfileHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TTProfileHeaderCollectionReusableView class])];
        [iv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.edges.mas_equalTo(self.view.safeAreaInsets);
            }else{
                make.edges.mas_equalTo(self.view);
            }
        }];
        iv;
    });
}

-(void)refreshLoadDataSoucre{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *user =  [NSString readJson2DicWithFileName:@"user"];
        self.userModel = [TTUserModel mj_objectWithKeyValues:user[@"data"]];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.profileCollectionView reloadData];
    });
}

#pragma mark <UICollectionViewCellDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTProfileCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTProfileCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(self.view.width/3,self.view.width*1.35f/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  区头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){[UIScreen mainScreen].bounds.size.width,TTHeaderHeight};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        TTProfileHeaderCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TTProfileHeaderCollectionReusableView class]) forIndexPath:indexPath];
        reusableView.slideTabBar.delegate = self;
        [reusableView InitDataWithModel:_userModel];
        _Header = reusableView;
        return reusableView;
    }
    return [UICollectionReusableView new];
}

#pragma mark TTSlideTabBarDelegate
- (void)onTabTapAction:(NSInteger)index{
    if(_tabIndex == index){
        return;
    }

}

- (void)clickUserWithType:(TTUserHeaderDidClickType )type withUser:(TTBaseModel *)model{
    
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [_Header overScrollAction:offsetY];
    }else {
        [_Header scrollToTopAction:offsetY];
        //        [self updateNavigationTitle:offsetY];
    }
}

@end
