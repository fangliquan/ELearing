//
//  ELiveSettingAboutViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingAboutViewController.h"

@interface ELiveSettingAboutViewController ()

@end

@implementation ELiveSettingAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat iconW = 100;
    
    UIImageView *userHeader = [[UIImageView alloc]initWithFrame:CGRectMake( (Main_Screen_Width - iconW)/2.0,iconW * 1.5, iconW, iconW)];
    userHeader.layer.masksToBounds = YES;
    userHeader.userInteractionEnabled = YES;
    userHeader.image = [UIImage imageNamed:@"image_default_userheader"];
    [self.view addSubview:userHeader];
    
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(userHeader.frame) + 10, Main_Screen_Width - 60, 30)];
    userNameLabel.numberOfLines = 2;
    userNameLabel.text = @"王大大";
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:17];
    userNameLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self.view addSubview:userNameLabel];

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
