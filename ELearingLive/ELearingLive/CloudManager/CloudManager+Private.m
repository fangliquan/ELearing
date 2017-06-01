//
//  CloudManager+Private.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManager+Private.h"

@implementation CloudManager(Private)

-(NSString *)uriBase {
    return [NSString stringWithFormat:@"%@", DEFAULT_SERVER_ADDRESS];
}
-(NSString*)uriAppInit{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/index/init", ret];
    
    return ret;
}

-(NSString *)uriBaseUser {
    return [NSString stringWithFormat:@"%@", [self uriBase]];
}

-(NSString *)uriPhoneLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/passport/login", ret];
    
    return ret;
}
-(NSString *)uriPhoneRegister{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/phone-register", ret];
    
    return ret;
}

-(NSString *)uriRegisterCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/send-register-code", ret];
    
    return ret;
}

//退出登录
-(NSString *)uriLogout {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/logout", ret];
    return ret;
}

//忘记密码 获取验证码
-(NSString *)uriSendForgetPwdCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/send-forget-pwd-code", ret];
    
    return ret;
}
//验证新的验证码
-(NSString *)uriCheckForgetPwdCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/check-forget-pwd-code", ret];
    
    return ret;
}
//设置新密码
-(NSString *)uriSetNewPwd{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/set-new-pwd", ret];
    
    return ret;
}

//根据用户的code设置密码
-(NSString *)uriSetPasswordByCode {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/set-pwd-by-code", ret];
    return ret;
}

//微信登陆
-(NSString *)uriWechatLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/wechat-login", ret];
    return  ret;
}

//QQ登陆
-(NSString *)uriQQLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/qq-login", ret];
    return  ret;
}

//微信bind
-(NSString *)uriWechatBindUser {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/wechat-bind-user", ret];
    return ret;
}

//QQ bind
-(NSString *)uriQQBindUser {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/qq-bind-user",ret];
    return ret;
}

-(NSString *)uriBaseProfile {
    return [NSString stringWithFormat:@"%@/api/profile", [self uriBase]];
}

//api/profile/update-avatar

-(NSString *)uriUpdateProfileAvatar{
    NSString *ret = @"";
    ret = [self uriBaseProfile];
    ret = [[NSString alloc] initWithFormat:@"%@/update-avatar", ret];
    
    return ret;
}
//api/profile/update-birthday
-(NSString *)uriUpdateProfileBirthday{
    NSString *ret = @"";
    ret = [self uriBaseProfile];
    ret = [[NSString alloc] initWithFormat:@"%@/update-birthday", ret];
    
    return ret;
}
//update-realname
-(NSString *)uriUpdateProfileRealname{
    NSString *ret = @"";
    ret = [self uriBaseProfile];
    ret = [[NSString alloc] initWithFormat:@"%@/update-realname", ret];
    
    return ret;
}
//update-gender
-(NSString *)uriUpdateProfileGender;{
    NSString *ret = @"";
    ret = [self uriBaseProfile];
    ret = [[NSString alloc] initWithFormat:@"%@/update-gender", ret];
    
    return ret;
}

-(NSString *)uriBaseActivity {
    return [NSString stringWithFormat:@"%@/api/activity", [self uriBase]];
}

//首页轮播
-(NSString *)uriGoodsActivity {
    NSString *ret = @"";
    ret = [self uriBaseActivity];
    ret = [[NSString alloc] initWithFormat:@"%@/list", ret];
    
    return ret;
}


-(NSString *)uriBaseGoods {
    return [NSString stringWithFormat:@"%@/api/goods", [self uriBase]];
}

//首页产品列表
-(NSString *)uriGoodsList {
    NSString *ret = @"";
    ret = [self uriBaseGoods];
    ret = [[NSString alloc] initWithFormat:@"%@/list", ret];
    
    return ret;
}

//产品详情
-(NSString *)uriGoodsDetail {
    NSString *ret = @"";
    ret = [self uriBaseGoods];
    ret = [[NSString alloc] initWithFormat:@"%@/detail", ret];
    
    return ret;
}

-(NSString *)uriBaseAddress {
    return [NSString stringWithFormat:@"%@/api/address", [self uriBase]];
}
//address
//api/address/create
-(NSString *)uriAddressCreate{
    NSString *ret = @"";
    ret = [self uriBaseAddress];
    ret = [[NSString alloc] initWithFormat:@"%@/create", ret];
    
    return ret;
}
//api/address/list
-(NSString *)uriAddressList{
    NSString *ret = @"";
    ret = [self uriBaseAddress];
    ret = [[NSString alloc] initWithFormat:@"%@/list", ret];
    
    return ret;
}
//api/address/edit
-(NSString *)uriAddressEdit{
    NSString *ret = @"";
    ret = [self uriBaseAddress];
    ret = [[NSString alloc] initWithFormat:@"%@/edit", ret];
    
    return ret;
}
//api/address/set-default
-(NSString *)uriAddressSetDefault{
    NSString *ret = @"";
    ret = [self uriBaseAddress];
    ret = [[NSString alloc] initWithFormat:@"%@/set-default", ret];
    
    return ret;
}

