//
//  TTDismissingAnimator.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTDismissingAnimator.h"
#import "TTMineViewController.h"
#import "TTHomeViewController.h"
#import "TTProfileCollectionViewCell.h"
#import "TTRootViewController.h"
#import "TTBaseNavigationViewController.h"
@implementation TTDismissingAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         _centerFrame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 5)/2, ([UIScreen mainScreen].bounds.size.height - 5)/2, 5, 5);
    }
    return self;
}

//MARK: 动画时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

///MARK: 切换的上下文信息
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ///MARK:当前VC
    TTHomeViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ///MARK:当前RootVC
    TTBaseNavigationViewController *rootVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    ///MARK:跳转VC
    TTMineViewController *toVC = rootVC.viewControllers.firstObject;
    
    ///MARK: 跳转Cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:fromVC.currentIndex inSection:0];
    TTProfileCollectionViewCell *selectCell = (TTProfileCollectionViewCell *)[toVC.listCollectionView cellForItemAtIndexPath:indexPath];

    UIView *snapshotView;
    CGFloat scaleRatio;
    CGRect finalFrame;
    if(selectCell) {
        snapshotView = [selectCell snapshotViewAfterScreenUpdates:NO];
        scaleRatio = fromVC.view.frame.size.width/selectCell.frame.size.width;
        snapshotView.layer.zPosition = 20;
        finalFrame = [toVC.listCollectionView convertRect:selectCell.frame toView:[toVC.listCollectionView superview]];
    }else {
        snapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        scaleRatio = fromVC.view.frame.size.width/[UIScreen mainScreen].bounds.size.width;
        finalFrame = _centerFrame;
    }

    ///MARK:添加跳转VC到transitionContext
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:snapshotView];

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    ///MARK: 转场动画
    fromVC.view.alpha = 0.0f;
    snapshotView.center = fromVC.view.center;
    snapshotView.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         snapshotView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         snapshotView.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext finishInteractiveTransition];
                         [transitionContext completeTransition:YES];
                         [snapshotView removeFromSuperview];
                     }];
}


@end
