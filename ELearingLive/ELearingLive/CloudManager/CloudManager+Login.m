//
//  CloudManger+Login.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//


#import "CloudManager+Login.h"
#import "CMError.h"
#import "GCDMulticastDelegate.h"
#import "PublicUtil.h"
#import <UMSocialCore/UMSocialCore.h>
@implementation CloudManager (Login)

#pragma mark - api

-(void) _operationsAfterLogin
{
    _isLogined = YES;
    
//    [self bindGeTuiAlias];
//    
//    //set userId to Bugly's CrashReporter
//    [Bugly setUserIdentifier:_currentAccount.userProfile.account];
//    [self initQupaiSdkWithUserId];
}

-(void) _updatePersist:(UserLoginResponse *)loginRe
{
    DBManager *dbm = [DBManager sharedInstance];
    
    [dbm saveSyncDataLoginResultInfoWithUserLoginReslut:loginRe];
    _currentAccount = [dbm loadAccountInfo];//must reload from db again!!!
}

-(void) loginOutCurentUser
{
    DBManager *dbm = [DBManager sharedInstance];
    
    [dbm loginOutClearUserData];
    [[CloudManager sharedInstance].getDelegate didUpdateUserInfoWithUserInfoResponse:nil];
    _currentAccount = [dbm loadAccountInfo];
}


