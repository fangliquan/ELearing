//
//  AppDelegate+OpenURL.m
//  
//
//  Created by pc on 16/10/27.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "AppDelegate+OpenURL.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "AlipayManager.h"

@implementation AppDelegate (OpenURL)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation delegate:(id)delegate {
    
    if ([url.absoluteString rangeOfString:WEIXIN_APPID].location == 0) {
        return  [WXApi handleOpenURL:url delegate:delegate];
    } else if ([url.absoluteString rangeOfString:WEIBO_APPKEY].location == 0) {
        return [WeiboSDK handleOpenURL:url delegate:delegate];
    } else if ([url.host isEqualToString:@"safepay"]) {
        return [AlipayManager handleOpenURL:url];
    } else if ([url.absoluteString rangeOfString:TENCENT_APPID].location != NSNotFound) {
        return [QQApiInterface handleOpenURL:url delegate:delegate];
    }
    else if ([url.absoluteString rangeOfString:@"xxxxx"].location == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:url.absoluteString];
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url delegate:(id)delegate {
    if ([url.absoluteString rangeOfString:TENCENT_APPID].location==0){
        return [QQApiInterface handleOpenURL:url delegate:delegate];
    }else if ([url.host isEqualToString:@"safepay"]) {
        return [AlipayManager handleOpenURL:url];
    }
    return NO;
}



@end
