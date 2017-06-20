//
//  WawaShareUtil.h
//  
//
//  Created by pc on 16/6/17.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "InsideForwardSelectViewController.h"
#import "ShareRecordUtil.h"

typedef NS_ENUM(NSInteger, WawaShareType) {
    WawaShareType_BabyShow = 1,         // 娃娃秀
    WawaShareType_BabyShowDetail,
    WawaShareType_Topic,                // 话题
    WawaShareType_TopicDetail,
    WawaShareType_KinderArchive,        // 园区档案
    WawaShareType_PictureBook,          // 绘本
    WawaShareType_ClassNotice,          // 公告
    WawaShareType_ClassAlbum,           // 相册
    WawaShareType_TeacherCollect,       // 幼师培训
    WawaShareType_TeacherConsulting,    // 幼师咨询
    WawaShareType_MyWebVCShare,         // 网页中的分享
    WawaShareType_ReadInvite,           // 阅读邀请
    WawaShareType_Song,                 // 儿歌
    WawaShareType_HealthValue,          // 园区健康
    WawaShareType_VIPPictureBook,       // 绘本会员分享
    WawaShareType_LiveCast,             // 直播分享
    WawaShareType_ReadPlayDetail,       // 播放详情页分享
    WawaShareType_ReadPlayDetail_ReadLock,       // 播放详情页分享锁
    WawaShareType_Question_Answer,      // 问答
    WawaShareType_ReadPlanDo_Share,      // 阅读计划执行分享
    WawaShareType_InviteShare,          // 邀请分享
};

typedef NS_ENUM(NSInteger, WawaShareResultCallbackStyle) {
    WawaShareResultCallback_CLASS_CIRCLE = 1,   // 班级圈
    WawaShareResultCallback_WECHAT_FRIENDS,     // 微信好友
    WawaShareResultCallback_WECHAT_MOMENTS,     // 微信朋友圈
    WawaShareResultCallback_QQ_FIRENDS,         // QQ好友
    WawaShareResultCallback_QQ_MOMENTS,         // QQ空间
    WawaShareResultCallback_SINA,               // 新浪微博
};

/**
 *  MTA 分享统计事件类型
 */
typedef NS_ENUM(NSInteger, MTATrackCustomEventType) {
    MTATrackCustomEvent_NULL,
    MTATrackCustomEvent_BabyShowDetail,
    MTATrackCustomEvent_PictureBookDetail,
    MTATrackCustomEvent_ClassNoticeDetail,
    MTATrackCustomEvent_TopicCircle,
    MTATrackCustomEvent_Album,
    MTATrackCustomEvent_TopicDetail
};

@interface WawaShareModel : NSObject

@property (nonatomic, assign) WawaShareType shareType;
@property (nonatomic, assign) long long shareKeyId;
@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareContent;
@property (nonatomic, copy) NSString * shareImgUrl;
@property (nonatomic, copy) NSString * shareKey;
@property (nonatomic, strong) UIViewController * fromVC;
@property (nonatomic, strong) NSArray * showShareModule;

@property (nonatomic, copy) NSString * type;    // WawaShareType_ReadPlayDetail 分享时用

@property (nonatomic, assign) BOOL showReportButton;    // 举报

@property (nonatomic, assign) BOOL auditable;   // 圈主
@property (nonatomic, copy) NSString * auditUrl;

/**
 *  班级圈内部分享使用
 */
//@property (nonatomic, assign) ShareCardFromType shareFromType;
@property (nonatomic, assign) long long contentId;

/**
 *  网页分享使用
 */
@property (nonatomic, assign) BOOL showClassShare;
@property (nonatomic, strong) NSURL * replaceURL;
/**
 *  话题详情分享使用
 */
@property (nonatomic, assign) ShareType shareActionType;


+ (WawaShareModel *)getShareModelWithType:(WawaShareType)shareType shareKeyId:(long long)keyId shareTitle:(NSString *)title shareContent:(NSString *)content shareImgUrl:(NSString *)imgUrl fromViewController:(UIViewController *)vc;

+ (WawaShareModel *)getShareModelWithType:(WawaShareType)shareType shareUrl:(NSString *)shareUrl shareTitle:(NSString *)title shareContent:(NSString *)content shareImgUrl:(NSString *)imgUrl fromViewController:(UIViewController *)vc;


@end


@interface WawaShareUtil : NSObject

+ (void)shareWithShareModel:(WawaShareModel *)model;

+ (void)shareResultCallback;

@end
