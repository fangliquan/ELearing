//
//  WWPermissionManager.h
//  wwface
//
//  Created by leo on 2016/12/20.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWPermissionManager : NSObject



+(BOOL)hasPermissionForPhotoGallery;

+(BOOL)hasPermissionForCapture;

+(BOOL)hasPermissionForRecord;

+(BOOL)hasPermissionForLocation;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

+ (BOOL)isAllowedNotification;
+(BOOL)isCanUsePhotos;
@end