//api/address/delete
-(NSString *)uriAddressDelete {
    NSString *ret = @"";
    ret = [self uriBaseAddress];
    ret = [[NSString alloc] initWithFormat:@"%@/delete", ret];
    return ret;
}


-(NSString *)uriBaseAccount {
    return [NSString stringWithFormat:@"%@/api/account", [self uriBase]];
}
//get-coupons-list
-(NSString *)uriAccountGetCouponsList{
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/get-coupons-list", ret];
    
    return ret;
}
//api/account/get-balance
-(NSString *)uriAccountGetBalance{
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/get-balance", ret];
    
    return ret;
}
//api/account/get-cashcards-list
-(NSString *)uriAccountGetCashcardsList{
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/get-cashcards-list", ret];
    
    return ret;
}

//account/active-cashcard
-(NSString *)uriAccountActiveCashcard {
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/active-cashcard",ret];
    return ret;
}

//account/get-recharge-list
-(NSString *)uriAccountGetRechargeList {
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/get-recharge-list",ret];
    return ret;
}


-(NSString *)uriBaseOrder {
    return [NSString stringWithFormat:@"%@/api/order", [self uriBase]];
}
//api/order/list
-(NSString *)uriOrderList{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/list", ret];
    
    return ret;
}
//api/order/create
-(NSString *)uriOrderCreate{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/create", ret];
    
    return ret;
}
-(NSString *)uriOrderPreCreate{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/pre-create", ret];
    
    return ret;
}
//api/order/detail?
-(NSString *)uriOrderDetail{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/detail", ret];
    
    return ret;
}
//api/order/cancel?
-(NSString *)uriOrderCancel{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/cancel", ret];
    
    return ret;
}
//order/get-express?
-(NSString *)uriOrderGetExpress{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/get-express", ret];
    
    return ret;
}

//api/order/reminder
-(NSString *)uriOrderReminder{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/reminder", ret];
    
    return ret;
}
//api/order/balance-pay
-(NSString *)uriOrderBalancePay{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/balance-pay", ret];
    
    return ret;
}
-(NSString *)uriOrderApplyRefund{
    NSString *ret = @"";
    ret = [self uriBaseOrder];
    ret = [[NSString alloc] initWithFormat:@"%@/apply-refund", ret];
    
    return ret;
}


-(NSString *)uriBasePay {
    return [NSString stringWithFormat:@"%@/api/pay", [self uriBase]];
}

//api/pay/create-trans?
-(NSString *)uriPayCreateTran{
    NSString *ret = @"";
    ret = [self uriBasePay];
    ret = [[NSString alloc] initWithFormat:@"%@/create-trans", ret];
    
    return ret;
}
//api/pay/notify
-(NSString *)uriPayNotify{
    NSString *ret = @"";
    ret = [self uriBasePay];
    ret = [[NSString alloc] initWithFormat:@"%@/notify", ret];
    
    return ret;
}
//api/pay/return
-(NSString *)uriPayReturn{
    NSString *ret = @"";
    ret = [self uriBasePay];
    ret = [[NSString alloc] initWithFormat:@"%@/return", ret];
    
    return ret;
}

//api/pay/recharge
-(NSString *)uriPayRecharge {
  NSString *ret = @"";
    ret = @"";
    ret = [self uriBasePay];
    ret = [[NSString alloc] initWithFormat:@"%@/recharge", ret ];
    return  ret;
}


-(NSString *)uriAccoutGetCouponsList {
    NSString *ret = @"";
    ret = [self uriBaseAccount];
    ret = [[NSString alloc] initWithFormat:@"%@/get-coupons-list",ret ];
    return ret;
}

-(NSString *)uriBaseCommon {
    return [NSString stringWithFormat:@"%@/api/common",[self uriBase]];
}

//意见反馈
-(NSString *)uriCommonFeedback {
    NSString *ret = @"";
    ret = [self uriBaseCommon];
    ret = [[NSString alloc] initWithFormat:@"%@/feedback",[self uriBaseCommon]];
    return ret;
}

-(NSString *)uriBaseWxPay {
    return [NSString stringWithFormat:@"%@/api/wx-pay",[self uriBase]];
}

//wx-pay/create-trans
- (NSString *)uriWxPayCreateTrans {
    NSString *ret = @"";
    ret = [self uriBaseWxPay];
    ret = [[NSString alloc] initWithFormat:@"%@/create-trans",[self uriBaseWxPay]];
    return ret;
}

//wx-pay/recharge
- (NSString *)uriWxPayRecharge {
    NSString *ret = @"";
    ret = [self uriBaseWxPay];
    ret = [[NSString alloc] initWithFormat:@"%@/recharge",[self uriBaseWxPay]];
    return ret;
}

//wx-pay/notify
- (NSString *)uriWxPayNotify {
    NSString *ret = @"";
    ret = [self uriBaseWxPay];
    ret = [[NSString alloc] initWithFormat:@"%@/notify",[self uriBaseWxPay]];
    return ret;
}


@end
