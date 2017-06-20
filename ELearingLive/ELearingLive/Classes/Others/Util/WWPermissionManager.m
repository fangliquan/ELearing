//
//  WWPermissionManager.m
//  
//
//  Created by leo on 2016/12/20.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WWPermissionManager.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@implementation WWPermissionManager


+(BOOL)hasPermissionForPhotoGallery{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    NSString *message = nil;

    message = @"请在系统的“设置->隐私->照片”中允许“直播”访问您的相册。";

    
    if (author == ALAuthorizationStatusDenied) {
        [WWPermissionManager showAlertWithTitle:nil message:message];
        return NO;
    }
    return YES;
}

+(BOOL)hasPermissionForCapture{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    NSString *message = nil;

    message = @"请在系统的“设置->隐私->相机”中允许“直播”访问您的相机。";
    if (authStatus == AVAuthorizationStatusDenied) {
        [WWPermissionManager showAlertWithTitle:nil message:message];
        return NO;
    }
    return YES;
    
}

+(BOOL)hasPermissionForRecord {
    
    __block BOOL ret = YES;
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (!granted) {
            
            ret = NO;
            
            NSString *message = nil;
            message = @"请在系统的“设置->隐私->麦克风”中允许“直播”访问您的麦克风。";

            [WWPermissionManager showAlertWithTitle:nil message:message];
        }
    }];
    
    return ret;
}


+(BOOL)hasPermissionForLocation{
   if (![CLLocationManager locationServicesEnabled]){
       NSString *message = nil;
       NSString *title = nil;
       message = @"“定位服务”未开启，您将无法正常使用“附近”的功能。请到“设置->隐私->定位服务”中打开，并允许“直播”确定您的位置。";
       title = @"打开“定位服务”，允许“直播”确定您的位置";

       [UIAlertView bk_showAlertViewWithTitle:@"打开“定位服务”，允许“直播”确定您的位置" message:message style:UIAlertViewStyleDefault cancelButtonTitle:@"我知道了" otherButtonTitles:@[[[[UIDevice currentDevice] systemVersion] floatValue] >=10.0?nil: @"去设置" ] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
           if (buttonIndex == 1) {
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
           }
       }];

        return NO;
    }
    return YES;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
//    [PXAlertView showAlertWithTitle:title message:message cancelTitle:@"我知道了"  otherTitle:[[[UIDevice currentDevice] systemVersion] floatValue] >=10.0?nil: @"去设置" completion:^(BOOL cancelled, NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            NSString *appIdentifer = APP_IDENTIFIER;
//#ifdef RELEASE_TEACHER
//            appIdentifer = [appIdentifer stringByAppendingString:@"teacher"];
//#endif
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appIdentifer]];
//        }
//    }];
}


+ (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}



+(BOOL)isCanUsePhotos{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}

@end
