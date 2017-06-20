//
//  AppDelegate+Weibo.m
//  iOSUI
//
//  Created by zhaoyun on 8/18/14.
//  Copyright (c) 2014 ainemo. All rights reserved.
//

#import "AppDelegate+Weibo.h"
#import "WawaShareUtil.h"

@implementation AppDelegate (Weibo)

-(void)initWeibo
{
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:WEIBO_APPID];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
     NSLog(@"in Weibo onReq");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *string = nil;
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess)
        {
            string = @"分享成功";
            [WawaShareUtil shareResultCallback];
        }
        else if(response.statusCode == WeiboSDKResponseStatusCodeUserCancel)
        {
            string = @"取消分享";
        }
        else
        {
            string = @"分享失败";
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess)
        {
            string = NSLocalizedString(@"授权成功", nil);
        }
        else
        {
            string = NSLocalizedString(@"授权失败", nil);
        }
    }
    [MBProgressHUD showMessage:string toView:nil];
}

@end
