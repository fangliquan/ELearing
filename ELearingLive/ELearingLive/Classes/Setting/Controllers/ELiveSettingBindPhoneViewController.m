//
//  ELiveSettingBindPhoneViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingBindPhoneViewController.h"
#import "PHTextView.h"

@interface ELiveSettingBindPhoneViewController ()
{
    UIButton *pswNumberbtn;
    UITextField *phoneTextL;
    UITextField *pswTextL;
}

@end

@implementation ELiveSettingBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{
    
    CGFloat offsetY = 80;
    
    phoneTextL = [[UITextField alloc]initWithFrame:CGRectMake(15, offsetY +15, Main_Screen_Width - 30, 40)];
    phoneTextL.keyboardType = UIKeyboardTypePhonePad;
    phoneTextL.placeholder = @" 请输入手机号";
    phoneTextL.tintColor = EL_TEXTCOLOR_GRAY;
    phoneTextL.backgroundColor = [UIColor whiteColor];
    phoneTextL.textColor = EL_TEXTCOLOR_DARKGRAY;
    phoneTextL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:phoneTextL];
    
    pswTextL = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneTextL.frame) + 10, Main_Screen_Width - 150, 40)];
    pswTextL.placeholder = @" 输入验证码";
    pswTextL.tintColor = EL_TEXTCOLOR_GRAY;
    pswTextL.keyboardType = UIKeyboardTypeDefault;
    pswTextL.backgroundColor = [UIColor whiteColor];
    pswTextL.textColor = EL_TEXTCOLOR_DARKGRAY;
    pswTextL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pswTextL];
    
    pswNumberbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pswTextL.frame) + 20, CGRectGetMaxY(phoneTextL.frame) + 15, 100, 30)];
    pswNumberbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pswNumberbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [pswNumberbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pswNumberbtn.backgroundColor = EL_COLOR_RED;
    [pswNumberbtn addTarget:self action:@selector(pswNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pswNumberbtn];
    
    UIButton  *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(pswTextL.frame) + 40, Main_Screen_Width - 60, 40)];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginbtn setTitle:@"绑定手机号" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbtn.backgroundColor = EL_COLOR_RED;
    [loginbtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];
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
    
    [[CloudManager sharedInstance]asyncUserBindPhoneWithCode:phoneTextL.text code:pswTextL.text completion:^(NSString *ret, CMError *error) {
        if (error ==nil) {
             [MBProgressHUD showError:@"绑定成功" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:@"绑定失败" toView:nil];
        }
    }];

}

-(void)pswNumberBtnClick{
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


@end
