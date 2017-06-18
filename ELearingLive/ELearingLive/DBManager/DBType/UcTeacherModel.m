//
//  UcTeacherModel.m
//  ELearingLive
//
//  Created by microleo on 2017/6/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "UcTeacherModel.h"

@implementation UcTeacherModel

@end

@implementation UcMyFollowTeacherModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[UcMyFollowTeacherItem class]};
}


@end
@implementation UcMyFollowTeacherItem



@end

@implementation TeacherInfoModel


@end

@implementation TeacherCourseListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[TeacherCourseListItem class]};
}


@end


@implementation TeacherCourseListItem



@end

@implementation TeacherEvaluateListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[TeacherEvaluateListItem class]};
}

@end


@implementation TeacherEvaluateListItem



@end

@implementation TeacherCreateCourseInfo



@end

@implementation TeacherMyCourseModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"teach_list":[TeacherCourseListItem class],@"study_list":[TeacherCourseListItem class]};
}

@end
