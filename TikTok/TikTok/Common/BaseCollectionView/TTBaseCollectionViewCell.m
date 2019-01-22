//
//  TTBaseCollectionViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseCollectionViewCell.h"

@implementation TTBaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        [self TTSinitConfingViews];
        [self TTConfigSignalDataSoucre];
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self TTSinitConfingViews];
    [self TTConfigSignalDataSoucre];
}
- (void)TTSinitConfingViews{
    
}

-(void)TTConfigSignalDataSoucre{
    
}

-(void)InitDataWithModel:(TTBaseModel *)model{
    
}

+(CGSize)getHeight:(TTBaseModel* )model{
    
    return CGSizeZero;
}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
