//
//  WechatPayManager.m
//  
//
//  Created by pc on 15/10/19.
//  Copyright © 2015年 fo. All rights reserved.
//

#import "WechatPayManager.h"
#import "MJExtension.h"
#import "WXApi.h"
#import "WXApiObject.h"

#pragma mark- WechatpayOrder
@implementation WechatpayOrder

@end

#pragma mark- WechatAuthorizationResp
@implementation WechatAuthorizationResp

@end

#pragma mark- WechatUserInfo
@implementation WechatUserInfo

@end

#pragma mark- WechatPayManager
@interface WechatPayManager() {
    WechatpayOrder * _payOrder;
    WechatPayResultHandler _payCallBack;    // 支付
    WechatAuthorizationResultHandler _authorizationCallBack;    // 授权
}

@end

@implementation WechatPayManager

+ (WechatPayManager *)sharedManager {
    static WechatPayManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultNotif:) name:kWECHATRESULTKEY object:nil];
}

#pragma mark- 微信支付 API

+ (void)wechatPaymentWithInfo:(NSDictionary *)payInfo result:(WechatPayResultHandler)result {
    [[WechatPayManager sharedManager] wechatPaymentWithInfo:payInfo result:result];
}

- (void)wechatPaymentWithInfo:(NSDictionary *)payInfo result:(WechatPayResultHandler)result {
    BOOL wXAppInstalled =  [WXApi isWXAppInstalled];
    if (wXAppInstalled) {
        
        BOOL wXAppSupport = [WXApi isWXAppSupportApi];
        if (wXAppSupport) {
            _payCallBack = result;
            
            _payOrder = [WechatpayOrder mj_objectWithKeyValues:payInfo[@"content"]];
            
            PayReq * req    = [[PayReq alloc] init];
            req.openID      = WEIXIN_APPID;//_payOrder.appId;
            req.partnerId   = _payOrder.partnerid;
            req.prepayId    = _payOrder.prepayid;
            req.nonceStr    = _payOrder.noncestr;
            req.timeStamp   = _payOrder.timestamp;
            req.package     = _payOrder.package;
            req.sign        = _payOrder.sign;
            
            [WXApi sendReq:req];
            [self addObserver];
        } else {
            [UIAlertView bk_alertViewWithTitle:@"提醒" message:@"您当前微信版本不支持，请更新微信！"];
        }
       
    } else {
        [UIAlertView bk_alertViewWithTitle:@"提醒" message:@"您没有安装微信，请选择其他付款方式！"];
    }
}

#pragma mark- 微信授权登录 API

+ (void)wechatAuthorizationOfResult:(WechatAuthorizationResultHandler)result {
    [[WechatPayManager sharedManager] wechatAuthorizationOfResult:result];
}

- (void)wechatAuthorizationOfResult:(WechatAuthorizationResultHandler)result {
    _authorizationCallBack = result;
    
    BOOL wXAppInstalled =  [WXApi isWXAppInstalled];
    SendAuthReq * req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"";
    req.openID = WEIXIN_APPID;
    if (wXAppInstalled) {
        [WXApi sendReq:req];
        [self addObserver];
    } else {
        [self notInstalledPrompt];
    }
}

- (void)notInstalledPrompt {
     [UIAlertView bk_alertViewWithTitle:@"提醒" message:@"本设备未安装微信客户端, 请使用帐号密码登录"];

}

#pragma mark- 微信支付、授权回调结果处理
- (void)resultNotif:(NSNotification *)notif {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSObject * resultObj = notif.object;
    
    if ([resultObj isKindOfClass:[PayResp class]]) {
        [self wechatPaymentResult:(PayResp *)resultObj];
    } else if ([resultObj isKindOfClass:[SendAuthResp class]]) {
        [self wechatAuthorizationResult:(SendAuthResp *)resultObj];
    }
}

- (void)wechatPaymentResult:(PayResp *)payResp {
    NSString * result = @"";
    BOOL paySucceed = NO;
    
    if (payResp.errCode == WXSuccess) {
        result = @"succeed";
        paySucceed = YES;
    } else {
        result = @"failed";
        paySucceed = NO;
    }
    
    NSString * url = [NSString stringWithFormat:@"%@%@?result=%@&orderNumber=%@", DEFAULT_SERVER_ADDRESS, _payOrder.returnUrl, result, _payOrder.tradeNumber];
    DLog(@"WechatResultURL: %@", url);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    _payCallBack(request, paySucceed);
}

- (void)wechatAuthorizationResult:(SendAuthResp *)authResp {
    
    NSString * account = nil;
    NSString * openId = nil;
    BOOL succeed = NO;
    if (authResp.errCode == 0) {    // 用户授权同意
        openId = authResp.code;
        succeed = YES;
        _authorizationCallBack(account, openId, succeed);
        
        /*  微信授权获取用户信息调整为 server 端获取
        NSString * urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WEIXIN_APPID, WEIXIN_APPSECRET, authResp.code];
        int respCode = 0;
        NSDictionary * retDict = [HttpUtil httpsGet:urlString headers:nil parameter:nil responseCode:&respCode];
        
        WechatAuthorizationResp * authorizationResp = [WechatAuthorizationResp mj_objectWithKeyValues:retDict];
        
        NSLog(@"%@  %@", retDict, authorizationResp);
        
        NSString * infoString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", authorizationResp.access_token, authorizationResp.openid];
        respCode = 0;
        NSDictionary * infoDict = [HttpUtil httpsGet:infoString headers:nil parameter:nil responseCode:&respCode];
        
        if (respCode == 40003) {
            NSLog(@"无效的 openId");
        } else {
        
            WechatUserInfo * userInfo = [WechatUserInfo mj_objectWithKeyValues:infoDict];
        
            NSLog(@"%@  %@", infoDict, userInfo);
        
            account = userInfo.nickname;
            openId = authorizationResp.openid;
            succeed = YES;
        }
         */
    } else {
        _authorizationCallBack(account, openId, succeed);
    }
}

#pragma mark- 检测是否安装了微信 并且支持 OpenApi
+ (BOOL)isWechatAppSupportApi {
    return ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]);
}


@end
