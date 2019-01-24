//
//  TTMineViewController.h
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTMineViewController : TTBaseViewController

@property(nonatomic,strong)UICollectionView *profileCollectionView;

@property(nonatomic,assign)NSInteger   selectIndex;

@end

NS_ASSUME_NONNULL_END
