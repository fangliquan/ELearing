//
//  ShareRecordUtil.h
//  
//
//  Created by xiaobin on 19/9/14.
//  Copyright (c) 2014 fo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareTypeDef.h"

@interface ShareRecordUtil : NSObject

+(void)shareUrl:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image byType:(ShareType)type;
+(void)shareUrlToWeixin:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image andIsMoment:(BOOL)isMoment;
+(void)shareUrlToWeibo:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image;

+(void)shareUrlToTencentSendQQ:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image;

+(void)shareUrlToTencentSendQzone:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image;

+(void)shareText:(NSString *)text byType:(ShareType)type;

@end
