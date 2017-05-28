//
//  ELiveSettingFaceBackViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingFaceBackViewController.h"
#import "PHTextView.h"
@interface ELiveSettingFaceBackViewController (){
   UIScrollView *bgScroll;
}


@end

@implementation ELiveSettingFaceBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    bgScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScroll];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgScroll addSubview:headerView];
    
    UILabel *courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,15, Main_Screen_Width - 20, 20)];
    courseTitleLabel.text = @"投诉建议";
    courseTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseTitleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:courseTitleLabel];
    
    
    UILabel *courseMLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(courseTitleLabel.frame),Main_Screen_Width - 20, 20)];
    courseMLabel.text = @"最大字数500";
    courseMLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseMLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:courseMLabel];
    
    
    PHTextView *backView = [[PHTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(courseMLabel.frame)+ 10, Main_Screen_Width - 20, Main_Screen_Width - CGRectGetMaxY(courseMLabel.frame) - 20)];
    backView.tintColor = EL_TEXTCOLOR_GRAY;
    backView.placeholder = @"请输入反馈建议";
    backView.font = [UIFont systemFontOfSize:15];
    backView.backgroundColor = [UIColor whiteColor];
    backView.textColor = EL_TEXTCOLOR_DARKGRAY;
    [headerView addSubview:backView];
    
    
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(headerView.frame) + 20, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = EL_COLOR_RED;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    
    [bgScroll addSubview:submitBtn];
    
    bgScroll.contentSize = CGSizeMake(Main_Screen_Width,CGRectGetMaxY(submitBtn.frame) + 10);
    
    bgScroll.userInteractionEnabled = YES;
    [bgScroll addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenText)]];
    
    
    [self.view addSubview:bgScroll];
    

}

-(void)hiddenText{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
