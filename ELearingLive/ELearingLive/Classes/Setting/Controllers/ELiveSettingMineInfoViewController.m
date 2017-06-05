//
//  ELiveSettingMineInfoViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingMineInfoViewController.h"
#import "ELiveSettingCell.h"
#import "ELiveSettingEnabelViewController.h"
#import "ELiveSettingBindPhoneViewController.h"
#import "ELiveSettingUserInfoViewController.h"
#import "ELiveSettingBindOtherAppViewController.h"
#import "ELiveSettingAboutViewController.h"

#import "CloudManager+Login.h"
@interface ELiveSettingMineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *section1Arrays;
@property(nonatomic,strong) NSMutableArray *section2Arrays;
@property(nonatomic,strong) NSMutableArray *section3Arrays;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation ELiveSettingMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.section1Arrays = [NSMutableArray array];
    self.section2Arrays = [NSMutableArray array];
    self.section3Arrays = [NSMutableArray array];
    
    for (int i =6; i <9; i ++) {
        ELiveSettingModel *settingModel = [[ELiveSettingModel alloc]init];
        settingModel.type = i;
        if (i ==6) {
            settingModel.title = @"绑定手机号";
        } else if (i ==7) {
            settingModel.title = @"社交账号绑定";
        }else if (i ==8) {
            settingModel.title = @"个人资料完善";
        }
    
        [self.section1Arrays addObject:settingModel];
    }
    ELiveSettingModel *settingModel9 = [[ELiveSettingModel alloc]init];
    settingModel9.type = 9;
    settingModel9.title = @"通知消息设置";
    [self.section2Arrays addObject:settingModel9];
    
    for (int i =10; i <14; i ++) {

        ELiveSettingModel *settingModel = [[ELiveSettingModel alloc]init];
        settingModel.type = i;
        if (i ==10) {
            settingModel.title = @"允许2G/3G/4G网络观看视频";
        } else if (i ==11) {
            settingModel.title = @"允许2G/3G/4G网络下载视频";
        }else if (i ==12) {
            settingModel.title = @"清除缓存";
        }else if (i ==13) {
            settingModel.title = @"关于";
        }
        [self.section3Arrays addObject:settingModel];
    }
    
    [self configtableView];
    [self createFooterView];
}

-(void)createFooterView{
    
//    UIView *footerView = [UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 64, Main_Screen_Width, 64)
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, Main_Screen_Height - 54, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = EL_COLOR_RED;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(quitAppClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

-(void)quitAppClick{

    [[CloudManager sharedInstance]asyncUserLogout:^(NSString *ret, CMError *error) {
        if (ret) {
            if (self.reloadCurrentLoginStateHandler) {
                self.reloadCurrentLoginStateHandler();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return self.section1Arrays.count;
    }else if(section ==1){
        return self.section2Arrays.count;
    }else{
        return self.section3Arrays.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveSettingCell *cell = [ELiveSettingCell cellWithTableView:tableView];
    if (indexPath.section ==0) {
        cell.eLiveSettingModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    }else if (indexPath.section ==1) {
        cell.eLiveSettingModel = self.section2Arrays.count >indexPath.row ?self.section2Arrays[indexPath.row]:nil;
    }else{
        cell.eLiveSettingModel = self.section3Arrays.count >indexPath.row ?self.section3Arrays[indexPath.row]:nil;
    }
    //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELiveSettingModel *settingModel;
    if (indexPath.section ==0) {
        settingModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    }else if (indexPath.section ==1) {
        settingModel = self.section2Arrays.count >indexPath.row ?self.section2Arrays[indexPath.row]:nil;

    }else{
        settingModel = self.section3Arrays.count >indexPath.row ?self.section3Arrays[indexPath.row]:nil;

    }
    if (settingModel.type == Setting_Notification ||settingModel.type == Setting_Enable3G4GDownLoad||settingModel.type == Setting_Enable3G4GWatchVideo) {
        ELiveSettingEnabelViewController *settingEVc = [[ELiveSettingEnabelViewController alloc]init];
        settingEVc.type = settingModel.type;
        [self.navigationController pushViewController:settingEVc animated:YES];
    }else if (settingModel.type ==Setting_BindPhone){
        ELiveSettingBindPhoneViewController *vc = [[ELiveSettingBindPhoneViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (settingModel.type == Setting_ComplateInfo){
        ELiveSettingUserInfoViewController *vc = [[ELiveSettingUserInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (settingModel.type == Setting_BindOtherApp){
        ELiveSettingBindOtherAppViewController *vc = [[ELiveSettingBindOtherAppViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (settingModel.type ==Setting_AboutMe){
        ELiveSettingAboutViewController *vc =[[ELiveSettingAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64 ) style:UITableViewStyleGrouped];
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
