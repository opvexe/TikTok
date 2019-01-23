//
//  TTBaseTableViewCell.h
//  TikTok
//
//  Created by FaceBook on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseTableViewCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTBaseTableViewCell : UITableViewCell<TTBaseTableViewCellProtocol>


+(id)CellWithTableView:(UITableView *)tableview;


@end

NS_ASSUME_NONNULL_END
