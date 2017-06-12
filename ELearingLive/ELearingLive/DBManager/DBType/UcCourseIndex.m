//
//  UcCourseIndex.m
//  ELearingLive
//
//  Created by microleo on 2017/6/10.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "UcCourseIndex.h"

@implementation UcCourseIndex

@end

@implementation UcCourseCategireModel


@end

@implementation UcCourseCategireChildModel


@end

@implementation CourseDetailInfoModel



@end

@implementation CourseChapterlistModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[CourseChapterlistItemModel class]};
}

@end


@implementation CourseChapterlistItemModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"periods":[CoursePeriodItemModel class]};
}

@end


@implementation CoursePeriodItemModel


@end


@implementation CourseEvaluateListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[CourseEvaluateListItem class]};
}


@end

@implementation CourseEvaluateListItem



@end
