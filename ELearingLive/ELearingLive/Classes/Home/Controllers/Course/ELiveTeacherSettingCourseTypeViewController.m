//
//  ELiveTeacherSettingCourseTypeViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/18.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveTeacherSettingCourseTypeViewController.h"

#import "CloudManager+Course.h"
#import "UcTeacherModel.h"
#import "UcCourseIndex.h"
#import <UShareUI/UShareUI.h>
@interface ELiveTeacherSettingCourseTypeViewController (){
    
    UIView *priceView;
    UITextField *priceTextView;
    
    UIView *pswView;
    UITextField *pswTextView;
    
    UILabel *allUserTitleLabel;
    
    NSInteger selectIndex;
    UIButton *submitBtn;
    
    UIImageView *priceUserBtn;
    UIImageView *suoUserBtn;
    UIImageView *allUserBtn;
}


@end

@implementation ELiveTeacherSettingCourseTypeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"直播类型";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createUI];
    [self setupNav];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];    // Do any additional setup after loading the view.
    
    [self createFooterView:YES];
    selectIndex = 1;
    if ([_course_type isEqualToString:@"1"]) {
        selectIndex = 1;
        [self allUserBtnClick];
    }else if ([_course_type isEqualToString:@"2"]){
        selectIndex = 3;
        [self suoUserBtnClick];
    }else if ([_course_type isEqualToString:@"3"]){
        selectIndex = 2;
        [self buyUserBtnClick];
    }
}



-(void)hiddenTextView{
    [self.view endEditing:YES];
}
- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtn)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)cancelBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createFooterView:(BOOL)enable{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0,Main_Screen_Height - 100, Main_Screen_Width, 100)];
    
    submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30,10, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = enable? EL_COLOR_RED:CELL_BORDER_COLOR;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.enabled = enable;
    submitBtn.layer.cornerRadius = 5;
    if (self.isEdit) {
        [submitBtn setTitle:@"保存课程" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(editCourseClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [submitBtn setTitle:@"创建课程" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(saveCourseClick) forControlEvents:UIControlEventTouchUpInside];
    }

    [footerView addSubview:submitBtn];
    [self.view  addSubview: footerView];
}


-(void)editCourseClick{
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在保存..." toView:nil];
    [[CloudManager sharedInstance]asyncSaveEditCourseWithCourseInfo:self.teacherCourseInfo completion:^(CourseDetailInfoModel *ret, CMError *error) {
        [hud hide:YES];
        submitBtn.enabled = YES;
        if (error ==nil) {
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"课程修改成功" style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:@[@"分享"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex ==1) {
                    [self shareClick:ret];
                }else{
                    [self cancelBtn];
                }
            }];
        }else{
            
        }
    }];
}
-(void)saveCourseClick{
    
    if (selectIndex ==1) {
        self.teacherCourseInfo.price = @"";
        self.teacherCourseInfo.password = @"";
    }
    
    if (selectIndex ==2) {
        self.teacherCourseInfo.price = @"";
        if (pswTextView.text.length <=0) {
            [MBProgressHUD showError:@"请设置密码" toView:nil];
            return;
        }
        self.teacherCourseInfo.password = pswTextView.text;
    }
    
    if (selectIndex ==3) {
       
        self.teacherCourseInfo.password = @"";
        if (priceTextView.text.length <=0) {
            [MBProgressHUD showError:@"请设置课程费用" toView:nil];
            return;
        }
        self.teacherCourseInfo.price = priceTextView.text;
        
        
    }
    
    submitBtn.enabled = NO;
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在创建..." toView:nil];
    [[CloudManager sharedInstance]asyncCreateNewCourseWithCourseInfo:self.teacherCourseInfo completion:^(CourseDetailInfoModel *ret, CMError *error) {
        [hud hide:YES];
        submitBtn.enabled = YES;
        if (error ==nil) {
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"课程创建成功" style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:@[@"分享"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex ==1) {
                    [self shareClick:ret];
                }else{
                    [self cancelBtn];
                }
         
            }];
        }else{
            
        }
    }];
}


-(void)shareClick:(CourseDetailInfoModel *)ret{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString* thumbURL =  ret.share_thumb;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ret.share_title descr:ret.share_desp thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = ret.share_url;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
           [self cancelBtn];
            
        }];
        
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{

}

