//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"

@class UserLoginResponse,VersionInfo;
@interface CloudManager (Login)

//init
- (void)asyncCurrrentDeviceInit:(void (^)(VersionInfo *ret,CMError *error))completion;


- (void)asyncUserLoginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completion:(void (^)(UserLoginResponse *ret, CMError * error))completion ;


- (void)asyncUserFeedBackWithContent:(NSString *)content completion:(void (^)(NSString *ret, CMError * error))completion ;
//注册


//注册
- (void)asyncUserRegisterWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password code:(NSString *)code completion:(void (^)(UserLoginResponse *ret, CMError * error))completion ;
//获取验证码
- (void)asyncUserSendCodeWithPhoneNumber:(NSString *)phoneNumber  completion:(void (^)(NSString *ret, CMError * error))completion ;


//修改密码获取验证码 api/user/send-forget-pwd-code
- (void)asyncUserSendForgetPwdCodeWithPhoneNumber:(NSString *)phoneNumber  completion:(void (^)(NSString *ret, CMError * error))completion;

//检验密码和Code api/user/check-forget-pwd-code
- (void)asyncUserCheckForgetPwdCodeWithPhoneNumber:(NSString *)phoneNumber  code:(NSString *)code completion:(void (^)(NSString *ret, CMError * error))completion;
//set-new-pwd
//设置新密码
- (void)asyncUserSetNewPwd:(NSString *)pwd oldPwd:(NSString *)oldPwd  completion:(void (^)(NSString *ret, CMError * error))completion;

//根据用户的code设置密码
- (void)asyncUserSetPasswordByCode:(NSString *)phoneNumber code:(NSString *)code password:(NSString *)password completion:(void (^)(NSString *ret, CMError *error))completion;


//退出登录
- (void)asyncUserLogout:(void (^)(NSString *ret,CMError *error))completion;


- (void) loginOutCurentUser;

//微信登陆
- (void)asyncWechatLogin:(NSString *)openId accessToken:(NSString *)accessToken completion:(void (^)(UserLoginResponse *ret,CMError *error))completion;

//QQ登陆
- (void)asyncQQLogin:(NSString *)openId accessToken:(NSString *)accessToken completion:(void (^)(UserLoginResponse *ret,CMError *error))completion;

//微信绑定手机
- (void)asyncBindWechatUser:(NSString *)openId accessToken:(NSString *)accessToken phone:(NSString *)phone password:(NSString *)password completion:(void (^)(UserLoginResponse *ret,CMError *error))completion;

//QQ绑定手机
- (void)asyncBindQQUser:(NSString *)openId accessToken:(NSString *)accessToken phone:(NSString *)phone password:(NSString *)password completion:(void (^)(UserLoginResponse *ret,CMError *error))completion;


@end
