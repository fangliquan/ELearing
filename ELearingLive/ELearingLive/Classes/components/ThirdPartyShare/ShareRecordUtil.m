//
//  ShareRecordUtil.m
//  
//
//  Created by xiaobin on 19/9/14.
//  Copyright (c) 2014 fo. All rights reserved.
//

#import "ShareRecordUtil.h"

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>


//#import "customHintView.h"

@implementation ShareRecordUtil

+(void)shareUrl:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image byType:(ShareType)type{
    title = title.length>200?[title substringToIndex:200]:title;
    description = description.length>500?[description substringToIndex:500]:description;
    switch (type) {
        case Tencent_weixin_friend:
            [ShareRecordUtil shareUrlToWeixin:url withTitle:title andDescription:description andThumbImage:image andIsMoment:NO];
            break;
        case Tencent_weixin_monent:
            [ShareRecordUtil shareUrlToWeixin:url withTitle:title andDescription:description andThumbImage:image andIsMoment:YES];
            break;
        case Sina_weibo:
            [ShareRecordUtil shareUrlToWeibo:url withTitle:title andDescription:description andThumbImage:image];
            break;
        case Tencent_qq_friend:
             [ShareRecordUtil shareUrlToTencentSendQQ:url withTitle:title andDescription:description andThumbImage:image];
            break;
        case Tencent_qq_QZone:
            [ShareRecordUtil shareUrlToTencentSendQzone:url withTitle:title andDescription:description andThumbImage:image];
            break;
        default:
            break;
    }
}

+(void)shareUrlToWeixin:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image andIsMoment:(BOOL)isMoment{
    if (!image) {
        image=[UIImage imageNamed:@"icon_share_default"];
    }
    NSData *imageData = [UIImage scaleImageToData:image lessThanSize:(int)PICTURE_LIMIT_SIZE_160];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbData:imageData];
        
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = isMoment ? WXSceneTimeline : WXSceneSession;
        
    BOOL ret = [WXApi sendReq:req];
    if(!ret){
        dispatch_async(dispatch_get_main_queue(), ^(void){
             [MBProgressHUD showMessage:@"分享失败" toView:nil];
             //[customHintView showHintConfirmAddTo:nil Title:nil Detail:];
        } );
    }
}

+(void)shareUrlToWeibo:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image{

    if (!image) {
        image=[UIImage imageNamed:@"icon_share_default"];
    }
    NSData *imageData = [UIImage scaleImageToData:image lessThanSize:(int)PICTURE_LIMIT_SIZE_160];
    
    WBMessageObject *message = [WBMessageObject message];
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = url;
    webpage.title = title;
    webpage.description = description;
    webpage.thumbnailData = imageData;
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    
    BOOL ret = [WeiboSDK sendRequest:request];
    if (!ret)
    {
        dispatch_async(dispatch_get_main_queue(), ^(void){
           [MBProgressHUD showMessage:@"分享失败" toView:nil];
        } );
    }

}


+(void)shareText:(NSString *)text byType:(ShareType)type{

    if (type == Tencent_weixin_friend || type == Tencent_weixin_monent) {
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = text;
        req.bText = YES;
        req.scene = type == Tencent_weixin_friend ? WXSceneSession : WXSceneTimeline;
        
        [WXApi sendReq:req];
        
        [WXApi sendReq:req];

        
    }else if (type == Sina_weibo){
        
        WBMessageObject *message = [WBMessageObject message];
        message.text = text;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        
        BOOL ret = [WeiboSDK sendRequest:request];
        if (!ret)
        {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [MBProgressHUD showMessage:@"分享失败" toView:nil];
            } );
        }
    }else if (type==Tencent_qq_friend){
        QQApiTextObject *qat=[QQApiTextObject objectWithText:text];
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:qat];
        
        QQApiSendResultCode sendResult = [QQApiInterface sendReq:req];
        if (sendResult==EQQAPISENDFAILD)
        {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [MBProgressHUD showMessage:@"分享失败" toView:nil];
            } );
        }

    }else if(type==Tencent_qq_QZone){
        QQApiTextObject *qat=[QQApiTextObject objectWithText:text];
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:qat];
        QQApiSendResultCode sendResult = [QQApiInterface SendReqToQZone:req];
        if (sendResult==EQQAPISENDFAILD)
        {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [MBProgressHUD showMessage:@"分享失败" toView:nil];
            } );
        }
    }
    
}

+(void)shareUrlToTencentSendQQ:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image{
    if (!image) {
        image=[UIImage imageNamed:@"icon_share_default"];
    }
    NSData *imageData = [UIImage scaleImageToData:image lessThanSize:(int)PICTURE_LIMIT_SIZE_160];

    NSURL* urlSend = [NSURL URLWithString:url];
    QQApiNewsObject* news = [QQApiNewsObject objectWithURL:urlSend title:title description:description previewImageData:imageData];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:news];
    
    QQApiSendResultCode sendResult = [QQApiInterface sendReq:req];
    if (sendResult==EQQAPISENDFAILD)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [MBProgressHUD showMessage:@"分享失败" toView:nil];
        } );
    }
    
}
+(void)shareUrlToTencentSendQzone:(NSString *)url withTitle:(NSString *)title andDescription:(NSString *)description andThumbImage:(UIImage *)image{
    if (!image) {
        image=[UIImage imageNamed:@"icon_share_default"];
    }
    NSData *imageData = [UIImage scaleImageToData:image lessThanSize:(int)PICTURE_LIMIT_SIZE_160];
    
    NSURL* urlSend = [NSURL URLWithString:url];
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:urlSend title:title description:description previewImageData:imageData];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sendResult = [QQApiInterface SendReqToQZone:req];
    if (sendResult==EQQAPISENDFAILD)
    {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [MBProgressHUD showMessage:@"分享失败" toView:nil];
        } );
    }
    
}





@end
