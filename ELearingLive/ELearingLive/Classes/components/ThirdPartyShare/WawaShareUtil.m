//
//  WawaShareUtil.m
//  
//
//  Created by pc on 16/6/17.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WawaShareUtil.h"
#import "HYActivityView.h"


@implementation WawaShareModel

+ (WawaShareModel *)getShareModelWithType:(WawaShareType)shareType shareKeyId:(long long)keyId shareTitle:(NSString *)title shareContent:(NSString *)content shareImgUrl:(NSString *)imgUrl fromViewController:(UIViewController *)vc
{
    WawaShareModel * model = [[WawaShareModel alloc] init];
    model.shareType = shareType;
    model.shareTitle = title;
    model.shareContent = content;
    model.shareImgUrl = imgUrl;
    model.fromVC = vc;
    model.shareKeyId = keyId;
    model.contentId = keyId;
    return model;
}

+ (WawaShareModel *)getShareModelWithType:(WawaShareType)shareType shareUrl:(NSString *)shareUrl shareTitle:(NSString *)title shareContent:(NSString *)content shareImgUrl:(NSString *)imgUrl fromViewController:(UIViewController *)vc{
    WawaShareModel * model = [[WawaShareModel alloc] init];
    model.shareType = shareType;
    model.shareTitle = title;
    model.shareContent = content;
    model.shareImgUrl = imgUrl;
    model.fromVC = vc;
    model.shareKey = shareUrl;
    return model;
}

@end

@interface WawaShareUtil ()

@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareContent;
@property (nonatomic, assign) WawaShareResultCallbackStyle shareResultCallbackStyle;

@end

@implementation WawaShareUtil {
    WawaShareModel * _shareModel;
}

+ (WawaShareUtil *)sharedManager
{
    static WawaShareUtil * shareView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[WawaShareUtil alloc] init];
    });
    return shareView;
}

+ (void)shareWithShareModel:(WawaShareModel *)model
{
    WawaShareUtil * shareUtil = [WawaShareUtil sharedManager];
    MTATrackCustomEventType mtaEvent = MTATrackCustomEvent_NULL;
    switch (model.shareType) {
        case WawaShareType_BabyShow:
            [shareUtil babyShowWithShareModel:model];
            break;
        case WawaShareType_BabyShowDetail:
            mtaEvent = MTATrackCustomEvent_BabyShowDetail;
            [shareUtil babyShowDetailWithShareModel:model];
            break;
        case WawaShareType_Topic:
            [shareUtil topicWithShareModel:model];
            break;
        case WawaShareType_TopicDetail:
            [shareUtil topicDetailWithShareModel:model];
            break;
        case WawaShareType_KinderArchive:
            [shareUtil kinderArchiveWithShareModel:model];
            break;
        case WawaShareType_PictureBook:
            [shareUtil pictureBookWithShareModel:model];
            break;
        case WawaShareType_ClassNotice:
            [shareUtil classNoticeWithShareModel:model];
            break;
        case WawaShareType_ClassAlbum:
            [shareUtil classAlbumWithShareModel:model];
            break;
     
        case WawaShareType_MyWebVCShare:
            [shareUtil mywebVCShareWithShareModel:model];
            break;
        case WawaShareType_ReadInvite:
            [shareUtil readInviteShareWithShareModel:model];
            break;
        case WawaShareType_Song:
            [shareUtil songShareWithShareModel:model];
            break;
        case WawaShareType_HealthValue:
            [shareUtil healthValueShareWithShareModel:model];
            break;
        case WawaShareType_VIPPictureBook:
            [shareUtil vipPictureBookShareWithShareModel:model];
            break;
        case WawaShareType_LiveCast:
            [shareUtil liveCastShareWithShareModel:model];
            break;
        case WawaShareType_ReadPlayDetail:
            [shareUtil readPlayDetailShareWithShareModel:model];
            break;
       
        default:
            break;
    }
}

#pragma mark- util type operate

