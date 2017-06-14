//
//  ELiveCourseIntroViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UcCourseIndex.h"
#import "UcTeacherModel.h"
@interface ELiveCourseIntroViewController : UITableViewController

// 更新view frame 和 tableView frame
- (void)updateViewControllerFrame:(CGRect)frame;

@property (nonatomic, copy) void (^userHomePageHandler)(NSString *teacerId);

@property(nonatomic,strong) CourseDetailInfoModel *courseDetailInfoModel;
@property(nonatomic,strong) TeacherInfoModel *teacherInfoModel;
@end
