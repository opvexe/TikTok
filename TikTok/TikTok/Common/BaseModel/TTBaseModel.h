//
//  TTBaseModel.h
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseModel : NSObject

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *ClassName;

@property(nonatomic,copy)NSString *CellClass;

@property(nonatomic,strong)NSArray *sections;

@end

NS_ASSUME_NONNULL_END
