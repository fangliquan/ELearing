//
//  AlipayManager.h
//  
//
//  Created by James on 15/5/13.
//  Copyright (c) 2015年 WangChongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

#pragma mark- 支付订单
@interface AlixPayOrder : NSObject

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;

@property(nonatomic, copy) NSString * returnUrl;

@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, copy) NSString * unSign;
@property(nonatomic, copy) NSString * sign;

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@end

#pragma mark- 支付结构
@interface AlixPayResult : NSObject

@property(nonatomic, assign) NSInteger resultStatus;
@property(nonatomic, copy) NSString *result;
@property(nonatomic, copy) NSString *memo;
@property(nonatomic, copy) NSString *statusMessage;

@end

#pragma mark- 授权Model
@interface APAuthV2Info : NSObject

/*********************************授权必传参数*********************************/
@property (nonatomic, copy) NSString * apiname;     // 服务接口名称，常量com.alipay.account.auth。
@property (nonatomic, copy) NSString * appName;     // 调用方app标识 ，mc代表外部商户。
@property (nonatomic, copy) NSString * bizType;     // 调用业务类型，openservice代表开放基础服务
@property (nonatomic, copy) NSString * productID;   // 产品码，目前只有WAP_FAST_LOGIN
@property (nonatomic, copy) NSString * appID;       // 签约平台内的appid
@property (nonatomic, copy) NSString * pid;         // 商户签约id
@property (nonatomic, copy) NSString * authType;    // 授权类型,AUTHACCOUNT:授权;LOGIN:登录
@property (nonatomic, copy) NSString * targetID;    // 商户请求id需要为unique,回调使用
/*********************************授权可选参数*********************************/
@property (nonatomic, copy) NSString * scope;       // oauth里的授权范围，PD配置,默认为kuaijie
@property (nonatomic, copy) NSString * method;      // 固定值，alipay.open.auth.sdk.code.get

@end

typedef void (^AlipayResultHandler) (NSURLRequest *request, BOOL succeed);
typedef void (^AlipayAuthorizationResultHandler)(NSString * account, NSString * openId, BOOL succeed);


@interface AlipayManager : NSObject

+ (void)paymentWithInfo:(NSDictionary *)payInfo result:(AlipayResultHandler)result;
+ (BOOL)handleOpenURL:(NSURL *)url;
/**
 *  支付宝授权登录 API
 *  @param info     授权信息字符串
 *  @param result   AlipayAuthorizationResultHandler (授权结果, 是否成功 bool 值)
 */
+ (void)paymentAuthorizationWithInfo:(NSString *)info result:(AlipayAuthorizationResultHandler)result;

//+ (void)paymentQuestionAnswerWithInfo:(NSDictionary *)payInfo result:(AlipayResultQuestionAnswerHandler)result;

@end
