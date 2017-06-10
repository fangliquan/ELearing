//
//  CloudManger+Login.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//


#import "CloudManager+Course.h"
#import "CMError.h"
#import "GCDMulticastDelegate.h"
#import "PublicUtil.h"
#import  "UcCourseIndex.h"
@implementation CloudManager (Course)

//课程分类
- (void)asyncGetCourseCategiresInfo:(void (^)(UcCourseCategireModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseCategires]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            UcCourseCategireModel * truthInfo = [UcCourseCategireModel mj_objectWithKeyValues:ret];
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
//课程子分类
- (void)asyncGetCourseChildCategiresWithCateId:(NSString *)cateId  completion:(void (^)(UcCourseCategireChildModel *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseCategires]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                               @"token" : token?token:@"",
                               @"cateId" : cateId?cateId:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            UcCourseCategireChildModel * truthInfo = [UcCourseCategireChildModel mj_objectWithKeyValues:ret];
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

- (void)asyncGetCourseDetailInfoWithCateId:(NSString *)courseId andPeriodid:(NSString *)periodid andMore:(NSString *)more  completion:(void (^)(CourseDetailInfoModel*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourserInfo]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                               @"periodid" : periodid?periodid:@"",
                               @"more" : more?more:@"0",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CourseDetailInfoModel * truthInfo = [CourseDetailInfoModel mj_objectWithKeyValues:ret];
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
@end
