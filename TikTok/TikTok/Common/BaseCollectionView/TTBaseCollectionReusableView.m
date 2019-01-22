//
//  TTBaseCollectionReusableView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseCollectionReusableView.h"

@implementation TTBaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self TTSinitConfingViews];
        
        [self TTSetupViewModel];
        
        [self TTConfigSignalDataSoucre];
    }
    return  self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self TTSinitConfingViews];
    
    [self TTSetupViewModel];
    
    [self TTConfigSignalDataSoucre];
    
}
/**
 *  初始视图
 */
- (void)TTSinitConfingViews{
    
}
/**
 *  配置数据
 */
- (void)TTSetupViewModel{
    
}
/**
 *  配置信号数据
 */
-(void)TTConfigSignalDataSoucre{
    
}

+(CGSize)getHeight:(TTBaseModel* )model{
    
    return CGSizeZero;
}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


@end
