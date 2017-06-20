//
//  DailyAttendanceHeaderView.m
//  
//
//  Created by leo on 16/8/5.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "DailyAttendanceHeaderView.h"

@interface DailyAttendanceHeaderView (){
    UIButton *rightUpBtn;
    UIButton *rightUpBtnTip;
    
    UIButton *leftUpBtn;
    UIButton *leftUpBtnTip;
    UILabel *dailyTimeTitle;
    long long currentDate;
    long long nowdate;
    
    UIView *commuterView;
    UILabel *noAttendanceLabel;
    
    UILabel *leavePersonLabel;
    UILabel *leaveNumLabel;
    
    UILabel *absencePersonLabel;
    UILabel *absenceNumLabel;
    
    UILabel *latePersonLabel;
    UILabel *lateNumLabel;
    
    UILabel *successPersonLabel;
    UILabel *successNumLabel;
}



@end

@implementation DailyAttendanceHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat marginX = 10;
    CGFloat marginTop = 8;
    CGFloat itemViewHeight = 45;
    
    
    CGFloat dailyHeight = itemViewHeight *1;
    CGFloat dailyW  = Main_Screen_Width - 2* marginX ;
    UIView *dailyBgView = [[UIView alloc]initWithFrame:CGRectMake(marginX, marginTop,dailyW, dailyHeight)];
    dailyBgView.backgroundColor = [UIColor whiteColor];
    dailyBgView.userInteractionEnabled = YES;
    dailyBgView.layer.masksToBounds = YES;
    dailyBgView.layer.cornerRadius = 5;
    [self addSubview:dailyBgView];
    
    UIView *timeControlView = [[UIView alloc]initWithFrame:CGRectMake(0,0, dailyW, itemViewHeight)];
    timeControlView.backgroundColor = [UIColor whiteColor];
    timeControlView.layer.masksToBounds = YES;
    timeControlView.layer.cornerRadius = 5;
    timeControlView.userInteractionEnabled = YES;
    [dailyBgView addSubview:timeControlView];
    
    
    CGFloat titleControloffsetY = 2*marginTop - 3;
    
    CGFloat timeW = 147.164f;
    
    CGFloat timeTitleOffsetX = dailyW/2 - timeW/2;
    
    currentDate =  [[NSDate date] timeIntervalSince1970]*1000;
    
    nowdate = currentDate;
    NSString *dateStr =  [DateHelper weekdayAndDateStringFromTimeInterval:currentDate];
    dailyTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(timeTitleOffsetX, titleControloffsetY,timeW , 20)];
    dailyTimeTitle.textColor = EL_TEXTCOLOR_DARKGRAY;
    dailyTimeTitle.font = [UIFont systemFontOfSize:16];
    dailyTimeTitle.textAlignment = NSTextAlignmentCenter;
    dailyTimeTitle.text = dateStr;
    [timeControlView addSubview:dailyTimeTitle];
    
    
    rightUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dailyTimeTitle.frame), 5, 40, 35)];
    rightUpBtn.backgroundColor = [UIColor whiteColor];
    rightUpBtn.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
    [rightUpBtn setImage:[UIImage imageNamed:@"right_sharp_unenable_time"] forState:UIControlStateNormal];
    [timeControlView addSubview:rightUpBtn];
    
    rightUpBtnTip = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dailyTimeTitle.frame) - timeW/3.0, 5, 30 + timeW/3, 35)];
    rightUpBtnTip.enabled = NO;
    //rightUpBtnTip.backgroundColor = [UIColor yellowColor];
    rightUpBtnTip.tag = 1;
    [rightUpBtnTip addTarget:self action:@selector(controlTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    rightUpBtnTip.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
    [timeControlView addSubview:rightUpBtnTip];
    
  
    
    leftUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(timeTitleOffsetX - 40 , 5, 40, 35)];
    leftUpBtn.backgroundColor = [UIColor whiteColor];
    leftUpBtn.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
    [leftUpBtn setImage:[UIImage imageNamed:@"left_sharp_change_time"] forState:UIControlStateNormal];
    [timeControlView addSubview:leftUpBtn];
    
    leftUpBtnTip = [[UIButton alloc]initWithFrame:CGRectMake(marginX *2 +20, 5, 40 + timeW/3, 35)];
   // leftUpBtnTip.backgroundColor = [UIColor yellowColor];
    leftUpBtnTip.tag = 2;
    [leftUpBtnTip addTarget:self action:@selector(controlTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    leftUpBtnTip.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
    [timeControlView addSubview:leftUpBtnTip];
    
    
    
    
}



-(void)controlTimeClick:(UIButton *)sender{
    if (sender.tag == 1) {
        //新的日期rightUpBtn
        currentDate  = (currentDate/1000 + 24*3600)*1000;
        
        NSString *titleStr = [DateHelper weekdayAndDateStringFromTimeInterval:currentDate];
       
        dailyTimeTitle.text = titleStr;
//        if ((currentDate/1000- (nowdate/1000 - 24*3600)) >=3600*24) {
//            [rightUpBtn setImage:[UIImage imageNamed:@"right_sharp_unenable_time"] forState:UIControlStateNormal];
//            rightUpBtnTip.enabled = NO;
//        }else{
//            [rightUpBtn setImage:[UIImage imageNamed:@"right_sharp_enable_time"] forState:UIControlStateNormal];
//            rightUpBtnTip.enabled = YES;
//        }
       
    }else if(sender.tag == 2){//以前的日期 leftUpBtn
        currentDate =  (currentDate/1000 - 24*3600)*1000;
        NSString *titleStr = [DateHelper weekdayAndDateStringFromTimeInterval:currentDate];
       
        [rightUpBtn setImage:[UIImage imageNamed:@"right_sharp_enable_time"] forState:UIControlStateNormal];
        rightUpBtnTip.enabled = YES;
        dailyTimeTitle.text = titleStr;
        
    }
    if (self.getAttendanceDateHandler) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:currentDate/1000];
        self.getAttendanceDateHandler(date);
    }
}

-(void)updateChangeMonthBtnState:(BOOL)enable{
    leftUpBtnTip.enabled = enable;
    rightUpBtnTip.enabled = enable;
}
@end