//init
- (void)asyncCurrrentDeviceInit:(void (^)(VersionInfo *ret,CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriAppInit]];
    NSString *time = [NSString stringWithFormat:@"%f", [DateHelper timeIntervalNow]];
    NSString *token = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString * moreinfo = [PublicUtil getDeviceMoreInfo];
    DLog(@"-----------init token%@",token);
   // NSString *sign = [WWTextManager md5:[NSString stringWithFormat:@"%@-%@-%@",password,time,DEFAULT_APP_KEY]];
    NSDictionary *tempDic = @{
                              @"token" : token,
                              @"pushid" : token,
                              @"time" : time,
                              @"version" : @"1.0",
                              @"os" : @"ios",
                              @"model":moreinfo
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            VersionInfo * initResponse = [VersionInfo mj_objectWithKeyValues:retDict];
            if ([initResponse.error_code isEqualToString:@"0"]) {
                 [[DBManager sharedInstance]cleanTableData:[VersionInfo class]];
                 [[DBManager sharedInstance]saveData:initResponse];
             }
            DLog(@"--------------------init Dict: %@",ret);
            if (completion){
                completion(initResponse,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
    
}
- (void)asyncUserLoginWithPhoneNumberAndCode:(NSString *)phoneNumber code:(NSString *)code completion:(void (^)(UserLoginResponse *ret, CMError * error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriPhoneLogin]];
   // NSString *pwd = [WWTextManager md5:password];
    VersionInfo *versionInfo = [[DBManager sharedInstance]loadTableFirstData:[VersionInfo class] Condition:@""];
    NSString *token = versionInfo.token?versionInfo.token: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *time = [NSString stringWithFormat:@"%f", [DateHelper timeIntervalNow]];
    NSLog(@"-----------login token%@",token);
    NSString *sign = [WWTextManager md5:[NSString stringWithFormat:@"%@-%@-%@",code,time,DEFAULT_APP_KEY]];
    NSDictionary *tempDic = @{
                              @"token" : token,
                              @"mobile" : phoneNumber,
                              @"code" : code,
                              @"sign" : sign,
                              @"time" : time,
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:retDict];
            if ([userLoginResponse.error_code isEqualToString:@"0"]) {
                userLoginResponse.token = token;
                userLoginResponse.phone = phoneNumber;
                [self _operationsAfterLogin];
                if (userLoginResponse) {
                    [self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                if (completion) {
                    completion(userLoginResponse,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
       
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
    
}

//umeng 微信登录
-(void)asyncWeichatLoginWithUMInfo:(UMSocialUserInfoResponse *)userInfoRespons andType:(NSString *)type  completion:(void (^)(UserLoginResponse *ret, CMError * error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriPassportLogin]];
    // NSString *pwd = [WWTextManager md5:password];
    VersionInfo *versionInfo = [[DBManager sharedInstance]loadTableFirstData:[VersionInfo class] Condition:@""];
    NSString *token = versionInfo.token?versionInfo.token: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *cityStr = @"";
    
    NSDictionary *tempDic = @{
                              @"token" : token,
                              @"type" : type,
                              @"openid" : userInfoRespons.openid?userInfoRespons.openid:@"",
                              @"unionid" : userInfoRespons.unionId?userInfoRespons.unionId:@"",
                              @"accesstoken" : userInfoRespons.accessToken?userInfoRespons.accessToken:@"",
                              
                              @"refreshtoken" : userInfoRespons.refreshToken?userInfoRespons.refreshToken:@"",
                              @"expiration" : userInfoRespons.expiration?userInfoRespons.expiration:@"",
                              @"name" : userInfoRespons.name?userInfoRespons.name:@"",
                              @"city" : @"",
                              @"prvinice" : @"",
                              @"country" : @"",
                              @"gender" : userInfoRespons.gender?userInfoRespons.gender:@"",
                              @"iconurl" : userInfoRespons.iconurl?userInfoRespons.iconurl:@"",
                    
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:retDict];
            if ([userLoginResponse.error_code isEqualToString:@"0"]) {
                userLoginResponse.token = token;
                [self _operationsAfterLogin];
                if (userLoginResponse) {
                    [self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                if (completion) {
                    completion(userLoginResponse,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];

    
}

//绑定手机号
- (void)asyncUserBindPhoneWithCode:(NSString *)phoneNumber code:(NSString *)code completion:(void (^)(NSString *ret, CMError * error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriUcBindMobile]];
    // NSString *pwd = [WWTextManager md5:password];
    VersionInfo *versionInfo = [[DBManager sharedInstance]loadTableFirstData:[VersionInfo class] Condition:@""];
    NSString *token = versionInfo.token?versionInfo.token: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *time = [NSString stringWithFormat:@"%f", [DateHelper timeIntervalNow]];
    NSLog(@"-----------login token%@",token);
    NSString *sign = [WWTextManager md5:[NSString stringWithFormat:@"%@-%@-%@",code,time,DEFAULT_APP_KEY]];
    NSDictionary *tempDic = @{
                              @"token" : token,
                              @"mobile" : phoneNumber,
                              @"code" : code,
                              @"sign" : sign,
                              @"time" : time,
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

- (void)asyncUserFeedBackWithContent:(NSString *)content completion:(void (^)(NSString *ret, CMError * error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriAppFeedback]];
    // NSString *pwd = [WWTextManager md5:password];
    NSString *token = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              @"content" : content?content:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *message;
            if ([[ret allKeys]containsObject:@"message"]) {
                message = [ret objectForKey:@"message"];
            }
            if (completion) {
                completion(message,error);
            }
      
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}


//-(void) _updatePersist:(UserLoginResponse *)loginRe
//{
//    DBManager *dbm = [DBManager sharedInstance];
//
//    [dbm saveSyncDataLoginResultInfoWithUserLoginReslut:loginRe];
//    _currentAccount = [dbm loadAccountInfo];//must reload from db again!!!
//}
//
//-(void) loginOutCurentUser
//{
//    DBManager *dbm = [DBManager sharedInstance];
//    
//    [dbm loginOutClearUserData];
//    [[CloudManager sharedInstance].getDelegate didUpdateUserInfoWithUserInfoResponse:nil];
//    _currentAccount = [dbm loadAccountInfo];
//}

- (void)asyncUserSendCodeWithPhoneNumber:(NSString *)phoneNumber  completion:(void (^)(NSString *ret, CMError * error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriRegisterCode]];
    NSDictionary *tempDic = @{@"phone" : phoneNumber,};
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *reasult = @"NO";
            if ([[ret allKeys]containsObject:@"status"]) {
                int status = [[ret objectForKey:@"status"]intValue];
                reasult = status ==200?@"YES":@"NO";
            }
            if (completion) {
                completion(reasult,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];

}


- (void)asyncUserRegisterWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password code:(NSString *)code completion:(void (^)(UserLoginResponse *ret, CMError * error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriPhoneRegister]];
    NSString *pwd = [WWTextManager md5:password];
    if(phoneNumber == nil) {
        phoneNumber = @"";
    }
    if (code == nil) {
        code = @"";
    }
    if (password == nil) {
        password = @"";
    }
    NSDictionary *tempDic = @{@"phone" : phoneNumber,
                              @"password" : pwd,
                              @"code" : code,
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"data"]) {
                NSObject *dataModel = [retDict objectForKey:@"data"];
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:dataModel];
            }
            if (completion) {
                completion(userLoginResponse,error);
//                if (userLoginResponse) {
//                    [self _updatePersist:userLoginResponse];
//                }
//                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
    

}
//修改密码获取验证码 api/user/send-forget-pwd-code
- (void)asyncUserSendForgetPwdCodeWithPhoneNumber:(NSString *)phoneNumber  completion:(void (^)(NSString *ret, CMError * error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriSendForgetPwdCode]];
    NSDictionary *tempDic = @{@"phone" : phoneNumber,};
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *reasult = @"NO";
            if ([[ret allKeys]containsObject:@"status"]) {
                int status = [[ret objectForKey:@"status"]intValue];
                reasult = status ==200?@"YES":@"NO";
            }
            if (completion) {
                completion(reasult,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

//检验密码和Code api/user/check-forget-pwd-code
- (void)asyncUserCheckForgetPwdCodeWithPhoneNumber:(NSString *)phoneNumber  code:(NSString *)code completion:(void (^)(NSString *ret, CMError * error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriCheckForgetPwdCode]];
    NSDictionary *tempDic = @{@"phone" : phoneNumber,@"code" : code,};
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *reasult = @"NO";
            if ([[ret allKeys]containsObject:@"status"]) {
                int status = [[ret objectForKey:@"status"]intValue];
                reasult = status ==200?@"YES":@"NO";
            }
            if (completion) {
                completion(reasult,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}
//set-new-pwd
//设置新密码
- (void)asyncUserSetNewPwd:(NSString *)pwd oldPwd:(NSString *)oldPwd  completion:(void (^)(NSString *ret, CMError * error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriSetNewPwd]];
    NSString *oldPwdMD5 = [WWTextManager md5:oldPwd];
    NSString *newPwd = [WWTextManager md5:pwd];
    NSDictionary *tempDic = @{@"password" : oldPwdMD5,@"newPassword" : newPwd,};
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *reasult = @"NO";
            if ([[ret allKeys]containsObject:@"status"]) {
                int status = [[ret objectForKey:@"status"]intValue];
                reasult = status ==200?@"YES":@"NO";
            }
            if (completion) {
                completion(reasult,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];

}

//根据用户的code设置密码
- (void)asyncUserSetPasswordByCode:(NSString *)phoneNumber code:(NSString *)code password:(NSString *)password completion:(void (^)( NSString *ret, CMError *error))completion {
    NSString *url = [NSString stringWithFormat:@"%@", [self uriSetPasswordByCode]];
    NSString *pwd = [WWTextManager md5:password];
    if (phoneNumber == nil || code == nil || password == nil) {
        return;
    }
    NSDictionary *tempDic = @{@"phone" : phoneNumber,@"code" : code, @"password" : pwd,};
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSString *reasult = @"NO";
            if ([[ret allKeys]containsObject:@"status"]) {
                int status = [[ret objectForKey:@"status"]intValue];
                reasult = status ==200?@"YES":@"NO";
            }
            if (completion) {
                completion(reasult,error);
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];

}


//退出登录
- (void)asyncUserLogout:(void (^)(NSString *ret,CMError *error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriLogout]];
    NSString *token = [CloudManager sharedInstance].currentAccount.userLoginResponse.token;
    NSDictionary *tempDic = @{
                              @"token" : token,
                              };

    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            if ([[ret allKeys]containsObject:@"error_code"]) {
                NSString *error_code = [ret objectForKey:@"error_code"];
                if ([error_code isEqualToString:@"0"]) {
                    [self loginOutCurentUser];
                    if (completion) {
                        completion(@"YES",error);
                    }
                }
            }
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

//微信登陆
- (void)asyncWechatLogin:(NSString *)openId accessToken:(NSString *)accessToken completion:(void (^)(UserLoginResponse *ret,CMError *error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriWechatLogin]];
    if (accessToken == nil || openId == nil) {
        return;
    }
    NSDictionary *tempDic = @{@"openId" : openId,@"accessToken" : accessToken,};
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"data"]) {
                NSObject *dataModel = [retDict objectForKey:@"data"];
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:dataModel];
            }
            if (completion) {
                completion(userLoginResponse,error);
                if (userLoginResponse) {
                    //[self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
            }
            
        }else {
            if(completion) {
                completion(nil,error);
            }
        }
    }];
}

//QQ登陆
- (void)asyncQQLogin:(NSString *)openId accessToken:(NSString *)accessToken completion:(void (^)(UserLoginResponse *ret,CMError *error))completion {
    NSString *url = [NSString stringWithFormat:@"%@",[self uriQQLogin]];
    if (accessToken == nil || openId == nil) {
        return;
    }
    NSDictionary *tempDic = @{@"openId" : openId,@"accessToken" : accessToken,};

    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"data"]) {
                NSObject *dataModel = [retDict objectForKey:@"data"];
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:dataModel];
            }
            if (completion) {
                completion(userLoginResponse,error);
                if (userLoginResponse) {
                    //[self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
            }
            
        }else {
            if(completion) {
                completion(nil,error);
            }
        }
    }];
}

