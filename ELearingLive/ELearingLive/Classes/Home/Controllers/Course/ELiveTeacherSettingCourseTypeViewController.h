//
//  ELiveTeacherSettingCourseTypeViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/6/18.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherCreateCourseInfo;
@interface ELiveTeacherSettingCourseTypeViewController : UIViewController
@property(nonatomic,strong) TeacherCreateCourseInfo *teacherCourseInfo;
@property(nonatomic,assign) BOOL isEdit;

@property(nonatomic,strong) NSString *courseId;

@property(nonatomic,strong) NSString *course_type;
@end
