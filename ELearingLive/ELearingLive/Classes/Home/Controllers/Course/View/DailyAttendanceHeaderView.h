//
//  DailyAttendanceHeaderView.h
//  wwface
//
//  Created by leo on 16/8/5.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyAttendanceHeaderView : UIView

@property (nonatomic, copy) void (^getAttendanceDateHandler)(NSDate *date);

-(void)updateChangeMonthBtnState:(BOOL)enable;


@end