//微信绑定手机
- (void)asyncBindWechatUser:(NSString *)openId accessToken:(NSString *)accessToken phone:(NSString *)phone password:(NSString *)password completion:(void (^)(UserLoginResponse *ret,CMError *error))completion {
    NSString *uri = [NSString stringWithFormat:@"%@",[self uriWechatBindUser]];
    if(accessToken == nil || openId == nil || phone == nil || password == nil) {
        return;
    }
    NSString *pwd = [WWTextManager md5:password];
    NSDictionary *tempDic = @{@"openId" : openId,@"accessToken" : accessToken,@"phone":phone, @"password":pwd};
    [GDHttpManager postWithUrlStringComplate:uri parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"data"]) {
                NSObject *dataModel = [retDict objectForKey:@"data"];
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:dataModel];
            }
            if (completion) {
                completion(userLoginResponse,error);
                if (userLoginResponse) {
                   // [self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
            }

        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

//QQ绑定手机
- (void)asyncBindQQUser:(NSString *)openId accessToken:(NSString *)accessToken phone:(NSString *)phone password:(NSString *)password completion:(void (^)(UserLoginResponse *ret,CMError *error))completion {
    NSString *uri = [NSString stringWithFormat:@"%@",[self uriQQBindUser]];
    if(accessToken == nil || openId == nil || phone == nil || password == nil) {
        return;
    }
    NSString *pwd = [WWTextManager md5:password];
    NSDictionary *tempDic = @{@"openId" : openId,@"accessToken" : accessToken,@"phone":phone, @"password":pwd};
    [GDHttpManager postWithUrlStringComplate:uri parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"data"]) {
                NSObject *dataModel = [retDict objectForKey:@"data"];
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:dataModel];
            }
            if (completion) {
                completion(userLoginResponse,error);
                if (userLoginResponse) {
                    //[self _updatePersist:userLoginResponse];
                }
                
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

@end
