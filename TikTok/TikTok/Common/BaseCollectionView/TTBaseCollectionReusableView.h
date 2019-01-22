//
//  TTBaseCollectionReusableView.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@class TTBaseModel;
@interface TTBaseCollectionReusableView : UICollectionReusableView<TTBaseViewProtocol>

+(CGSize)getHeight:(id )model;

@end

NS_ASSUME_NONNULL_END
