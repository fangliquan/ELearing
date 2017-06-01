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
@implementation CloudManager (Login)


//init
- (void)asyncCurrrentDeviceInit:(void (^)(NSString *ret,CMError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriAppInit]];
    NSString *time = [NSString stringWithFormat:@"%f", [DateHelper timeIntervalNow]];
    NSString *token = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString * moreinfo = [PublicUtil getDeviceMoreInfo];
    NSLog(@"-----------init token%@",token);
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
            VersionInfo * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"reasult"]) {
                userLoginResponse = [VersionInfo mj_objectWithKeyValues:retDict];
            }
            if (completion) {
                completion(@"OK",error);
                //[_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
            }
        }else{
            if (completion) {
                completion(nil,error);
            }
        }
    }];
    
}
- (void)asyncUserLoginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completion:(void (^)(UserLoginResponse *ret, CMError * error))completion{
    
    NSString *url = [NSString stringWithFormat:@"%@",[self uriPhoneLogin]];
   // NSString *pwd = [WWTextManager md5:password];
    NSString *token = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *time = [NSString stringWithFormat:@"%f", [DateHelper timeIntervalNow]];
    NSLog(@"-----------login token%@",token);
    NSString *sign = [WWTextManager md5:[NSString stringWithFormat:@"%@-%@-%@",password,time,DEFAULT_APP_KEY]];
    NSDictionary *tempDic = @{
                              @"token" : token,
                              @"mobile" : phoneNumber,
                              @"code" : password,
                              @"sign" : sign,
                              @"time" : time,
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            NSDictionary *retDict =ret;
            UserLoginResponse * userLoginResponse =nil;
            if ([[retDict allKeys]containsObject:@"userid"]) {
                userLoginResponse = [UserLoginResponse mj_objectWithKeyValues:retDict];
            }
            if (completion) {
                completion(userLoginResponse,error);
                if (userLoginResponse) {
                   // [self _updatePersist:userLoginResponse];
                }
              
                [_delegates didUpdateUserInfoWithUserInfoResponse:userLoginResponse];
                
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
    [GDHttpManager postWithUrlStringComplate:url parameters:nil completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            [self loginOutCurentUser];
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
