//
//  WWExceptionRemindManager.m
//  wwface
//
//  Created by pc on 16/12/6.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WWExceptionRemindManager.h"

@interface WWExceptionRemindManager ()

@property (nonatomic, copy) ExceptionTapAction tapAction;
@property (nonatomic, strong) UIView * loadFailView;

@end

@implementation WWExceptionRemindManager

+ (UIView *)exceptionRemindViewWithType:(ExceptionRemindStyle)type {
    CGFloat height = (Main_Screen_Height - 64) / 2.0;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, height)];
    UIImageView * remindImageView = [[UIImageView alloc]initWithFrame:CGRectMake( Main_Screen_Width/2-75, 35,150, 150 * 654 / 637.0)];
    remindImageView.contentMode = UIViewContentModeScaleAspectFill;
    remindImageView.image = [UIImage imageNamed:@"exception_EmptyDefault"];
    [view addSubview:remindImageView];
    
    UILabel * alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,
                                                                    CGRectGetMaxY(remindImageView.frame),
                                                                    Main_Screen_Width - 40,
                                                                    60)];
    alertLabel.contentMode = UIViewContentModeTop;
    alertLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.0];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.numberOfLines = 0;
    alertLabel.textColor = EL_TEXTCOLOR_GRAY;
    [view addSubview:alertLabel];
    
    NSString * alertString = nil;
    if (type == ExceptionRemindStyle_Empty) {
        alertString = @"没有数据";
    }
    alertLabel.text = alertString;
    return view;
}

+ (UIView *)exceptionRemindView_Empty {
    return [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
}

+ (UIView *)exceptionRemindView_LoadfailWithTarget:(id)target action:(SEL)actoin {
    UIView * faildView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    [faildView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:actoin]];
    
    UIImageView * refreshIV = [[UIImageView alloc] init];
    refreshIV.userInteractionEnabled = YES;
    refreshIV.image = [UIImage imageNamed:@"MyWebViewController.bundle/WebView_LoadFail_Refresh_Icon"];
    refreshIV.contentMode = UIViewContentModeScaleAspectFit;
    [faildView addSubview:refreshIV];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"网络出错，轻触屏幕重新加载";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [faildView addSubview:label];
    
    [refreshIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(faildView.mas_top).offset(60);
        make.centerX.equalTo(faildView.mas_centerX);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(refreshIV);
        make.top.equalTo(refreshIV.mas_bottom);
        make.centerX.equalTo(refreshIV.mas_centerX);
        make.height.equalTo(@25);
    }];
    return faildView;
}

+ (void)exceptionRemindViewWithType:(ExceptionRemindStyle)type
                            succeed:(BOOL)succeed
                         dataSource:(NSArray *)dataSource
                          superView:(UIView *)superView
                 exceptionTapAction:(ExceptionTapAction)tapAction {
    [[WWExceptionRemindManager sharedInstance] removeLoadFailView];
    UIView * tempView = nil;
    if (succeed) {
        if (dataSource.count) return;
        tempView = [WWExceptionRemindManager exceptionRemindViewWithType:type];
    } else {
        tempView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:[WWExceptionRemindManager sharedInstance] action:@selector(loadData_Loadfail)];
    }
    if (tempView) {
        [superView addSubview:tempView];
    }
    if (!succeed) {
        [WWExceptionRemindManager sharedInstance].tapAction = tapAction;
        [WWExceptionRemindManager sharedInstance].loadFailView = tempView;
    }
}

- (void)loadData_Loadfail {
    if ([WWExceptionRemindManager sharedInstance].tapAction) {
        [WWExceptionRemindManager sharedInstance].tapAction();
        [[WWExceptionRemindManager sharedInstance] removeLoadFailView];
    }
}

- (void)removeLoadFailView {
    if ([WWExceptionRemindManager sharedInstance].loadFailView) {
        [[WWExceptionRemindManager sharedInstance].loadFailView removeFromSuperview];
        [WWExceptionRemindManager sharedInstance].loadFailView = nil;
    }
    if ([WWExceptionRemindManager sharedInstance].tapAction) {
        [WWExceptionRemindManager sharedInstance].tapAction = nil;
    }
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static WWExceptionRemindManager * manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[WWExceptionRemindManager alloc] init];
    });
    return manager;
}


@end
