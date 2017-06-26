//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"
#import "UserTruthInfo.h"
@class UcMyFollowTeacherModel,TeacherInfoModel,TeacherCourseListModel,TeacherEvaluateListModel,TeacherMyCourseModel,MyIncomingsModel;
@interface CloudManager (Teacher)

- (void)asyncUserApplyForTeacher:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion;

- (void)asyncUpdateUserTruthInfo:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion;

- (void)asyncMyFollowTeacherWithPage:(NSString *)page  completion:(void (^)(UcMyFollowTeacherModel *ret, CMError *error))completion;

- (void)asyncMyFansWithPage:(NSString *)page  completion:(void (^)(UcMyFollowTeacherModel *ret, CMError *error))completion;
- (void)asyncMyIncomingsWithPage:(NSString *)page  completion:(void (^)(MyIncomingsModel *ret, CMError *error))completion;


- (void)asyncUpdateUserHeaderImageWithimage:(UIImage *)image  completion:(void (^)(NSString *ret, CMError *error))completion;

- (void)asyncUpdateUserTruthInfo:(void (^)(UserTruthInfo *ret, CMError *error))completion;

- (void)asyncUserIsApplyForTeacher:(void (^)(NSString *ret, CMError *error))completion;

//讲师信息
- (void)asyncGetTeacherInfoWithId:(NSString *)teacherid  completion:(void (^)(TeacherInfoModel *ret, CMError *error))completion;

//将是课程列表 pagesize 可以不传
- (void)asyncGetTeacherCourseListWithId:(NSString *)teacherid andPage:(NSString *)page andPageSize:(NSString*)pagesize completion:(void (^)(TeacherCourseListModel *ret, CMError *error))completion;
//评价讲师 /teacher/evaluate
- (void)asyncTeacherAddEvaluate:(NSString *)courseId andContent:(NSString *)content andScore:(NSString*)score completion:(void (^)(NSString *ret, CMError *error))completion;
//讲师评价列表
- (void)asyncTeacherEvaluateListWithTeacherId:(NSString *)teacherid andPage:(NSString *)page  completion:(void (^)(TeacherEvaluateListModel *ret, CMError *error))completion;
//讲师关注
- (void)asyncGetTeacherFollowedWithTeacherId:(NSString *)teacherId andBool:(BOOL)follow completion:(void (^)(NSString*ret, CMError *error))completion;

//关注的课程列表
- (void)asyncGetMyFollowedCourseListWithPage:(NSString *)page andIsMyJoin:(BOOL)join  completion:(void (^)(TeacherCourseListModel *ret, CMError *error))completion;


- (void)asyncGetTopicCourseListWithPage:(NSString *)page andTopicId:(NSString *)topicId  completion:(void (^)(TeacherCourseListModel *ret, CMError *error))completion;


//课程日历模式
- (void)asyncGetMyCourseCarlendarListWithDate:(NSString *)date  completion:(void (^)(TeacherMyCourseModel *ret, CMError *error))completion;



@end
