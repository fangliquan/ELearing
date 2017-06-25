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
#import "UcTeacherModel.h"
#import "ELiveCreateCourseCell.h"
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
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseChildren]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                               @"token" : token?token:@"",
                               @"pid" : cateId?cateId:@"",
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

- (void)asyncGetCourseDetailInfoWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid andMore:(NSString *)more  completion:(void (^)(CourseDetailInfoModel*ret, CMError *error))completion{
    
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

//课程x详情目录
- (void)asyncGetCourseChapterListWithCourseId:(NSString *)courseId completion:(void (^)(CourseChapterlistModel*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseChapterlist]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CourseChapterlistModel * truthInfo = [CourseChapterlistModel mj_objectWithKeyValues:ret];
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

//课程详情评价目录
- (void)asyncGetCourseEvaluateListWithCourseId:(NSString *)courseId andPage:(NSString *)page  completion:(void (^)(CourseEvaluateListModel*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseEvaluatelist]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              @"page" : page?page:@"",

                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CourseEvaluateListModel * truthInfo = [CourseEvaluateListModel mj_objectWithKeyValues:ret];
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

- (void)asyncAddCourseEvaluateListWithCourseId:(NSString *)courseId andContent:(NSString *)content andScore:(NSString *)score completion:(void (^)(NSString*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseEvaluate]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
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

//课程 收藏
- (void)asyncGetCourseFollowedWithCourseId:(NSString *)courseId andBool:(BOOL)follow completion:(void (^)(NSString*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",follow? [self uriCoursefollow]:[self uriCourseunfollow]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
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

//参加课程
- (void)asyncGetCourseNeedBuyWithCourseId:(NSString *)courseId andPwd:(NSString *)pwd  completion:(void (^)(CourseBuyReasultModel*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseBuy]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              @"password" : pwd?pwd:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CourseBuyReasultModel * baseModel = [CourseBuyReasultModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
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

//支付
- (void)asyncGetPaymentWithOrderId:(NSString *)orderId andType:(NSString *)type completion:(void (^)(CoursePayReasultModel*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCoursebeforepayorder]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"orderid" : orderId?orderId:@"",
                              @"type" : type?type:@"1",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CoursePayReasultModel * baseModel = [CoursePayReasultModel mj_objectWithKeyValues:ret];
            
            if ([baseModel.error_code isEqualToString:@"0"]) {
                
                if ([baseModel.type isEqualToString:@"1"]) {
                    
                    NSString *payurl =  [baseModel.payinfo mj_JSONString];
                    NSMutableString *responseString = [NSMutableString stringWithString:payurl];
                    NSString *character = nil;
                    for (int i = 0; i < responseString.length; i ++) {
                        character = [responseString substringWithRange:NSMakeRange(i, 1)];
                        if ([character isEqualToString:@"\\"])
                            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
                    }
                  
                    baseModel.aliPay = responseString;
                    
                }else{
                    baseModel.weichatPay = baseModel.payinfo ;
                }
                if (completion) {
                    completion(baseModel,nil);
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




- (void)asyncGetCourseListWithCateId:(NSString *)catesId andPage:(NSString *)page completion:(void (^)(TeacherCourseListModel*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseList]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"catid" : catesId?catesId:@"",
                              @"page" : page?page:@"",
                              
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            TeacherCourseListModel * truthInfo = [TeacherCourseListModel mj_objectWithKeyValues:ret];
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



-(void)asyncCreateNewCourseWithCourseInfo:(TeacherCreateCourseInfo *)courseInfo completion:(void (^)(CourseDetailInfoModel*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseCreate]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSString *catids = @"";
    for (UcCourseCategireChildItem *cateItem in courseInfo.courseCates) {
        if (![cateItem.childid isEqualToString:@"0"]) {
            catids = [catids stringByAppendingString: [NSString stringWithFormat:@"%@,",cateItem.childid]];
        }
    }
    if (catids.length >1) {
        catids = [catids substringWithRange:NSMakeRange(0, catids.length -1)];
    }
    
    NSString *periods = @"";
    for (CreateTimeModel *timeItem in courseInfo.courseItemsTime) {
        if (timeItem.courseTimestamp &&timeItem.courseTimestamp.length>0) {
            periods = [periods stringByAppendingString: [NSString stringWithFormat:@"%@,",timeItem.courseTimestamp]];
        }
    }
    
    if (periods.length >1) {
        periods = [periods substringWithRange:NSMakeRange(0, periods.length -1)];
    }
    
    
    NSData * upfile;
    if (courseInfo.courseCover) {
        upfile = [UIImage scaleImageToData:courseInfo.courseCover lessThanSize:PICTURE_LIMIT_SIZE_960];
    }else{
        upfile = [UIImage scaleImageToData:[UIImage imageNamed:@"sl_08_3x"] lessThanSize:PICTURE_LIMIT_SIZE_960];
    }
    
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"name" :courseInfo.courseSubject?courseInfo.courseSubject: @"",
                              @"catids" :catids,
                              @"upfile" : upfile,
                              @"type" : @"course",
                              @"desc" : courseInfo.courseIntro?courseInfo.courseIntro: @"",
                              @"price" : courseInfo.price?courseInfo.price: @"",
                              @"periods" : periods,
                              @"password" : courseInfo.password?courseInfo.password: @"",
                              };
    

    [GDHttpManager postPicInfoWithUrlStringComplate:url andImageData:upfile parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CourseDetailInfoModel * truthInfo = [CourseDetailInfoModel mj_objectWithKeyValues:ret];
            if ([truthInfo.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(truthInfo,nil);
                }
            }else{
                 [MBProgressHUD showError:truthInfo.error_desc toView:nil];
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

- (void)asyncSearchCourseWithKeyword:(NSString *)keyword andPage:(NSString *)page completion:(void (^)(TeacherCourseListModel*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseSearch]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"keyword" : keyword?keyword:@"",
                              @"page" : page?page:@"",
                              
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            TeacherCourseListModel * truthInfo = [TeacherCourseListModel mj_objectWithKeyValues:ret];
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

//直播推流
- (void)asyncStartPushCourseWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid  completion:(void (^)( CoursePushInfoModel*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseStart]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              @"periodid" : periodid?periodid:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            CoursePushInfoModel * baseModel = [CoursePushInfoModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
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

//结束推流
- (void)asyncStopPushCourseWithPeriodid:(NSString *)periodid  completion:(void (^)(NSString*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseStart]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"periodid" : periodid?periodid:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(@"OK",nil);
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
//上传推流结束
- (void)asyncUploadPushCourseWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid andSecond:(NSString *)second completion:(void (^)( NSString*ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCourseStart]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              @"periodid" : periodid?periodid:@"",
                              @"second" : second?second:@"1234",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(@"OK",nil);
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
//直播播放详情
- (void)asyncPushCourseInfoWithCourseId:(NSString *)courseId andPeriodid:(NSString *)periodid completion:(void (^)( CourseDetailInfoModel*ret, CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCoursePlayinfo]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"courseid" : courseId?courseId:@"",
                              @"periodid" : periodid?periodid:@"",
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
