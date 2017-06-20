//
//  AppDelegate+OpenURL.h
//  
//
//  Created by pc on 16/10/27.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (OpenURL)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation delegate:(id)delegate;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url delegate:(id)delegate;

@end
