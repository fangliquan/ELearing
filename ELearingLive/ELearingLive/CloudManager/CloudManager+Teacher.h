//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"
#import "UserTruthInfo.h"
@class UcMyFollowTeacherModel;
@interface CloudManager (Teacher)

- (void)asyncUserApplyForTeacher:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion;


- (void)asyncUpdateUserTruthInfo:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion;



- (void)asyncMyFollowTeacherWithPage:(NSString *)page  completion:(void (^)(UcMyFollowTeacherModel *ret, CMError *error))completion;


- (void)asyncUpdateUserTruthInfo:(void (^)(UserTruthInfo *ret, CMError *error))completion;




- (void)asyncUserIsApplyForTeacher:(void (^)(NSInteger ret, CMError *error))completion;


@end
