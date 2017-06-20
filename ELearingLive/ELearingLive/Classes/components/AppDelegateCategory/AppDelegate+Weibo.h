//
//  AppDelegate+Weibo.h
//  iOSUI
//
//  Created by zhaoyun on 8/18/14.
//  Copyright (c) 2014 ainemo. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"

@interface AppDelegate (Weibo) <WeiboSDKDelegate>

-(void)initWeibo;

@end
