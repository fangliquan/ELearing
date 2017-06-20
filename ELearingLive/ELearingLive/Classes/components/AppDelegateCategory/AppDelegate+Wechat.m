//
//  AppDelegate+Wechat.m
//  iOSUI
//
//  Created by zhaoyun on 8/13/14.
//  Copyright (c) 2014 ainemo. All rights reserved.
//

#import "AppDelegate+Wechat.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WechatPayManager.h"
#import "WawaShareUtil.h"

@implementation AppDelegate (Wechat)

-(void)initTencent
{
    TencentOAuth *tencent= [[TencentOAuth alloc]initWithAppId:TENCENT_APPID andDelegate:nil];
    DLog(@"qq ----------------- verson:%@ \naccessToken%@", [TencentOAuth sdkVersion], tencent.accessToken);
    

}

-(void)initWechat
{
    [WXApi registerApp:WEIXIN_APPID];
}

- (void) onReq:(id)req
{
    if ([req isKindOfClass:[BaseReq class]])
    {
        NSLog(@"in WXApi onReq");
    }
    else if ([req isKindOfClass:[QQBaseReq class]])
    {
        NSLog(@"in QQApi onReq");
    }
}

- (void) onResp:(id)resp
{
    /******************** 微信回调 ************************/
    if ([resp isKindOfClass:[BaseResp class]])
    {
        /******************** 微信支付回调 ************************/
        if ([resp isKindOfClass:[PayResp class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWECHATRESULTKEY object:(PayResp *)resp];
        }
        /******************** 微信授权回调 ************************/
        if ([resp isKindOfClass:[SendAuthResp class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWECHATRESULTKEY object:(SendAuthResp *)resp];
        }
        /******************** 微信分享回调 ************************/
        if ([resp isKindOfClass:[SendMessageToWXResp class]])
        {
            SendMessageToWXResp * newReq = (SendMessageToWXResp *)resp;
            
            if (newReq.errCode == WXSuccess)
            {
                [WawaShareUtil shareResultCallback];
                [MBProgressHUD showMessage:@"分享成功" toView:nil];
            }
            else if(newReq.errCode == WXErrCodeUserCancel)
            {
                [MBProgressHUD showMessage:@"取消分享" toView:nil];
            }
            else
            {
                [MBProgressHUD showMessage:@"分享失败" toView:nil];
            }
           // [[NSNotificationCenter defaultCenter] postNotificationName:kReadSharePrompt_shareResult object:[NSNumber numberWithInt:newReq.errCode]];
        }
    }
    /******************** QQ回调 ************************/
    else if ([resp isKindOfClass:[QQBaseResp class]])
    {
        QQBaseResp * newBaseResp = (QQBaseResp *)resp;
        
        /******************** QQ分享回调 ************************/
        if ([newBaseResp isKindOfClass:[SendMessageToQQResp class]]) {
            SendMessageToQQResp * sendMsgToQQResp = (SendMessageToQQResp *)newBaseResp;
            if ([sendMsgToQQResp.result integerValue] == 0) {
                [WawaShareUtil shareResultCallback];
                [MBProgressHUD showMessage:@"分享成功" toView:nil];
            } else {
                [MBProgressHUD showMessage:@"分享失败" toView:nil];
            }
        }
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}

@end
