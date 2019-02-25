//
//  TTTools.m
//  TikTok
//
//  Created by FaceBook on 2019/1/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTTools.h"

@implementation TTTools

+(CGFloat)getHeightContain:(NSString *)string font:(UIFont *)font Width:(CGFloat) width{
    
    if (string ==nil) {
        
        return 0;
    }
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 10.0;
    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    [astr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
   
    CGSize contanSize = CGSizeMake(width, CGFLOAT_MAX);
    
    if (iOS7) {
        
        CGRect rect =[astr boundingRectWithSize:contanSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        return rect.size.height;
    }else{
        
        CGSize s=[string sizeWithFont:font constrainedToSize:contanSize lineBreakMode:NSLineBreakByCharWrapping];
        return s.height;
        
    }
    
}

+(CGFloat)getWidthContain:(NSString *)string font:(UIFont *)font Height:(CGFloat) height{
    
    
    if (string ==nil) {
        
        return 0;
    }
    
    NSAttributedString *astr = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font}];
    
    CGSize contanSize = CGSizeMake(CGFLOAT_MAX,height );
    
    if (iOS7) {
        
        CGRect rect =[astr boundingRectWithSize:contanSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        
        return rect.size.width;
    }else{
        
        CGSize s=[string sizeWithFont:font constrainedToSize:contanSize lineBreakMode:NSLineBreakByCharWrapping];
        return s.width;
        
    }
    
}


@end
