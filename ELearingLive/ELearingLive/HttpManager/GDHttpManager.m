//
//  GDHttpManager.m
//  GDMall
//
//  Created by 陆存璐 on 16/10/6.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "GDHttpManager.h"
#import "AFNetworking.h"

#import "NSDictionary+JSONExtensions.h"
//#import "CloudManager+Login.h"

@implementation GDHttpManager

//GET请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //get请求
    NSLog(@"Get: %@", urlString);

    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"Error: %@", error);
    }];
    
}

/*
 * 返回状态码：
 * # 200-299 request success
 * 200 => '成功'
 * # 300-399 request warning
 * 300 => ''
 * 302 => '登录设备发生变化'
 * # 400-499 request error from Client
 * 400 => '参数有误'
 * 401 => '缺少请求参数'
 * 402 => '参数格式有误'
 * 403 => '参数值为空'
 * 404 => '您所查看的内容已经删除或不存在'
 * # 420-429 when API_DEBUG equals to true
 * 420 => '{{param}}参数有误'
 * 421 => '缺少{{param}}参数'
 * 422 => '{{param}}参数格式有误'
 * 423 => '参数{{param}}值不能为空'
 * # 490-499 特殊类型错误代码
 * 490 => '登陆会话已过期'
 * 491 => '您的帐号已经在另外一台设备登陆'
 * # 500-599 server error(under control not Exception.)
 * 500 => '服务器异常,请稍候再试'
 * 501 => '服务器错误,请稍候再试'
 * <p>
 * -1 客户端自己处理错误
 */
//非200—299以外的status，服务端的message提示出来


//POST请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [manager.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:sysVersion forHTTPHeaderField:@"sysVersion"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sysType"];
    [manager.requestSerializer setValue:deviceid forHTTPHeaderField:@"deviceId"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];

    //post请求
    NSLog(@"Post: %@", urlString);

    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *ret = nil;
         NSError *error = nil;
       
        @try {
            if (responseObject) {
                ret = [NSDictionary dictionaryWithJSONData:responseObject error:&error];
            }
            if (ret) {
                ret = JSONObjectByRemovingKeysWithNullValues(ret, NSJSONReadingMutableContainers);
            }
        }
        @catch (NSException *exception) {
            NSLog(@"catch exception when processing response data , exception:%@", exception);
        }
        if(error || !ret) {
            NSLog(@"convert to json data failed while processing response data, error:%@", error);
            NSString *responseString = [responseObject responseString];
            if (responseString) {
                NSLog(@"response message:%@", responseString);
                ret = @{@"message":responseString};
            }
        }
        if (responseObject && !ret) {
            ret = (NSDictionary*)responseObject;
        }
        
         success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"Error: %@", error);
    }];
}

+(void)postWithUrlStringComplate:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void (^)(NSDictionary *, CMError *))completion{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    [manager.requestSerializer setValue:[infoDictionary objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:sysVersion forHTTPHeaderField:@"sysVersion"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sysType"];
    [manager.requestSerializer setValue:deviceid forHTTPHeaderField:@"deviceId"];
    [manager.requestSerializer setValue:deviceid forHTTPHeaderField:@"token"];
    
    //post请求
    NSLog(@"Post: %@", urlString);

    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *key in parameters) {
            NSString *value = [NSString stringWithFormat:@"%@",parameters[key]];
            NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:data name:key];
        }

    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *josnStr =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@",josnStr);
        NSDictionary *ret = nil;
        NSError *error = nil;
        
        @try {
            if (responseObject) {
                ret = [NSDictionary dictionaryWithJSONData:responseObject error:&error];
            }
            //            if (ret) {
            //                ret = JSONObjectByRemovingKeysWithNullValues(ret, NSJSONReadingMutableContainers);
            //            }
        }
        
        @catch (NSException *exception) {
            NSLog(@"catch exception when processing response data , exception:%@", exception);
        }
        if(error || !ret) {
            NSLog(@"convert to json data failed while processing response data, error:%@", error);
            NSString *responseString = (NSString *)responseObject;
            if (responseString) {
                NSLog(@"response url:%@", responseString);
                ret = @{@"value":responseString};
            }
        }
        if (responseObject && !ret) {
            ret = (NSDictionary*)responseObject;
        }
        NSInteger status = 0;
        if ([[ret allKeys]containsObject:@"status"]) {
            status = [[ret objectForKey:@"status"] integerValue];
            //删除保存信息，重新登录
            if (status == 302 || status == 490 || status == 491) {
                //[[CloudManager sharedInstance] loginOutCurentUser];
            }
        }
        NSString *message = @"";
        if ([[ret allKeys]containsObject:@"message"]) {
            message = [ret objectForKey:@"message"];
        }
        CMError *cMError = [CMError errorWithHttpStatus:0 serviceStatus:status andErrorInfo:[NSString stringWithFormat:@"%@",message]];
        completion(ret,cMError);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        CMError *cMError = [CMError errorWithHttpStatus:0 serviceStatus:0 andErrorInfo:[NSString stringWithFormat:@"%@",error]];
        completion(nil,cMError);
        NSLog(@"Error: %@", error);
    }];

}

static id JSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:JSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = [(NSDictionary *)JSONObject objectForKey:key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                [mutableDictionary setObject:JSONObjectByRemovingKeysWithNullValues(value, readingOptions) forKey:key];
            }
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    
    return JSONObject;
}


@end
