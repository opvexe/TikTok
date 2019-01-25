//
//  TTInteractiveTransition.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTInteractiveTransition.h"
@interface TTInteractiveTransition()
@property (nonatomic, strong) UIViewController *presentingVC;
@property (nonatomic, assign) CGPoint viewControllerCenter;
@end
@implementation TTInteractiveTransition

-(void)wireToViewController:(TTHomeViewController *)viewController {
    _presentingVC = viewController;
    _viewControllerCenter = viewController.view.center;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    if(!_interacting && (translation.x < 0 || translation.y < 0 || translation.x < translation.y)) {
        return;
    }
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interacting = YES;
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat progress = translation.x / [UIScreen mainScreen].bounds.size.width;
            progress = fminf(fmaxf(progress, 0.0), 1.0);
            
            CGFloat ratio = 1.0f - progress*0.5f;
            [_presentingVC.view setCenter:CGPointMake(_viewControllerCenter.x + translation.x * ratio, _viewControllerCenter.y + translation.y * ratio)];
            _presentingVC.view.transform = CGAffineTransformMakeScale(ratio, ratio);
            [self updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            CGFloat progress = translation.x / [UIScreen mainScreen].bounds.size.width;
            progress = fminf(fmaxf(progress, 0.0), 1.0);
            if (progress < 0.2){
                [UIView animateWithDuration:progress
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.presentingVC.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
                                     self.presentingVC.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                 } completion:^(BOOL finished) {
                                     self.interacting = NO;
                                     [self cancelInteractiveTransition];
                                 }];
            }else {
                _interacting = NO;
                [self finishInteractiveTransition];
                [_presentingVC dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
        default:
            break;
    }
}

@end