//
//  ELiveMessageViewCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/25.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveMessageViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;
@end
