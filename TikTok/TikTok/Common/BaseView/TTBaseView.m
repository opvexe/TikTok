//
//  TTBaseView.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseView.h"

@implementation TTBaseView

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self TTSAddSubviews];
        [self TTSInitConfingViews];
    }
    return  self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self TTSAddSubviews];
    [self TTSInitConfingViews];
    
}
/**
 *  添加视图
 */
-(void)TTSAddSubviews{
    
}
/**
 *  初始视图
 */
- (void)TTSInitConfingViews{
    
}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}
@end
