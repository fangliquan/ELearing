//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"

@class UcCourseCategireChildModel,UcCourseCategireModel,CourseDetailInfoModel,CourseChapterlistModel,CourseEvaluateListModel;
@interface CloudManager (Course)
//课程分类
- (void)asyncGetCourseCategiresInfo:(void (^)(UcCourseCategireModel *ret, CMError *error))completion;
//课程子分类
- (void)asyncGetCourseChildCategiresWithCateId:(NSString *)cateId  completion:(void (^)(UcCourseCategireChildModel *ret, CMError *error))completion;


//课程详情
- (void)asyncGetCourseDetailInfoWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid andMore:(NSString *)more  completion:(void (^)( CourseDetailInfoModel*ret, CMError *error))completion;

///course/chapterlist 课程详情目录
//课程x详情目录
- (void)asyncGetCourseChapterListWithCourseId:(NSString *)courseId completion:(void (^)(CourseChapterlistModel*ret, CMError *error))completion;


//课程详情评价目录
- (void)asyncGetCourseEvaluateListWithCourseId:(NSString *)courseId andPage:(NSString *)page completion:(void (^)(CourseEvaluateListModel*ret, CMError *error))completion;


@end
