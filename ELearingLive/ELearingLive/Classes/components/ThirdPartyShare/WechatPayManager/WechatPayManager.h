//
//  WechatPayManager.h
//  
//
//  Created by pc on 15/10/19.
//  Copyright © 2015年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWECHATRESULTKEY @"WechatResult" // 微信支付回调注册通知的 key

#pragma mark- WechatpayOrder
@interface WechatpayOrder : NSObject

/*********** PayReq 需要的参数 ************/
@property (nonatomic, copy) NSString * appid;
@property (nonatomic, copy) NSString * mch_id;
@property (nonatomic, copy) NSString * prepay_id;
@property (nonatomic, copy) NSString * nonce_str;
@property (nonatomic, copy) NSString * package_name;
@property (nonatomic, copy) NSString * sign;
@property (nonatomic, assign) UInt32 time;

/*********** 支付结果回调 需要的参数 ************/
@property (nonatomic, copy) NSString * tradeNumber;
@property (nonatomic, copy) NSString * returnUrl;

@end

#pragma mark- WechatAuthorizationResp
@interface WechatAuthorizationResp : NSObject

@property (nonatomic, copy) NSString * access_token;    // 接口调用凭证
@property (nonatomic, copy) NSString * refresh_token;   // 用户刷新access_token
@property (nonatomic, copy) NSString * openid;          // 授权用户唯一标识
@property (nonatomic, copy) NSString * scope;           // 用户授权的作用域，使用逗号（,）分隔
@property (nonatomic, copy) NSString * unionid;         // 当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
@property (nonatomic, assign) long expires_in;          // access_token接口调用凭证超时时间，单位（秒）

@end

#pragma mark- WechatUserInfo
@interface WechatUserInfo : NSObject

@property (nonatomic, copy) NSString * openid;      // 普通用户的标识，对当前开发者帐号唯一
@property (nonatomic, copy) NSString * nickname;    // 普通用户昵称
@property (nonatomic, copy) NSString * province;    // 普通用户个人资料填写的省份
@property (nonatomic, copy) NSString * city;        // 普通用户个人资料填写的城市
@property (nonatomic, copy) NSString * country;     // 国家，如中国为CN
@property (nonatomic, copy) NSString * headimgurl;  // 用户头像，最后一个数值代表正方形头像大小
                                                    //（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
@property (nonatomic, strong) NSArray * privilege;  // 用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
@property (nonatomic, copy) NSString * unionid;     // 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
@property (nonatomic, assign) int sex;              // 普通用户性别，1为男性，2为女性

@end


#pragma mark- WechatPayManager
typedef void (^WechatPayResultHandler)(NSURLRequest * request, BOOL succeed);
typedef void (^WechatAuthorizationResultHandler)(NSString * account, NSString * openId, BOOL succeed);


@interface WechatPayManager : NSObject

/**
 *  微信支付 API
 *
 *  @param payInfo PayReq 所需要的参数
 *  @param result  WechatPayResultHandler (支付结果, 返回 webView 的 load request 和 支付是否成功 bool 值)
 */
+ (void)wechatPaymentWithInfo:(NSDictionary *)payInfo result:(WechatPayResultHandler)result;
/**
 *  微信授权登录 API
 *
 *  @param result   WechatAuthorizationResultHandler (授权结果, 是否成功 bool 值)
 */
+ (void)wechatAuthorizationOfResult:(WechatAuthorizationResultHandler)result;
/**
 *  当前设备是否安装了微信  并且支持 OpenApi
 */
+ (BOOL)isWechatAppSupportApi;

@end