- (void)babyShowWithShareModel:(WawaShareModel *)model
{
//    [[CloudManager sharedInstance] asyncRequestSharePublicKey:(long)model.shareKeyId completion:^(NSString *shareKey) {
//        if (shareKey) {
//            
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = shareKey;
//            model.shareFromType = ShareType_BabyShow;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)babyShowDetailWithShareModel:(WawaShareModel *)model
{
    NSString * shareKey = @"";//[[CloudManager sharedInstance] requestSharePublicKey:(long)model.shareKeyId];
    if (shareKey) {
        
        if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
            if (model.showReportButton) {
                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report)];
                if (model.auditable) {
                    model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report), @(Type_Circle)];
                }
            } else {
                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
                if (model.auditable) {
                    model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report), @(Type_Circle)];
                }
            }
        } else {
            if (model.showReportButton) {
                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report)];
            } else {
                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
            }
        }
        model.shareKey = shareKey;
       // model.shareFromType = ShareType_BabyShow;
        //[self shareWithShareModel:model];
    }
}

- (void)topicWithShareModel:(WawaShareModel *)model
{
//    [[CloudManager sharedInstance] asyncGetTopicPostSharePublicKey:(long)model.shareKeyId completion:^(NSString *shareUrl, CMError *error) {
//        if (shareUrl) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = shareUrl;
//            model.shareFromType = ShareType_TopicPost;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)topicDetailWithShareModel:(WawaShareModel *)model
{
//    [[CloudManager sharedInstance] asyncGetTopicPostSharePublicKey:(long)model.shareKeyId completion:^(NSString *shareUrl, CMError *error) {
//        if (shareUrl) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                if (model.showReportButton) {
//                    model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report)];
//                    if (model.auditable) {
//                        model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report), @(Type_Circle)];
//                    }
//                } else {
//                    model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//                    if (model.auditable) {
//                        model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report), @(Type_Circle)];
//                    }
//                }
//            } else {
//                if (model.showReportButton) {
//                    model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo), @(Type_Report)];
//                } else {
//                    model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//                }
//            }
//            model.shareKey = shareUrl;
//            model.shareFromType = ShareType_TopicPost;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)kinderArchiveWithShareModel:(WawaShareModel *)model
{
//    NSString * shareKey = [[CloudManager sharedInstance] asyncRequestSchoolArchivesShareKeyWithSchoolId:(long)model.shareKeyId];
//    if (shareKey) {
//        if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//            model.showShareModule = @[@(App_inside_forward),@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        } else {
//            model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        }
//        model.shareKey = shareKey;
//        [self shareWithShareModel:model];
//    }
}

- (void)pictureBookWithShareModel:(WawaShareModel *)model
{
//    [[CloudManager sharedInstance] requestPictrueBookSharePublicKey:(long)model.shareKeyId completion:^(NSString *shareKey) {
//        if (shareKey) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = shareKey;
//            model.shareFromType = ShareType_PictureBoook;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)classNoticeWithShareModel:(WawaShareModel *)model
{
//    NSString * shareKey = [[CloudManager sharedInstance] requestShareClassMoment:(long)model.shareKeyId];
//    if (shareKey) {
//        if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//            model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        } else {
//            model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        }
//        model.shareKey = shareKey;
//        model.shareFromType = ShareType_ClassAnnouncements;
//        [self shareWithShareModel:model];
//    }
}

- (void)classAlbumWithShareModel:(WawaShareModel *)model
{
//    NSString * shareKey = [[CloudManager sharedInstance] requestShareClassMoment:(long)model.shareKeyId];
//    if (shareKey) {
//        if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//            model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        } else {
//            model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//        }
//        model.shareKey = shareKey;
//        model.shareFromType = ShareType_ClassPicture;
//        [self shareWithShareModel:model];
//    }
}

- (void)mywebVCShareWithShareModel:(WawaShareModel *)model
{
    if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
        model.showShareModule = model.showClassShare ?
        @[@(Type_Refresh), @(Type_CopyURL), @(Type_OpenSafari), @(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)]
        :
        @[@(Type_Refresh), @(Type_CopyURL), @(Type_OpenSafari), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
    } else {
        model.showShareModule = model.showClassShare ?
        @[@(Type_Refresh), @(Type_CopyURL), @(Type_OpenSafari), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)]
        :
        @[@(Type_Refresh), @(Type_CopyURL), @(Type_OpenSafari), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
    }
   //model.shareFromType = ShareType_OtherAction;
    //[self shareWithShareModel:model];
}

- (void)readInviteShareWithShareModel:(WawaShareModel *)model
{
    model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent)];
   // [self shareWithShareModel:model];
}

- (void)songShareWithShareModel:(WawaShareModel *)model
{
//    [SharedRecordResource shareSongWithSongId:model.shareKeyId loadingView:nil completion:^(bool succeed, NSString *ret) {
//        if (succeed) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = ret;
//            model.shareFromType = ShareType_Song;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)healthValueShareWithShareModel:(WawaShareModel *)model
{
//    [SharedRecordResource shareClassIdWithClassId:model.shareKeyId loadingView:nil completion:^(bool succeed, GenSharedRecordDTO *ret) {
//        if (succeed) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = ret.sharedKey;
//            model.shareTitle = ret.title;
//            model.shareContent = ret.desp;
//            model.shareImgUrl = ret.picture;
//            model.shareFromType = ShareType_OtherAction;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)vipPictureBookShareWithShareModel:(WawaShareModel *)model
{
//    [SharedRecordResource shareChildVipWithChildId:model.shareKeyId loadingView:nil completion:^(bool succeed, NSString *ret) {
//        if (succeed) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = ret;
//            model.shareFromType = ShareType_OtherAction;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)liveCastShareWithShareModel:(WawaShareModel *)model
{
    model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
   // model.shareFromType = ShareType_OtherAction;
    //[self shareWithShareModel:model];

}

- (void)readPlayDetailShareWithShareModel:(WawaShareModel *)model {
//    [HedoneReadResourceImpl doGetReadSharedKeyWithType:model.type dataId:model.shareKeyId loadingView:nil completion:^(bool succeed, NSString *ret) {
//        if (succeed) {
//            if ([CloudManager sharedInstance].currentAccount.loginInfo.isLogined) {
//                model.showShareModule = @[@(App_inside_forward), @(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            } else {
//                model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Tencent_qq_friend), @(Tencent_qq_QZone), @(Sina_weibo)];
//            }
//            model.shareKey = ret;
//            model.shareFromType = ShareType_OtherAction;
//            [self shareWithShareModel:model];
//        }
//    }];
}

- (void)readPlayDetail_ReadLock_ShareWithShareModel:(WawaShareModel *)model {
//    [HedoneReadResourceImpl doGetReadSharedKeyWithType:model.type dataId:model.shareKeyId loadingView:nil completion:^(bool succeed, NSString *ret) {
//        if (succeed) {
//            model.shareKey = ret;
//            [self shareWithShareType:Tencent_weixin_monent shareModel:model];
//        }
//    }];
}


- (void)inviteShareWithShareModel:(WawaShareModel *)model {
    model.showShareModule = @[@(Tencent_weixin_friend), @(Tencent_weixin_monent), @(Sina_weibo), @(Tencent_qq_friend), @(Tencent_qq_QZone)];
    model.shareKey = @"http://www.wawachina.cn";
    //[self shareWithShareModel:model];
}

#pragma mark- start UI

- (void)shareWithShareModel:(WawaShareModel *)model
{
    NSString * title = @"";
    int numberOfButtonPerLine = 0;
    if (model.shareType == WawaShareType_MyWebVCShare) {
        title = @"操作";
        numberOfButtonPerLine = 3;
    } else if (model.shareType == WawaShareType_InviteShare) {
        title = @"推荐到";
        numberOfButtonPerLine = 4;
    } else {
        title = @"";
        numberOfButtonPerLine = 4;
    }
    
    HYActivityView * activityView = [[HYActivityView alloc] initWithTitle:title referView:[UIApplication sharedApplication].keyWindow];
    activityView.numberOfButtonPerLine = numberOfButtonPerLine;
    
    for (NSNumber * num in model.showShareModule) {
        ShareType type = [num integerValue];
        ButtonView * bv = nil;
        
        if (type == Tencent_weixin_friend) {
            
            bv = [[ButtonView alloc]initWithText:@"微信好友" image:[UIImage imageNamed:@"share_platform_wechat"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:Tencent_weixin_friend shareModel:model];
            }];
            
        } else if (type == Tencent_weixin_monent) {
            
            bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"share_platform_wechat_moment"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:Tencent_weixin_monent shareModel:model];
            }];
            
        } else if (type == Tencent_qq_friend) {
            
            bv = [[ButtonView alloc]initWithText:@"QQ好友" image:[UIImage imageNamed:@"share_platform_qqfriend"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:Tencent_qq_friend shareModel:model];
            }];
            
        } else if (type == Tencent_qq_QZone) {
            
            bv = [[ButtonView alloc]initWithText:@"QQ空间" image:[UIImage imageNamed:@"share_platform_qqZone"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:Tencent_qq_QZone shareModel:model];
            }];
            
        } else if (type == Sina_weibo) {
            
            bv = [[ButtonView alloc]initWithText:@"新浪微博" image:[UIImage imageNamed:@"share_platform_sina"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:Sina_weibo shareModel:model];
            }];
            
        } else if (type == App_inside_forward) {
            
            bv= [[ButtonView alloc]initWithText:@"班级圈" image:[UIImage imageNamed:@"share_platform_insider_share"] handler:^(ButtonView *buttonView){
                [self shareWithShareType:App_inside_forward shareModel:model];
            }];
        } else if (type == Type_Refresh) {
            
            bv = [[ButtonView alloc] initWithText:@"刷新" image:[UIImage imageNamed:@"网页刷新"] handler:^(ButtonView *buttonView){
//                MyWebViewController * vc = (MyWebViewController *)model.fromVC;
//                [vc.webView reload];
            }];
            
        } else if (type == Type_CopyURL) {
            
            bv = [[ButtonView alloc] initWithText:@"复制链接" image:[UIImage imageNamed:@"网址复制"] handler:^(ButtonView *buttonView){
                UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = model.replaceURL.absoluteString;
                //[MBProgressHUD showSuccess:@"已复制" toView:model.fromVC.view hideDelay:2];
            }];
            
        } else if (type == Type_OpenSafari) {
            
            bv = [[ButtonView alloc] initWithText:@"Safari打开" image:[UIImage imageNamed:@"浏览器"] handler:^(ButtonView *buttonView){
                [[UIApplication sharedApplication] openURL:model.replaceURL];
            }];
        } else if (type == Type_Report) {
            bv = [[ButtonView alloc] initWithText:@"举报" image:[UIImage imageNamed:@"report_shareBottomView"] handler:^(ButtonView *buttonView){
                
           
            }];
        } else if (type == Type_Circle) {
            bv = [[ButtonView alloc] initWithText:@"审核" image:[UIImage imageNamed:@"audit_shareBottomView"] handler:^(ButtonView *buttonView){
//                MyWebViewController * webVC = [[MyWebViewController alloc] initWithAddress:model.auditUrl];
//                webVC.hidesBottomBarWhenPushed = YES;
//                [model.fromVC.navigationController pushViewController:webVC animated:YES];
            }];
        }
        [activityView addButtonView:bv];
    }
    [activityView show];
}

