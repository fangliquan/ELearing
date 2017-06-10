//
//  ELiveFansFocusCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UcMyFollowTeacherItem;

@interface ELiveFansFocusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

@property(nonatomic,strong) UcMyFollowTeacherItem *myFollowTeacherItem;

+ (CGFloat)heightForCellWithModel:(UcMyFollowTeacherItem *)teacherItem;
@end
