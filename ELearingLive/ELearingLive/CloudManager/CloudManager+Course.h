//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"

@class UcCourseCategireChildModel,UcCourseCategireModel,CourseDetailInfoModel,CourseChapterlistModel,CourseEvaluateListModel,TeacherCourseListModel,TeacherCreateCourseInfo,CourseBuyReasultModel,CoursePayReasultModel,CoursePushInfoModel,CourseEditInfoModel;
@interface CloudManager (Course)
//课程分类
- (void)asyncGetCourseCategiresInfo:(void (^)(UcCourseCategireModel *ret, CMError *error))completion;
//课程子分类
- (void)asyncGetCourseChildCategiresWithCateId:(NSString *)cateId  completion:(void (^)(UcCourseCategireChildModel *ret, CMError *error))completion;

//创建课程
-(void)asyncCreateNewCourseWithCourseInfo:(TeacherCreateCourseInfo *)courseInfo completion:(void (^)(CourseDetailInfoModel*ret, CMError *error))completion;

-(void)asyncSaveEditCourseWithCourseInfo:(TeacherCreateCourseInfo *)courseInfo completion:(void (^)(CourseDetailInfoModel*ret, CMError *error))completion;

//课程详情
- (void)asyncGetCourseDetailInfoWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid andMore:(NSString *)more  completion:(void (^)( CourseDetailInfoModel*ret, CMError *error))completion;
//课程编辑
- (void)asyncGetCourseEditInfoWithCourseId:(NSString *)courseId completion:(void (^)(CourseEditInfoModel*ret, CMError *error))completion;

///course/chapterlist 课程详情目录
//课程x详情目录
- (void)asyncGetCourseChapterListWithCourseId:(NSString *)courseId completion:(void (^)(CourseChapterlistModel*ret, CMError *error))completion;


//课程详情评价目录
- (void)asyncGetCourseEvaluateListWithCourseId:(NSString *)courseId andPage:(NSString *)page completion:(void (^)(CourseEvaluateListModel*ret, CMError *error))completion;

- (void)asyncAddCourseEvaluateListWithCourseId:(NSString *)courseId andContent:(NSString *)content andScore:(NSString *)score completion:(void (^)(NSString*ret, CMError *error))completion;

//课程 收藏
- (void)asyncGetCourseFollowedWithCourseId:(NSString *)courseId andBool:(BOOL)follow completion:(void (^)(NSString*ret, CMError *error))completion;

//参加课程购买
- (void)asyncGetCourseNeedBuyWithCourseId:(NSString *)courseId andPwd:(NSString *)pwd completion:(void (^)(CourseBuyReasultModel*ret, CMError *error))completion;
//支付
- (void)asyncGetPaymentWithOrderId:(NSString *)orderId andType:(NSString *)type completion:(void (^)(NSObject*ret, CMError *error))completion;

//课程列表
- (void)asyncGetCourseListWithCateId:(NSString *)catesId andPage:(NSString *)page completion:(void (^)(TeacherCourseListModel*ret, CMError *error))completion;

//搜索
- (void)asyncSearchCourseWithKeyword:(NSString *)keyword andPage:(NSString *)page completion:(void (^)(TeacherCourseListModel*ret, CMError *error))completion;
//直播推流
- (void)asyncStartPushCourseWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid  completion:(void (^)(CoursePushInfoModel*ret, CMError *error))completion;
//结束推流
- (void)asyncStopPushCourseWithPeriodid:(NSString *)periodid  completion:(void (^)(NSString*ret, CMError *error))completion;
//上传推流结束
- (void)asyncUploadPushCourseWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid andSecond:(NSString *)second completion:(void (^)( NSString*ret, CMError *error))completion;
//直播播放详情
- (void)asyncPushCourseInfoWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid completion:(void (^)( CourseDetailInfoModel*ret, CMError *error))completion;


@end