-(void)createUI{
    
    UILabel *courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,25,Main_Screen_Width - 20,20)];
    courseTitleLabel.text = @"选择直播类型";
    courseTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseTitleLabel.textAlignment = NSTextAlignmentCenter;
    courseTitleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:courseTitleLabel];
    
    UILabel *courseDespLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(courseTitleLabel.frame)+2, Main_Screen_Width - 20, 20)];
    courseDespLabel.text = @"(选择后不能更改)";
    courseDespLabel.textColor = EL_COLOR_RED;
    courseDespLabel.font = [UIFont systemFontOfSize:14];
    courseDespLabel.numberOfLines = 0;
    courseDespLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:courseDespLabel];
    

    CGFloat imageW = Main_Screen_Width/ 3.0;
    
    allUserBtn= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(courseDespLabel.frame) + 20, imageW, 50)];
    allUserBtn.image = [UIImage imageNamed:@"course_set_free_y"];
    allUserBtn.contentMode = UIViewContentModeScaleAspectFit;
    allUserBtn.layer.masksToBounds = YES;
    //allUserBtn.layer.cornerRadius = 25;
    allUserBtn.userInteractionEnabled = YES;
    [allUserBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allUserBtnClick)]];
    [self.view  addSubview:allUserBtn];
    
    
    
    suoUserBtn= [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allUserBtn.frame), CGRectGetMaxY(courseDespLabel.frame) + 20, imageW, 50)];
    suoUserBtn.layer.masksToBounds = YES;
    suoUserBtn.image = [UIImage imageNamed:@"course_set_psw_n"];
    //suoUserBtn.layer.cornerRadius = 25;
    suoUserBtn.contentMode = UIViewContentModeScaleAspectFit;
    suoUserBtn.userInteractionEnabled = YES;
    [suoUserBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(suoUserBtnClick)]];
    [self.view  addSubview:suoUserBtn];
    
    
    priceUserBtn= [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(suoUserBtn.frame), CGRectGetMaxY(courseDespLabel.frame) + 20, imageW, 50)];
    priceUserBtn.layer.masksToBounds = YES;
    priceUserBtn.image = [UIImage imageNamed:@"course_set_price_n"];
    //priceUserBtn.layer.cornerRadius = 25;
    priceUserBtn.contentMode = UIViewContentModeScaleAspectFit;
    priceUserBtn.userInteractionEnabled = YES;
    [priceUserBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyUserBtnClick)]];
    [self.view  addSubview:priceUserBtn];
    
    
    allUserTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(allUserBtn.frame) +10,Main_Screen_Width - 20,20)];
    allUserTitleLabel.text = @"任何人都可以收听直播";
    allUserTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    allUserTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:allUserTitleLabel];
    
    
    pswView = [[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(allUserBtn.frame) +10,Main_Screen_Width - 20,70)];
    pswView.hidden = YES;
    pswView.backgroundColor = CELL_BORDER_COLOR;
    [self.view addSubview:pswView];
    
    UILabel *pswTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10,Main_Screen_Width - 20,20)];
    pswTitleLabel.text = @"设置一个听课密码";
    pswTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    pswTitleLabel.textAlignment = NSTextAlignmentCenter;
    pswTitleLabel.font = [UIFont systemFontOfSize:15];
    [pswView addSubview:pswTitleLabel];
    
    pswTextView = [[UITextField alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(pswTitleLabel.frame),Main_Screen_Width - 40,30)];
    pswTextView.textColor = EL_TEXTCOLOR_DARKGRAY;
    pswTextView.font = [UIFont systemFontOfSize:15];
    pswTextView.tintColor = EL_TEXTCOLOR_GRAY;
    pswTextView.placeholder = @"请输入听课密码";
    pswTextView.backgroundColor = [UIColor whiteColor];
    [pswView addSubview:pswTextView];
    
    
    
    priceView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2.0,CGRectGetMaxY(allUserBtn.frame) +10,Main_Screen_Width /2.0,70)];
    priceView.hidden = YES;
    priceView.backgroundColor = CELL_BORDER_COLOR;
    [self.view addSubview:priceView];
    
    UILabel *priceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10,Main_Screen_Width /2.0 - 20,20)];
    priceTitleLabel.text = @"设置听课费用";
    priceTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    priceTitleLabel.textAlignment = NSTextAlignmentCenter;
    priceTitleLabel.font = [UIFont systemFontOfSize:15];
    [priceView addSubview:priceTitleLabel];
    
    priceTextView = [[UITextField alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(priceTitleLabel.frame),Main_Screen_Width /2.0 - 40,30)];
    priceTextView.textColor = EL_TEXTCOLOR_DARKGRAY;
    priceTextView.font = [UIFont systemFontOfSize:15];
    priceTextView.tintColor = EL_TEXTCOLOR_GRAY;
    priceTextView.placeholder = @"最小金额1元";
    priceTextView.backgroundColor = [UIColor whiteColor];
    [priceView addSubview:priceTextView];
    
    
    
    
}

-(void)suoUserBtnClick{
    
    pswView.hidden = NO;
    priceView.hidden = YES;
    allUserTitleLabel.hidden = YES;
    selectIndex = 2;
    
    priceUserBtn.image = [UIImage imageNamed:@"course_set_price_n"];
    suoUserBtn.image = [UIImage imageNamed:@"course_set_psw_y"];
    allUserBtn.image = [UIImage imageNamed:@"course_set_free_n"];

}
-(void)allUserBtnClick{
    pswView.hidden = YES;
    priceView.hidden = YES;
    allUserTitleLabel.hidden = NO;
    selectIndex =1;
    priceUserBtn.image = [UIImage imageNamed:@"course_set_price_n"];
    suoUserBtn.image = [UIImage imageNamed:@"course_set_psw_n"];
    allUserBtn.image = [UIImage imageNamed:@"course_set_free_y"];
}

-(void)buyUserBtnClick{
    pswView.hidden = YES;
    priceView.hidden = NO;
    allUserTitleLabel.hidden = YES;
    selectIndex = 3;
    
    priceUserBtn.image = [UIImage imageNamed:@"course_set_price_y"];
    suoUserBtn.image = [UIImage imageNamed:@"course_set_psw_n"];
    allUserBtn.image = [UIImage imageNamed:@"course_set_free_n"];
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
