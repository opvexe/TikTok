//
//  TTMineViewController.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMineViewController.h"
#import "TTHoverViewFlowLayout.h"

@interface TTMineViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property(nonatomic,strong)UICollectionView *profileCollectionView;
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
}

-(void)configView{
    
    _profileCollectionView = ({
        TTHoverViewFlowLayout *layout =[[TTHoverViewFlowLayout alloc]initWithTopHeight:120.0f];
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
//        [iv registerClass:[SYMoreFunctionCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SYMoreFunctionCollectionViewCell class])];
//        [iv registerClass:[SYMoreHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SYMoreHeaderCollectionReusableView class])];
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





@end
