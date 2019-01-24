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
#import "TTVideoViewController.h"
#import "TTInteractiveTransition.h"
#import "TTPresentingAnimator.h"
#import "TTDismissingAnimator.h"
#import "TTMineViewController.h"
#define TTHeaderHeight          350 + NavBarHeight
#define kSlideTabBarHeight      40
@interface TTMineViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate,
TTSlideTabBarDelegate,
TTUserHeaderDelegate,
UIViewControllerTransitioningDelegate
>
@property(nonatomic,strong)TTProfileHeaderCollectionReusableView *Header;
@property (nonatomic, strong)TTInteractiveTransition *swipeLeftInteractiveTransition;
@property(nonatomic,strong)TTUserModel *userModel;
@property(nonatomic,assign)NSInteger  tabIndex;
@property(nonatomic,strong)NSMutableArray *lists;
@end
static NSInteger pageIndex;
@implementation TTMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarTitleColor:[UIColor clearColor]];
    [self setNavigationBarBackgroundColor:[UIColor clearColor]];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [self setNavigationBarBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self setStatusBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 0;
    [self configView];
    [self loadUserData];
    [self refreshLoadDataSoucre];
    _swipeLeftInteractiveTransition = [[TTInteractiveTransition alloc]init];
}

-(void)configView{
    
    _profileCollectionView = ({
        TTHoverViewFlowLayout *layout =[[TTHoverViewFlowLayout alloc]initWithTopHeight:NavBarHeight + kSlideTabBarHeight];
        layout.minimumInteritemSpacing = 0.0f;
        layout.minimumLineSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT - TT_TabbarHeight)
                                                 collectionViewLayout:layout];
        iv.backgroundColor = [UIColor blackColor];
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator = NO;
        iv.alwaysBounceVertical = YES;
        iv.dataSource = self;
        iv.delegate = self;
        [self.view addSubview:iv];
        [iv registerClass:[TTProfileCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TTProfileCollectionViewCell class])];
        [iv registerClass:[TTProfileHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TTProfileHeaderCollectionReusableView class])];
        [iv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        iv;
    });
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [_Header overScrollAction:offsetY];
    }else {
        [_Header scrollToTopAction:offsetY];
        [self updateNavigationTitle:offsetY];
    }
}

- (void)updateNavigationTitle:(CGFloat)offsetY {
    if (TTHeaderHeight -  self.navigationController.navigationBar.frame.size.height*2 > offsetY) {
        [self setNavigationBarTitleColor:[UIColor clearColor]];
    }
    if (TTHeaderHeight -  self.navigationController.navigationBar.frame.size.height*2 < offsetY && offsetY < TTHeaderHeight -  self.navigationController.navigationBar.frame.size.height) {
        CGFloat alphaRatio =  1.0f - (TTHeaderHeight - self.navigationController.navigationBar.frame.size.height - offsetY)/self.navigationController.navigationBar.frame.size.height;
        [self setNavigationBarTitleColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:alphaRatio]];
    }
    if (offsetY > TTHeaderHeight - self.navigationController.navigationBar.frame.size.height) {
        [self setNavigationBarTitleColor:[UIColor whiteColor]];
    }
}

#pragma mark TTSlideTabBarDelegate
- (void)onTabTapAction:(NSInteger)index{
    if(_tabIndex == index){
        return;
    }
    
    _tabIndex = index;
    pageIndex = 0;
    
    NSLog(@"请求数据");
}

-(void)loadUserData{
    NSDictionary *user =  [NSString readJson2DicWithFileName:@"user"];
    self.userModel = [TTUserModel mj_objectWithKeyValues:user[@"data"]];
    self.navigationItem.title = self.userModel.nickname;
    [self.profileCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

-(void)refreshLoadDataSoucre{
    NSDictionary *awemes =  [NSString readJson2DicWithFileName:@"awemes"];
    self.lists = [TTAwemeModel mj_objectArrayWithKeyValuesArray:awemes[@"data"]];
    [self.profileCollectionView reloadData];
}

#pragma mark <UICollectionViewCellDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTProfileCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTProfileCollectionViewCell class]) forIndexPath:indexPath];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lists.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((self.view.width-1.0f)/3,self.view.width*1.35f/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5f;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TTMineViewController *controller = [[TTMineViewController alloc]init];
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [_swipeLeftInteractiveTransition wireToViewController:controller];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)clickUserWithType:(TTUserHeaderDidClickType )type withUser:(TTBaseModel *)model{
    switch (type) {
        case TTUserHeaderDidClickTypeAvatar:{
            
        }
            break;
        case TTUserHeaderDidClickTypeSetting:{
            
        }
            break;
        case TTUserHeaderDidClickTypeAddsFriends:{
            
        }
            break;
        case TTUserHeaderDidClickTypeSendMessage:{
            
        }
            break;
        case TTUserHeaderDidClickTypeFocusAction:{
            
        }
            break;
        case TTUserHeaderDidClickTypeAboutMe:{
            
        }
            break;
        case TTUserHeaderDidClickTypeLikes:{
            
        }
            break;
        case TTUserHeaderDidClickTypeFocuse:{
            
        }
            break;
        case TTUserHeaderDidClickTypeFollowed:{
            
        }
            break;
        default:
            break;
    }
}

#pragma mark UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[TTPresentingAnimator alloc]init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[TTDismissingAnimator alloc]init];
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _swipeLeftInteractiveTransition.interacting ? _swipeLeftInteractiveTransition : nil;
}


@end
