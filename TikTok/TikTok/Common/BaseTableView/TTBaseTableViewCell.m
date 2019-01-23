//
//  TTBaseTableViewCell.m
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTBaseTableViewCell.h"

@implementation TTBaseTableViewCell

+(id)CellWithTableView:(UITableView *)tableview{
    
    return nil;
};

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [self TTSinitConfingViews];
        
        [self TTSetupViewModel];
        
        [self TTConfigSignalDataSoucre];
        
    }
    return  self ;
}

-(void)awakeFromNib{
    [super awakeFromNib];
  
    [self TTSinitConfingViews];
    
    [self TTSetupViewModel];
    
    [self TTConfigSignalDataSoucre];
    
}

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

-(void)InitDataWithModel:(TTBaseModel *)model{
    
}

+(CGFloat)getCellHeight:(TTBaseModel *)model{
    
    return  0;
}

@end
