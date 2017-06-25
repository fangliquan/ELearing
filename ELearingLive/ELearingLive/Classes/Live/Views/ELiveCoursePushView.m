//
//  ELiveCoursePushView.m
//  ELearingLive
//
//  Created by microleo on 2017/6/25.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCoursePushView.h"

#import "ELiveCourseFooterView.h"

@interface ELiveCoursePushView(){
   UIButton *closeBtn;
}

@property(nonatomic,strong) ELiveCourseFooterView *footerView;

@property(nonatomic,assign) BOOL  isScreenHorizontal;

@end

@implementation ELiveCoursePushView
/* 推流模式（横屏or竖屏）*/
- (instancetype)initWithFrame:(CGRect)frame andisScreenHorizontal:(BOOL)isScreenHorizontal
{
    _isScreenHorizontal = isScreenHorizontal;
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    closeBtn = [[UIButton alloc ]initWithFrame:CGRectMake(Main_Screen_Width- 50,15, 38, 38)];
    [closeBtn setImage:[UIImage imageNamed:@"live_ico_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    
    
    ELiveCourseFooterView *footerView = [[ELiveCourseFooterView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 60, Main_Screen_Width, 64) andLivePlayer:NO andisScreenHorizontal:_isScreenHorizontal];
    
    self.footerView = footerView;
    
    [self addSubview:footerView];
    
}

-(void)closeBtnClick{
    if (self.closeLiveHandler) {
        self.closeLiveHandler();
    }
}
@end
