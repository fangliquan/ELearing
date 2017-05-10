//
//  ELiewHomeGoodCourseCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiewHomeGoodCourseCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) NSString *hedoneVedioDTO;


+(CGFloat)cellHeightWithModel:(NSString *)str;
@end
