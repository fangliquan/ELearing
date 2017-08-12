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

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[UcCourseCategireMainItem class]};
}

@end

@implementation UcCourseCategireMainItem



@end
@implementation UcCourseCategireChildModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children":[UcCourseCategireChildItem class]};
}
@end

@implementation UcCourseCategireChildItem



@end

@implementation CourseEditInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"periods":[CoursePeriodItemModel class]};
}


@end

@implementation CourseDetailInfoModel



@end
@implementation CoursePlayDetailAdModel



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
@implementation CourseBuyReasultModel



@end
@implementation CoursePayWeiXinReasultModel



@end

@implementation CourseAliPayReasultModel



@end
@implementation CoursePushInfoModel



@end

@implementation MyIncomingsModelItem



@end

@implementation MyIncomingsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[MyIncomingsModelItem class]};
}


@end
