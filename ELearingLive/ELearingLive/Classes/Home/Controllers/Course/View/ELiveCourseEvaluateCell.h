//
//  ELiveCourseEvaluateCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/24.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELiveCourseEvaluateCellFrame,CourseEvaluateListItem,TeacherEvaluateListItem;
@interface ELiveCourseEvaluateCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;
@property(nonatomic,strong) ELiveCourseEvaluateCellFrame *cellFrame;
@end

@interface ELiveCourseEvaluateCellFrame: NSObject

@property (nonatomic,strong) CourseEvaluateListItem *courseEvaluateListItem;

@property(nonatomic,strong) TeacherEvaluateListItem *teacherEvaluateListItem;

@property (nonatomic, assign) CGRect  headerFrame;
@property (nonatomic, assign) CGRect  userNameLFrame;
@property (nonatomic, assign) CGRect  timeLFrame;
@property (nonatomic, assign) CGRect  commentDespFrame;
@property (nonatomic, assign) CGRect  starFrame;
@property (nonatomic, assign) CGFloat cellHeight;

@end
