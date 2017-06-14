//
//  ELiveHomeHeaderView.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherInfoModel,TeacherCourseListModel,TeacherCourseListItem;
@interface ELiveHomeHeaderView : UIView

+(CGFloat)eLiveHomeHeaderHeight;

@property(nonatomic,strong) TeacherInfoModel *teacherInfoModel;
@end


@interface ELiveTeacherHeaderView : UIView


@property(nonatomic,strong) TeacherCourseListModel *teacherCourseListModel;

@property(nonatomic,strong) TeacherInfoModel *teacherInfoModel;

+(CGFloat)teacherHeaderViewHeight:(NSInteger)courseCount;


@property (nonatomic, copy) void (^lookMoreTeacherCourseBlock)();

@property (nonatomic, copy) void (^teacherCourseItemBlock)(TeacherCourseListItem *courseItem);


@end

