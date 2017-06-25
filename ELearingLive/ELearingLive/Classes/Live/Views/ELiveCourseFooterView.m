//
//  WawaLiveFooterView.m
//  IJKMediaDemo
//
//  Created by leo on 16/6/27.
//  Copyright © 2016年 bilibili. All rights reserved.
//

#import "ELiveCourseFooterView.h"

#define ImageWidth 38


@interface ELiveCourseFooterView (){
    
    UIButton *commentBtn;
    UIButton *canSpeakBtn;
    UIButton *beautyFilterBtn;
    UIButton *clearScreenBtn;
    UIButton *cameraButton;
    //UIButton *cutScreenBtn;
    UIButton *liveGiftBtn;
    UIButton *liveShareBtn;
}

@property(nonatomic, assign) int userLikeCount;
@property(nonatomic, assign) BOOL  isLivePlayer;
@property(nonatomic,assign) BOOL  isScreenHorizontal;

@end

@implementation ELiveCourseFooterView


- (instancetype)initWithFrame:(CGRect)frame andLivePlayer:(BOOL)livePlayer andisScreenHorizontal:(BOOL)isScreenHorizontal
{
    _isScreenHorizontal = isScreenHorizontal;
    _isLivePlayer = livePlayer;
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat offsetX = 5;
    CGFloat offsetY = 10;
    commentBtn = [[UIButton alloc ]initWithFrame:CGRectMake(offsetX* 2,offsetY, ImageWidth, ImageWidth)];
    [commentBtn setImage:[UIImage imageNamed:@"live_add_comment_icon"] forState:UIControlStateNormal];
    commentBtn.tag = 101;
    [commentBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentBtn];
    
    if (_isLivePlayer) {
        clearScreenBtn = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(commentBtn.frame) + offsetY,offsetY, ImageWidth, ImageWidth)];
        [clearScreenBtn setImage:[UIImage imageNamed:@"live_clear_screen_y_icon"] forState:UIControlStateNormal];
        clearScreenBtn.tag = 105;//清屏
        [clearScreenBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearScreenBtn];
        
        liveShareBtn = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(clearScreenBtn.frame) + offsetY,offsetY, ImageWidth, ImageWidth)];
        [liveShareBtn setImage:[UIImage imageNamed:@"live_cast_share_icon"] forState:UIControlStateNormal];
        liveShareBtn.tag = 107;//分享
        [liveShareBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:liveShareBtn];
        
    }else{
        canSpeakBtn = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(commentBtn.frame) + offsetY,offsetY, ImageWidth, ImageWidth)];
        [canSpeakBtn setImage:[UIImage imageNamed:@"live_stop_speak_icon"] forState:UIControlStateNormal];
        canSpeakBtn.tag = 102;//禁言
        [canSpeakBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:canSpeakBtn];
        
        
        beautyFilterBtn = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(canSpeakBtn.frame) + offsetY,offsetY, ImageWidth, ImageWidth)];
        [beautyFilterBtn setImage:[UIImage imageNamed:@"live_smarty_open"] forState:UIControlStateNormal];
        beautyFilterBtn.tag = 103;//美颜
        [beautyFilterBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:beautyFilterBtn];
        
        
        cameraButton = [[UIButton alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(beautyFilterBtn.frame) + offsetY,offsetY, ImageWidth, ImageWidth)];
        [cameraButton setImage:[UIImage imageNamed:@"live_switch_camera_icon"] forState:UIControlStateNormal];
        cameraButton.tag = 104;//摄像头
        [cameraButton addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cameraButton];
        
    }
    
    if (_isLivePlayer) {
         
        liveGiftBtn = [[UIButton alloc ]initWithFrame:CGRectMake(Main_Screen_Width - 98,10, ImageWidth, ImageWidth)];
        [liveGiftBtn setImage:[UIImage imageNamed:@"live_gift_icon"] forState:UIControlStateNormal];
        liveGiftBtn.tag = 108;//红包
        //cutScreenBtn.backgroundColor = [UIColor redColor];
        [liveGiftBtn addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:liveGiftBtn];
    }
    
    UIButton *favButton = [[UIButton alloc ]initWithFrame:CGRectMake(Main_Screen_Width - 50,10, ImageWidth, ImageWidth)];
    [favButton setImage:[UIImage imageNamed:@"live_add_favorite_icon"] forState:UIControlStateNormal];
    favButton.tag = 106;
    [favButton addTarget:self action:@selector(commentBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:favButton];
    
}



-(void)commentBtnButtonClick:(UIButton *)btn{
    if (btn.tag == 101) {
        if (self.addNewCommentMsgClickBlock) {
            self.addNewCommentMsgClickBlock();
        }
    }else if (btn.tag == 102){
        if (self.canSpeakBtnClickBlock) {
            self.canSpeakBtnClickBlock();//禁言
        }
    }else if (btn.tag == 103){
        if (self.beautyFilterClickBlock) {
            self.beautyFilterClickBlock();//美颜
        }
    }else if (btn.tag == 104){
        if (self.cameraClickBlock) {
            self.cameraClickBlock();
        }
    }else if (btn.tag == 105){

        if (self.clearScreenClickBlock) {
            self.clearScreenClickBlock();
        }
    }else if (btn.tag == 106){
        if (self.addHeartClickBlock) {
            self.addHeartClickBlock();
        }
    }else if (btn.tag == 107){
        if (self.shareliveCastClickBlock) {
            self.shareliveCastClickBlock();
        }
    }else if (btn.tag == 108){
        if (self.liveGiftClickBlock) {
            self.liveGiftClickBlock();
        }
    }
}


-(void)setIsSilentLiveCast:(BOOL)isSilentLiveCast{
    _isSilentLiveCast = isSilentLiveCast;
    if (isSilentLiveCast) {
        [canSpeakBtn setImage:[UIImage imageNamed:@"live_stop_speak_icon_y"] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"ive_add_comment_no_icon"] forState:UIControlStateNormal];
        commentBtn.enabled = NO;
        
    }else{
        [canSpeakBtn setImage:[UIImage imageNamed:@"live_stop_speak_icon"] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"live_add_comment_icon"] forState:UIControlStateNormal];
        commentBtn.enabled = YES;
    }
}


-(void)setIsBeautyOpen:(BOOL)isBeautyOpen{
    _isBeautyOpen = isBeautyOpen;
    if (isBeautyOpen) {
        [beautyFilterBtn setImage:[UIImage imageNamed:@"live_smarty_open"] forState:UIControlStateNormal];
    }else{
        [beautyFilterBtn setImage:[UIImage imageNamed:@"live_smarty_close"] forState:UIControlStateNormal];
    }
    
}

-(void)setSendGift:(BOOL)sendGift{
    _sendGift = sendGift;
    if (_isLivePlayer) {
        liveGiftBtn.hidden = !sendGift;
    }
}
@end
