//
//  CloudManager+Private.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"

@interface CloudManager(Private)


-(NSString *)uriBase;
-(NSString *)uriAppInit;
//反馈
-(NSString *)uriAppFeedback;
-(NSString *)uriPhoneLogin;
-(NSString *)uriPhoneRegister;
-(NSString *)uriRegisterCode;
//微信登陆
-(NSString *)uriWechatLogin;
//QQ登陆
-(NSString *)uriQQLogin;
//微信bind
-(NSString *)uriWechatBindUser;
//QQ bind
-(NSString *)uriQQBindUser;

//退出登录
-(NSString *)uriLogout;

//忘记密码 获取验证码
-(NSString *)uriSendForgetPwdCode;
//验证新的验证码
-(NSString *)uriCheckForgetPwdCode;
//设置新密码
-(NSString *)uriSetNewPwd;

//根据用户的code设置密码
-(NSString *)uriSetPasswordByCode;

//api/profile/update-avatar

-(NSString *)uriUpdateProfileAvatar;
//api/profile/update-birthday
-(NSString *)uriUpdateProfileBirthday;
//update-realname
-(NSString *)uriUpdateProfileRealname;
//update-gender
-(NSString *)uriUpdateProfileGender;

//首页轮播
-(NSString *)uriGoodsActivity;
//首页产品列表
-(NSString *)uriGoodsList;
//产品详情
-(NSString *)uriGoodsDetail;

//address
//api/address/create
-(NSString *)uriAddressCreate;
//api/address/list
-(NSString *)uriAddressList;
//api/address/edit
-(NSString *)uriAddressEdit;
//api/address/set-default
-(NSString *)uriAddressSetDefault;
//api/address/delete
-(NSString *)uriAddressDelete;

//account
//api/account/get-coupons-list
-(NSString *)uriAccountGetCouponsList;
//api/account/get-balance
-(NSString *)uriAccountGetBalance;
//api/account/get-cashcards-list
-(NSString *)uriAccountGetCashcardsList;
//account/active-cashcard
-(NSString *)uriAccountActiveCashcard;
//account/get-recharge-list
-(NSString *)uriAccountGetRechargeList;


//order
//api/order/list
-(NSString *)uriOrderList;
//api/order/create
-(NSString *)uriOrderCreate;

//api/order/pre-create
-(NSString *)uriOrderPreCreate;
//api/order/detail?
-(NSString *)uriOrderDetail;
//api/order/cancel?
-(NSString *)uriOrderCancel;
//order/get-express?
-(NSString *)uriOrderGetExpress;
//api/order/balance-pay
-(NSString *)uriOrderBalancePay;
//}api/order/apply-refund?
-(NSString *)uriOrderApplyRefund;
//api/pay/create-trans?
-(NSString *)uriPayCreateTran;
//api/pay/notify
-(NSString *)uriPayNotify;
//api/pay/return
-(NSString *)uriPayReturn;
//api/pay/recharge
-(NSString *)uriPayRecharge;
//order/reminder?
-(NSString *)uriOrderReminder;

//优惠券列表
-(NSString *)uriAccoutGetCouponsList;

//意见反馈
- (NSString *)uriCommonFeedback;

//wx-pay/create-trans
- (NSString *)uriWxPayCreateTrans;
//wx-pay/recharge
- (NSString *)uriWxPayRecharge;
//wx-pay/notify
- (NSString *)uriWxPayNotify;




@end
