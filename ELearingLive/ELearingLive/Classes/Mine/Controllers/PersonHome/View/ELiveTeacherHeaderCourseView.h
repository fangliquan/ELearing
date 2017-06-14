//
//  ELiveTeacherHeaderCourseView.h
//  ELearingLive
//
//  Created by microleo on 2017/6/14.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeacherCourseListItem ;
@interface ELiveTeacherHeaderCourseView : UIView

@property(nonatomic,strong) NSMutableArray *courseArray;

+(CGFloat)teacherHeaderCourseViewHeight:(NSArray *)courseArray;

@property (nonatomic, copy) void (^lookMoreTeacherCourseBlock)();

@property (nonatomic, copy) void (^teacherCourseItemBlock)(TeacherCourseListItem *courseItem);
@end
