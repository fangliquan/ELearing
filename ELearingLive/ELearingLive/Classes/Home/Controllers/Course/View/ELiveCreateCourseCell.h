//
//  ELiveCreateCourseCell.h
//  ELearingLive
//
//  Created by microleo on 2017/6/16.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherCreateCourseInfo;
@interface ELiveCreateCourseCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property(nonatomic,strong) TeacherCreateCourseInfo *createCourseInfo;

@property(nonatomic,assign) NSInteger  sectionIndex;
@property(nonatomic,assign) NSInteger  rowIndex;
@end
