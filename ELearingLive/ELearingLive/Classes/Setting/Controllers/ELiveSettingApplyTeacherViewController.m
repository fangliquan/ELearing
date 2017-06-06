//
//  ELiveSettingApplyTeacherViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/1.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingApplyTeacherViewController.h"
#import "ELiveSettingUserInfoViewCell.h"
#import "ELiveSettingBindPhoneViewController.h"
#import "UserTruthInfo.h"
#import "CloudManager+Teacher.h"
@interface ELiveSettingApplyTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *section1Arrays;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UserTruthInfo *userTruthInfo;

@end

@implementation ELiveSettingApplyTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.section1Arrays = [NSMutableArray array];
    self.userTruthInfo = [[UserTruthInfo alloc]init];

    [self configtableView];
    [self loadApplyState];
    [self loadUserInfo];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];
}


-(void)createData{
    
    ELiveSettingUserInfoModel *settingModel11 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel11.type =ELive_Set_User_Name;
    settingModel11.title = @"姓名:";
    [self.section1Arrays addObject:settingModel11];
    
    
    ELiveSettingUserInfoModel *settingModel1 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel1.type =ELive_Set_User_ID;
    settingModel1.title = @"身份证:";
    [self.section1Arrays addObject:settingModel1];
    
    
    ELiveSettingUserInfoModel *settingModel2 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel2.type =ELive_Set_User_Phone;
    settingModel2.title = @"手机:";
    [self.section1Arrays addObject:settingModel2];
    
    
    ELiveSettingUserInfoModel *settingModel3 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel3.type =ELive_Set_User_Email;
    settingModel3.title = @"邮箱:";
    [self.section1Arrays addObject:settingModel3];
    
    
    ELiveSettingUserInfoModel *settingModel4 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel4.type =ELive_Set_User_Desp;
    settingModel4.title = @"个人介绍:";
    [self.section1Arrays addObject:settingModel4];
    
    [self.tableView reloadData];
}
-(void)loadApplyState{
    [[CloudManager sharedInstance]asyncUserIsApplyForTeacher:^(NSInteger ret, CMError *error) {
        if (ret ==0) {//is_teacher是否老师 2是老师  1审核中  0不是老师
            [self createData];
            [self createFooterView:YES];
        }else{
            [self createHeaderView:ret];
            [self createFooterView:NO];
        }
    }];
}
-(void)hiddenTextView{
    [self.view endEditing:YES];
}

-(void)createFooterView:(BOOL)enable{
    
    //    UIView *footerView = [UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 64, Main_Screen_Width, 64)
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, Main_Screen_Height - 54, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = enable? EL_COLOR_RED:CELL_BORDER_COLOR;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.enabled = enable;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(saveUserInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}


-(void)createHeaderView:(BOOL)IsTeacher{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
    UILabel *despLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, Main_Screen_Width - 40, 60)];
    despLabel.textColor = EL_TEXTCOLOR_GRAY;
    despLabel.text = IsTeacher?@"您已经是讲师了":@"您的讲师资格正在审核";
    despLabel.textAlignment = NSTextAlignmentCenter;
    despLabel.font = [UIFont systemFontOfSize:17];
    despLabel.numberOfLines = 0;
    
    [headerView addSubview:despLabel];
    self.tableView.tableHeaderView =headerView;

}

-(void)saveUserInfoClick{
//    for (ELiveSettingUserInfoModel *settingUserInfoModel in self.section1Arrays) {
//        if (settingUserInfoModel.type ==ELive_Set_User_Phone) {
//            self.userTruthInfo.mobile = settingUserInfoModel.content? settingUserInfoModel.content:[CloudManager sharedInstance].currentAccount.userLoginResponse.phone;
//        }else if (settingUserInfoModel.type ==ELive_Set_User_Name) {
//              self.userTruthInfo.real_name = settingUserInfoModel.content;
//        }else if (settingUserInfoModel.type ==ELive_Set_User_ID) {
//            self.userTruthInfo.idcard = settingUserInfoModel.content;
//        }else if (settingUserInfoModel.type ==ELive_Set_User_Email) {
//             self.userTruthInfo.email = settingUserInfoModel.content;
//        }else if (settingUserInfoModel.type ==ELive_Set_User_Desp) {
//              self.userTruthInfo.intro = settingUserInfoModel.content;
//        }
//    }
    
    if (self.userTruthInfo.real_name.length <=0) {
         [MBProgressHUD showError:@"输入姓名" toView:nil];
        return;
    }
    if (self.userTruthInfo.idcard.length <=0) {
        [MBProgressHUD showError:@"输入身份证" toView:nil];
        return;
    }
    if (self.userTruthInfo.mobile.length <=0) {
        [MBProgressHUD showError:@"输入手机号" toView:nil];
        return;
    }
    
    [[CloudManager sharedInstance]asyncUserApplyForTeacher:self.userTruthInfo completion:^(NSString *ret, CMError *error) {
        if (error ==nil) {
            [MBProgressHUD showSuccess:@"已提交" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:ret toView:nil];
        }
    }];
    
}

-(void)loadUserInfo{
    [[CloudManager sharedInstance]asyncUpdateUserTruthInfo:^(UserTruthInfo *ret, CMError *error) {
        if (error ==nil) {
            self.userTruthInfo = ret;
            [self.tableView reloadData];
        }else{
            //[MBProgressHUD showError:ret toView:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.section1Arrays.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
   ELiveSettingUserInfoModel *model = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    if (model.type ==ELive_Set_User_Desp) {
        return 260;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveSettingUserInfoViewCell *cell = [ELiveSettingUserInfoViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.settingUserInfoModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    cell.userTruthInfo = self.userTruthInfo;
    //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ELiveSettingUserInfoModel *settingUserInfoModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
//    if (settingUserInfoModel.type ==ELive_Set_User_Phone) {
//        ELiveSettingBindPhoneViewController *vc = [[ELiveSettingBindPhoneViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height -64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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


@end
