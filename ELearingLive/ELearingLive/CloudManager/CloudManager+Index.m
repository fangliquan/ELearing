//
//  CloudManger+Login.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//


#import "CloudManager+Index.h"
#import "CMError.h"
#import "GCDMulticastDelegate.h"
#import "PublicUtil.h"
@implementation CloudManager (Index)


- (void)asyncGetHomeIndexData:(void (^)(HomeIndex *ret, CMError *error))completion{
    NSString *url = [NSString stringWithFormat:@"%@",[self uriHomeIndex]];
    VersionInfo *versionInfo = [[DBManager sharedInstance]loadTableFirstData:[VersionInfo class] Condition:@""];
    NSString *token = versionInfo.token?versionInfo.token: [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary *tempDic = @{
                              @"token" : token?token:@"",
                              };
    
    [GDHttpManager postWithUrlStringComplate:url parameters:tempDic completion:^(NSDictionary *ret, CMError *error) {
        if (ret) {
            HomeIndex * baseModel = [HomeIndex mj_objectWithKeyValues:ret];
            if ([baseModel.error_code isEqualToString:@"0"]) {
                if (completion) {
                    completion(baseModel,nil);
                }
            }else{
                if (completion) {
                    completion(nil,error);
                }
            }
            
        }else {
            if (completion) {
                completion(nil,error);
            }
        }
    }];
}

@end
