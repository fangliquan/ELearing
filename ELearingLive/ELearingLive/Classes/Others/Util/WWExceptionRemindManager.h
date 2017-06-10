//
//  WWExceptionRemindManager.h
//  wwface
//
//  Created by pc on 16/12/6.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ExceptionRemindStyle) {
    ExceptionRemindStyle_Loadfail,
    ExceptionRemindStyle_Empty,
};

typedef void(^ExceptionTapAction)(void);

@interface WWExceptionRemindManager : NSObject

+ (UIView *)exceptionRemindViewWithType:(ExceptionRemindStyle)type;
+ (UIView *)exceptionRemindView_Empty;
+ (UIView *)exceptionRemindView_LoadfailWithTarget:(id)target action:(SEL)actoin;

+ (void)exceptionRemindViewWithType:(ExceptionRemindStyle)type
                            succeed:(BOOL)succeed
                         dataSource:(NSArray *)dataSource
                          superView:(UIView *)superView
                 exceptionTapAction:(ExceptionTapAction)tapAction;

@end
