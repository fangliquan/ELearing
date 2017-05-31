//
//  GDHttpManager.h
//  GDMall
//
//  Created by 陆存璐 on 16/10/6.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import <Foundation/Foundation.h>

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

@interface GDHttpManager : NSObject

//get请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;


//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;
//post请求
+(void)postWithUrlStringComplate:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void (^)(NSDictionary *ret, CMError * error))completion ;

@end
