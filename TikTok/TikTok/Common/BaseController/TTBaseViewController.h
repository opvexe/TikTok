//
//  TTBaseViewController.h
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+WDNavigatonBarAppearance.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ToastPositionType) {
    ToastPositionTypeTop,
    ToastPositionTypeCenter,
    ToastPositionTypeBottom,
};
@interface TTBaseViewController : UIViewController

@property (nonatomic,strong) UIView *navigationRightView;

@property (nonatomic,strong) UIView *navigationleftView;

- (void)dismissKeyBoard;

-(void)networkErrorWithView:(UIView*)view;

-(void)reloadDataSoucre;

- (void)removePlaceholderView;

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView;

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(SEL)reloadAction;

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView refTitle:(NSString *)reftitle action:(SEL)reloadAction;

- (void)makeToast:(NSString *)message;

-(void)makeToast:(NSString *)message backImageView:(NSString *)image;

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType )position;

@end

NS_ASSUME_NONNULL_END
