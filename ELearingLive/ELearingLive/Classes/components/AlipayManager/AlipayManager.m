//
//  AlipayManager.m
//  
//
//  Created by James on 15/5/13.
//  Copyright (c) 2015年 WangChongyang. All rights reserved.
//

#import "AlipayManager.h"
#import "MJExtension.h"
#import "JSONKit.h"

#pragma AlixPayOrder
@implementation AlixPayOrder

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"productDescription" : @"body" , @"productName" : @"subject" , @"amount" : @"price" , @"tradeNO" : @"tradeNumber" , @"notifyURL" : @"notifyUrl"};
}

@end

#pragma AlixPayResult
@implementation AlixPayResult

@end

#pragma APAuthV2Info
@implementation APAuthV2Info

- (NSString *)description {
    if (self.appID.length != 16 || self.pid.length != 16) {
        return nil;
    }
    
    // NOTE: 增加不变部分数据
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    [tmpDict addEntriesFromDictionary:@{@"app_id" : _appID,
                                        @"pid" : _pid,
                                        @"apiname" : @"com.alipay.account.auth",
                                        @"method" : @"alipay.open.auth.sdk.code.get",
                                        @"app_name" : @"mc",
                                        @"biz_type" : @"openservice",
                                        @"product_id" : @"APP_FAST_LOGIN",
                                        @"scope" : @"kuaijie",//@"auth_userinfo",
                                        @"target_id" : (_targetID ? _targetID : @"kkkkk091125"),
                                        @"auth_type" : (_authType ? _authType : @"AUTHACCOUNT")}];
    
    // NOTE: 排序，得出最终请求字串
    NSArray* sortedKeyArray = [[tmpDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (NSString* key in sortedKeyArray) {
        NSString* orderItem = [self itemWithKey:key andValue:[tmpDict objectForKey:key]];
        if (orderItem.length > 0) {
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)itemWithKey:(NSString*)key andValue:(NSString*)value {
    if (key.length > 0 && value.length > 0) {
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

@end

#pragma AlipayManager
@interface AlipayManager() {
    AlipayResultHandler _callBack;
    AlixPayOrder *_order;
    AlipayAuthorizationResultHandler _authorizationCallBackHanlder;
}

@end

@implementation AlipayManager

+ (AlipayManager *)sharedManager {
    static AlipayManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc]init];
    });
    return manager;
}

#pragma mark- 支付
- (void)paymentWithInfo:(NSString *)payInfo result:(AlipayResultHandler)result {
    
    _callBack = [result copy];
//    NSString *contentStr = [payInfo valueForKey:@"content"];//支付Order对象
//    NSString *orderJsonStr = [payInfo valueForKey:@"order"];//新版本阿里支付 server加密好的url
    _order = [AlixPayOrder mj_objectWithKeyValues:payInfo];

    NSString *appScheme = @"elive";
    
    if (payInfo) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay:"];

        if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            //如果没有安装支付宝
            [UIAlertView bk_alertViewWithTitle:@"提示" message:@"请安装支付宝"];
        }
        NSURL *url = [NSURL URLWithString:payInfo];
        [[AlipaySDK defaultService] payOrder:url.absoluteString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

            if (_callBack) {
                _callBack([self requestFromResultDic:resultDic], [self succeedWithDic:resultDic]);
            }
        }];
    }
}


+ (void)paymentWithInfo:(NSString *)payInfo result:(AlipayResultHandler)result {
    [[AlipayManager sharedManager] paymentWithInfo:payInfo result:result];
}
//支付成功处理
- (NSURLRequest *)requestFromResultDic:(NSDictionary *)resultDic {
    
    DLog(@"reslut = %@",resultDic);
    
    AlixPayResult *result = [AlixPayResult mj_objectWithKeyValues:resultDic];
    
    if (result.resultStatus == 9000) {
        result.statusMessage = @"succeed";
    }else {
        result.statusMessage = @"failed";
    }
    
    NSString *url = @"";// [NSString stringWithFormat:@"%@%@?result=%@&orderNumber=%@&sessionKey=%@",BASE_URL.absoluteString,_order.returnUrl,result.statusMessage,_order.tradeNO,[CloudManager sharedInstance].currentAccount.loginInfo.sessionKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    return request;
}

- (BOOL)succeedWithDic:(NSDictionary *)resultDic {
    AlixPayResult *result = [AlixPayResult mj_objectWithKeyValues:resultDic];
    
    if (result.resultStatus == 9000) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    return [[AlipayManager sharedManager] handleOpenURL:url];
}

- (BOOL)handleOpenURL:(NSURL *)url {
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        if (_callBack) {
            _callBack([self requestFromResultDic:resultDic], [self succeedWithDic:resultDic]);
        }
    }];
    
    /**
     *  授权跳转支付宝钱包进行支付，处理支付结果 (当 APP 被 kill 的时候调用)
     */
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        
        NSString * result = resultDic[@"result"];
        NSString * authCode = nil;
        if (result.length>0) {
            NSArray * resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString * subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {   // 授权成功
            if (authCode.length) {
                _authorizationCallBackHanlder(nil, authCode, YES);
            }
        }
    }];
    
    return YES;
}




#pragma mark- 登录授权
//绑定支付宝钱包
+ (void)paymentAuthorizationWithInfo:(NSString *)info result:(AlipayAuthorizationResultHandler)result {
    [[AlipayManager sharedManager] paymentAuthorizationWithInfo:info result:result];
}

- (void)paymentAuthorizationWithInfo:(NSString *)info result:(AlipayAuthorizationResultHandler)result {
    _authorizationCallBackHanlder = result;
    
    NSString * appScheme = @"elive";
    
    NSString * authInfoString = [NSString stringWithFormat:@"%@&sign_type=%@", info, @"RSA"];
    
    if (authInfoString.length) {
        
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoString
                                         fromScheme:appScheme
                                           callback:^(NSDictionary * resultDic) {
                                               NSLog(@"result = %@", resultDic);
                                               // 解析 auth code
                                               NSString * result = resultDic[@"result"];
                                               NSString * authCode = nil;
                                               if (result.length>0) {
                                                   NSArray * resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString * subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {   // 授权成功
                                                   if (authCode.length) {
                                                       _authorizationCallBackHanlder(nil, authCode, YES);
                                                   }
                                               }
                                           }];
    }
}


@end
