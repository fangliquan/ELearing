//
//  CloudManger+Login.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//


#import "CloudManager+Teacher.h"
#import "CMError.h"
#import "GCDMulticastDelegate.h"
#import "PublicUtil.h"
#import "UcTeacherModel.h"
@implementation CloudManager (Teacher)
- (void)asyncUserApplyForTeacher:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcAuthTeacher]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"real_name" : info.real_name?info.real_name:@" ",
                              @"idcard" : info.idcard?info.idcard:@"",
                              @"mobile" : info.mobile?info.mobile:@"",
                              @"intro" : info.intro?info.intro:@"",
                              @"email" : info.email?info.email:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(@"OK",nil);
                }
            }else{
                if (completion) {
                    completion(baseModel.error_desc,error);
                }
            }
           
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];

}

- (void)asyncUpdateUserTruthInfo:(UserTruthInfo *)info  completion:(void (^)(NSString *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcEditUser]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"real_name" : info.real_name?info.real_name:@" ",
                              @"age" : info.age?info.age:@"",
                              @"mobile" : info.mobile?info.mobile:@"",
                              @"company" : info.commpany?info.commpany:@"",
                              @"position" : info.profession?info.profession:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(@"OK",nil);
                }
            }else{
                if (completion) {
                    completion(baseModel.error_desc,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}


- (void)asyncUpdateUserTruthInfo:(void (^)(UserTruthInfo *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcUserInfo]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            UserTruthInfo * truthInfo = [UserTruthInfo mj_objectWithKeyValues:ret];
            if ([truthInfo.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(truthInfo,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];

}
-(void) updateCurrentIsTeacher:(NSInteger)isTeacher
{
    DBManager *dbm = [DBManager sharedInstance];
    UserLoginResponse *loginRespone = [CloudManager sharedInstance].currentAccount.userLoginResponse;
    loginRespone.is_teacher = isTeacher;
    [dbm saveSyncDataLoginResultInfoWithUserLoginReslut:loginRespone];
    _currentAccount = [dbm loadAccountInfo];//must reload from db again!!!
    
    [_delegates didUpdateUserInfoWithUserInfoResponse:loginRespone];
    
}
- (void)asyncUserIsApplyForTeacher:(void (^)(NSInteger ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcIsTeacher]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            UserApplyTeacherState * baseModel = [UserApplyTeacherState mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                [self updateCurrentIsTeacher:baseModel.is_teacher];
                if (completion) {
                    completion(baseModel.is_teacher,nil);
                }
            }else{
                
                if (completion) {
                    completion(0,error);
                }
            }
        }else {
            if (completion) {
                completion(0,error);
            }
        }
    }];

}
//我关注的讲师
- (void)asyncMyFollowTeacherWithPage:(NSString *)page  completion:(void (^)(UcMyFollowTeacherModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcMyFollowTeacher]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"page" : page?page:@"1",
                      
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            UcMyFollowTeacherModel * baseModel = [UcMyFollowTeacherModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}


//老师信息
- (void)asyncGetTeacherInfoWithId:(NSString *)teacherid  completion:(void (^)(TeacherInfoModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriTeacherInfo]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"teacherid" : teacherid?teacherid:@"1",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            TeacherInfoModel * baseModel = [TeacherInfoModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}
- (void)asyncGetTeacherCourseListWithId:(NSString *)teacherid andPage:(NSString *)page andPageSize:(NSString*)pagesize completion:(void (^)(TeacherCourseListModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriTeacherCourseList]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"page" : page?page:@"1",
                              @"teacherid" : teacherid?teacherid:@"1",
                              @"pagesize" : pagesize?pagesize:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            TeacherCourseListModel * baseModel = [TeacherCourseListModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

//评价讲师 /teacher/evaluate
- (void)asyncTeacherAddEvaluate:(NSString *)courseId andContent:(NSString *)content andScore:(NSString*)score completion:(void (^)(NSString *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriTeacherEvaluate]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"teacherid" : courseId?courseId:@"",
                              @"content" : content?content:@"",
                              @"score" : score?score:@"0",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                NSString *score =nil;
                if ([[ret allKeys]containsObject:@"score"]) {
                    score = [ret objectForKey:@"score"];
                }
                if (completion) {
                    completion(score,nil);
                }
            }else{
                [MBProgressHUD showError:baseModel.error_desc toView:nil];
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}
//讲师评价列表
- (void)asyncTeacherEvaluateListWithTeacherId:(NSString *)teacherid andPage:(NSString *)page  completion:(void (^)(TeacherEvaluateListModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriTeacherEvaluateList]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"page" : page?page:@"1",
                              @"teacherid" : teacherid?teacherid:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            TeacherEvaluateListModel * baseModel = [TeacherEvaluateListModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}
- (void)asyncGetTeacherFollowedWithTeacherId:(NSString *)teacherId andBool:(BOOL)follow completion:(void (^)(NSString*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",follow? [self uriTeacherfollow]:[self uriTeacherunfollow]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"teacherid" : teacherId?teacherId:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                NSString *score =nil;
                if ([[ret allKeys]containsObject:@"message"]) {
                    score = [ret objectForKey:@"message"];
                }
                if (completion) {
                    completion(score,nil);
                }
            }else{
                [MBProgressHUD showError:baseModel.error_desc toView:nil];
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}


@end