#pragma mark- Open Share SDK

- (void)shareWithShareType:(ShareType)shareType shareModel:(WawaShareModel *)model
{
    _shareTitle = model.shareTitle;
    _shareContent = model.shareContent;
    _shareResultCallbackStyle = [WawaShareUtil shareResultCallbackStyleWithShareType:shareType];
    
    if (shareType == App_inside_forward) {
        
  
    } else {
        
        if (model.shareType == WawaShareType_MyWebVCShare) {
            UIImage * image=[UIImage imageNamed:@"icon_share_default"];
            [ShareRecordUtil shareUrl:[NSString stringWithFormat:@"%@", model.replaceURL] withTitle:model.shareTitle andDescription:model.shareContent andThumbImage:image byType:shareType];
        } else if (model.shareType == WawaShareType_InviteShare) {  // 推荐娃娃分享
            UIImage * image=[UIImage imageNamed:@"icon_share_default"];
            [ShareRecordUtil shareUrl:model.shareKey withTitle:model.shareTitle andDescription:model.shareContent andThumbImage:image byType:shareType];
        } else {
            NSString *imageUrl = @"";
            if ([model.shareImgUrl containsString:@"http://"] ||[model.shareImgUrl containsString:@"https://"]) {
                imageUrl = model.shareImgUrl;
            }else{
               // imageUrl = [WWCreateUrlManager createImageUrl:model.shareImgUrl andScaleRuleDefine:SCALE_WIDTH_MATCH_HEIGHT_WRAP];
            }
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRetryFailed | SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                if (model.shareType == WawaShareType_Question_Answer) {
//                    if (!image){
//                        image = [UIImage imageNamed:@"parent_default_header"];
//                    }
//                }
//                [ShareRecordUtil shareUrl:[self getSharedUrlWithShareModel:model] withTitle:model.shareTitle andDescription: model.shareContent andThumbImage:image byType:shareType];
//            }];
        }
    }
}

- (NSString *)getSharedUrlWithShareModel:(WawaShareModel *)model
{
    NSString * shareUrl = @"";
    if (model.shareType == WawaShareType_ReadInvite ) {
        shareUrl = model.shareKey;
    }else if (model.shareType == WawaShareType_LiveCast) {
        shareUrl = model.shareKey;
    }else {
        //shareUrl = [WWCreateUrlManager createSharedUrl:model.shareKey];
    }
    return shareUrl;
}

#pragma mark- MTAEvent operate

- (void)shareMTATrackEventWithType:(MTATrackCustomEventType)type
{
    NSString * eventStr = nil;
    switch (type) {
        case MTATrackCustomEvent_BabyShowDetail:
            eventStr = @"wawashow_detail_share";
            break;
        case MTATrackCustomEvent_PictureBookDetail:
            eventStr = @"classgroup_picturebook_bookdetail_share";
            break;
        case MTATrackCustomEvent_ClassNoticeDetail:
            eventStr = @"classgroup_classnotice_share";
            break;
        case MTATrackCustomEvent_TopicCircle:
            eventStr = @"topic_recommend_share";
            break;
        case MTATrackCustomEvent_Album:
            eventStr = @"classgroup_classalbum_share";
            break;
        case MTATrackCustomEvent_TopicDetail:
            eventStr = @"topic_detail_share";
            break;
        default:
            break;
    }
    if (eventStr) {
        //[WWCrashLogManager addMtaTrackCustomEvent:eventStr args:nil];
    }
}

+ (WawaShareResultCallbackStyle)shareResultCallbackStyleWithShareType:(ShareType)shareType {
    WawaShareResultCallbackStyle style = 0;
    switch (shareType) {
        case App_inside_forward:
            style = WawaShareResultCallback_CLASS_CIRCLE;
            break;
        case Tencent_weixin_friend:
            style = WawaShareResultCallback_WECHAT_FRIENDS;
            break;
        case Tencent_weixin_monent:
            style = WawaShareResultCallback_WECHAT_MOMENTS;
            break;
        case Tencent_qq_friend:
            style = WawaShareResultCallback_QQ_FIRENDS;
            break;
        case Tencent_qq_QZone:
            style = WawaShareResultCallback_QQ_MOMENTS;
            break;
        case Sina_weibo:
            style = WawaShareResultCallback_SINA;
            break;
        default:
            break;
    }
    return style;
}

#pragma mark- Share Result
+ (void)shareResultCallback {
    
    WawaShareResultCallbackStyle style = [WawaShareUtil sharedManager].shareResultCallbackStyle;
    NSString * shareTitle = [WawaShareUtil sharedManager].shareTitle;
    NSString * shareContent = [WawaShareUtil sharedManager].shareContent;

    
//    [HedoneShareReportResourceImpl doShareReportWithRequest:request targetLocation:(int)style loadingView:nil completion:^(bool succeed, NSString *ret) {
//        [WawaShareUtil sharedManager].shareResultCallbackStyle = 0;
//        [WawaShareUtil sharedManager].shareTitle = nil;
//        [WawaShareUtil sharedManager].shareContent = nil;
//    }];
}


@end
