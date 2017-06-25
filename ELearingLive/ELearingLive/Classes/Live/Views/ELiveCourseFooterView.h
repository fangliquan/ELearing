//
//  WawaLiveFooterView.h
//  IJKMediaDemo
//
//  Created by leo on 16/6/27.
//  Copyright © 2016年 bilibili. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ELiveCourseFooterView : UIView


@property(nonatomic,copy)void(^addNewCommentMsgClickBlock)();

@property(nonatomic,copy)void(^addHeartClickBlock)();
@property(nonatomic,copy)void(^canSpeakBtnClickBlock)();
@property(nonatomic,copy)void(^beautyFilterClickBlock)();
@property(nonatomic,copy)void(^cameraClickBlock)();
@property(nonatomic,copy)void(^clearScreenClickBlock)();
@property(nonatomic,copy)void(^shareliveCastClickBlock)();
@property(nonatomic,copy)void(^liveGiftClickBlock)();
- (instancetype)initWithFrame:(CGRect)frame andLivePlayer:(BOOL)livePlayer andisScreenHorizontal:(BOOL)isScreenHorizontal;

@property(nonatomic, assign) BOOL  isSilentLiveCast;//禁言

@property(nonatomic, assign) BOOL  isBeautyOpen;//美颜

@property (nonatomic, assign) BOOL sendGift; //是否展示红包按钮

@end
