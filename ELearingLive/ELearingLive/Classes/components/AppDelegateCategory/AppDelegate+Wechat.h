//
//  AppDelegate+Wechat.h
//  iOSUI
//
//  Created by zhaoyun on 8/13/14.
//  Copyright (c) 2014 ainemo. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>

@interface AppDelegate (Wechat) <WXApiDelegate, QQApiInterfaceDelegate>

-(void)initWechat;
-(void)initTencent;

@end
