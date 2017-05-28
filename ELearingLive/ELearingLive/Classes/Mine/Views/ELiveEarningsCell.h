//
//  ELiveEarningsCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveEarningsCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@end
