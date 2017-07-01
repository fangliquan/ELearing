//
//  ELiveLoginViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveLoginViewController.h"
#import "CloudManager+Login.h"
#import "PHTextView.h"
#import "WechatPayManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <SMS_SDK/SMSSDK.h>
@interface ELiveLoginViewController (){
    UIButton *pswNumberbtn;
    UITextField*phoneTextL;
    UITextField *pswTextL;
}

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ELiveLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    [self configtableView];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{
    
    CGFloat offsetY = 80;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height)];
    
    [self.view addSubview:headerView];
    phoneTextL = [[UITextField alloc]initWithFrame:CGRectMake(15, 10, Main_Screen_Width - 30, 40)];
    phoneTextL.keyboardType = UIKeyboardTypePhonePad;
    phoneTextL.placeholder = @"  请输入手机号";
    phoneTextL.tintColor = EL_TEXTCOLOR_GRAY;
    phoneTextL.backgroundColor = [UIColor whiteColor];
    phoneTextL.textColor = EL_TEXTCOLOR_DARKGRAY;
    phoneTextL.font = [UIFont systemFontOfSize:15];
    phoneTextL.text = @"18618462580";
    [headerView addSubview:phoneTextL];
    
    pswTextL = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneTextL.frame) + 10, Main_Screen_Width - 150, 40)];
    pswTextL.placeholder = @"  输入验证码";
    pswTextL.tintColor = EL_TEXTCOLOR_GRAY;
    pswTextL.text = @"123456";
    pswTextL.keyboardType = UIKeyboardTypeDefault;
    pswTextL.backgroundColor = [UIColor whiteColor];
    pswTextL.textColor = EL_TEXTCOLOR_DARKGRAY;
    pswTextL.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:pswTextL];
    
    pswNumberbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pswTextL.frame) + 20, CGRectGetMaxY(phoneTextL.frame) + 15, 100, 30)];
    pswNumberbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pswNumberbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [pswNumberbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pswNumberbtn.backgroundColor = EL_COLOR_RED;
    [pswNumberbtn addTarget:self action:@selector(pswNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:pswNumberbtn];
    
    UIButton  *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(pswTextL.frame) + 40, Main_Screen_Width - 60, 40)];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbtn.backgroundColor = EL_COLOR_RED;
    [loginbtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:loginbtn];
    

    UILabel *otherTitleL = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2.0 - 50, CGRectGetMaxY(loginbtn.frame) + 40, 100, 15)];
    otherTitleL.textAlignment = NSTextAlignmentCenter;
    otherTitleL.textColor = EL_TEXTCOLOR_GRAY;
    otherTitleL.text = @"第三方登录";
    otherTitleL.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:otherTitleL];
    
    UILabel *lineLeft = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2.0 - 50 - 60 ,  CGRectGetMaxY(loginbtn.frame) + 40 + 15/2.0, 60, 0.5)];
    lineLeft.backgroundColor  = CELL_BORDER_COLOR;
    [headerView addSubview:lineLeft];
    
    UILabel *lineRight = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTitleL.frame),  CGRectGetMaxY(loginbtn.frame) + 40 + 15/2.0, 60, 0.5)];
    lineRight.backgroundColor  = CELL_BORDER_COLOR;
    [headerView addSubview:lineRight];
    
    
    
    CGFloat loginBtnH = 70;
    
    UIButton *qqbtnLogin = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2.0 - loginBtnH/2.0, CGRectGetMaxY(otherTitleL.frame) + 30, loginBtnH, loginBtnH)];
    [qqbtnLogin setImage:[UIImage imageNamed:@"login_weixin_icon"] forState:UIControlStateNormal];
    [qqbtnLogin addTarget:self action:@selector(weixinClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:qqbtnLogin];
    
    UIButton *weixinbtnLogin = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2.0 - loginBtnH/2.0 - loginBtnH - 20, CGRectGetMaxY(otherTitleL.frame) + 30, loginBtnH, loginBtnH)];
    [weixinbtnLogin setImage:[UIImage imageNamed:@"login_qq_icon"] forState:UIControlStateNormal];

    [headerView addSubview:weixinbtnLogin];
    
    
    UIButton *sinbtnLogin = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(qqbtnLogin.frame) + 20, CGRectGetMaxY(otherTitleL.frame) + 30, loginBtnH, loginBtnH)];
    [sinbtnLogin setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
    
    [headerView addSubview:sinbtnLogin];
    
    [phoneTextL becomeFirstResponder];
    
    
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];
    
    self.tableView.tableHeaderView = headerView;
}

-(void)getVerificationCode{

    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneTextL.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
        }
        else
        {
            // error
        }
    }];

}
-(void)commitVerificationCode:(NSString *)code andphone:(NSString *)phone{
    // 验证成功
    [[CloudManager sharedInstance]asyncUserLoginWithPhoneNumberAndCode:phoneTextL.text code:pswTextL.text completion:^(UserLoginResponse *ret, CMError *error) {
        if (error ==nil &&ret) {
            if (self.loginSuccessRefreshHandler) {
                self.loginSuccessRefreshHandler();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
//    [SMSSDK commitVerificationCode:code phoneNumber:phone zone:@"86" result:^(NSError *error) {
//        
//        if (!error)
//        {
//            // 验证成功
//            [[CloudManager sharedInstance]asyncUserLoginWithPhoneNumberAndCode:phoneTextL.text code:pswTextL.text completion:^(UserLoginResponse *ret, CMError *error) {
//                if (error ==nil &&ret) {
//                    if (self.loginSuccessRefreshHandler) {
//                        self.loginSuccessRefreshHandler();
//                    }
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//            }];
//
//        }
//        else
//        {
//            [MBProgressHUD showError:@"验证失败" toView:nil];
//            // error
//        }
//    }];
}
-(void)weixinClick{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
    
}
-(void)hiddenTextView{
    [self.view endEditing:YES];
}

-(void)loginBtnClick{
    if (phoneTextL.text.length <=0) {
        [MBProgressHUD showError:@"输入手机号" toView:nil];
        return;
    }
    if (pswTextL.text.length <=0) {
        [MBProgressHUD showError:@"输入验证码" toView:nil];
        return;
    }
    
    [self commitVerificationCode:pswTextL.text andphone:phoneTextL.text];
  }

-(void)pswNumberBtnClick{
    if (phoneTextL.text.length <=0) {
        [MBProgressHUD showError:@"输入手机号" toView:nil];
        return;
    }
    [self getVerificationCode];
    [self vertifyCode];
}

- (void)vertifyCode {
    UIButton *l_timeButton = pswNumberbtn;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [l_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                l_timeButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 100;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [l_timeButton setTitle:[NSString stringWithFormat:@"重新发送(%@)",strTime] forState:UIControlStateNormal];
                l_timeButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height -64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    
    [self.view addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
