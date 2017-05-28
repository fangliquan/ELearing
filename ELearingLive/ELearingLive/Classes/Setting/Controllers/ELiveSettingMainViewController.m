//
//  ELiveSettingMainViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/3.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingMainViewController.h"
#import "ELiveSettingHeaderView.h"
#import "ELiveSettingCell.h"

#import "ELivePersonHomeViewController.h"
#import "ELiveMineFocusViewController.h"
#import "ELiveMineFocusCourseViewController.h"
#import "ELiveMineCourseManagerViewController.h"

#import "ELiveSettingFaceBackViewController.h"
#import "ELiveSettingMineInfoViewController.h"

@interface ELiveSettingMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *section1Arrays;
@property(nonatomic,strong) NSMutableArray *section2Arrays;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) ELiveSettingHeaderView *headerView;
@end

@implementation ELiveSettingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.section1Arrays = [NSMutableArray array];
    self.section2Arrays = [NSMutableArray array];
    
    for (int i =0; i <4; i ++) {
        ELiveSettingModel *settingModel = [[ELiveSettingModel alloc]init];
        settingModel.type = i;
        if (i ==0) {
            settingModel.title = @"我的主页";
        } else if (i ==1) {
            settingModel.title = @"课程管理";
        }else if (i ==2) {
            settingModel.title = @"关注的讲师";
        }else if (i ==3) {
            settingModel.title = @"关注的课程";
        }
        [self.section1Arrays addObject:settingModel];
    }
    for (int i =0; i <2; i ++) {
        ELiveSettingModel *settingModel = [[ELiveSettingModel alloc]init];
        
        if (i ==0) {
            settingModel.type = 4;
            settingModel.title = @"意见反馈";
        } else if (i ==1) {
            settingModel.type = 5;
            settingModel.title = @"设置和资料";
        }
        [self.section2Arrays addObject:settingModel];
    }
    
    [self configtableView];
    [self createHeaderView];

}



-(void)createHeaderView{
    
    self.headerView = [[ELiveSettingHeaderView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width *9/16.0)];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return self.section1Arrays.count;
    }else{
        return self.section2Arrays.count;
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
    }else{
        cell.eLiveSettingModel = self.section2Arrays.count >indexPath.row ?self.section2Arrays[indexPath.row]:nil;
    }
    //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELiveSettingModel *settingModel;
    if (indexPath.section ==0) {
        settingModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    }else{
        settingModel = self.section2Arrays.count >indexPath.row ?self.section2Arrays[indexPath.row]:nil;
    }
    if (settingModel.type ==Setting_MineHome) {
        ELivePersonHomeViewController *homeVc = [[ELivePersonHomeViewController alloc]init];
        [self.navigationController pushViewController:homeVc animated:YES];
    }else if (settingModel.type ==Setting_Focus_Teacher){
        ELiveMineFocusViewController *focusVc = [[ELiveMineFocusViewController alloc]init];
        [self.navigationController pushViewController:focusVc animated:YES];
    }else if(settingModel.type == Setting_Focus_Course){
        ELiveMineFocusCourseViewController *courseVc = [[ELiveMineFocusCourseViewController alloc]init];
        [self.navigationController pushViewController:courseVc animated:YES];
    }else if(settingModel.type == Setting_CouserM){
        ELiveMineCourseManagerViewController *courseVc = [[ELiveMineCourseManagerViewController alloc]init];
        [self.navigationController pushViewController:courseVc animated:YES];
    }else if(settingModel.type == Setting_FaceBook){
        ELiveSettingFaceBackViewController *courseVc = [[ELiveSettingFaceBackViewController alloc]init];
        [self.navigationController pushViewController:courseVc animated:YES];
    }else if(settingModel.type == Setting_UpdateInfo){
        ELiveSettingMineInfoViewController *courseVc = [[ELiveSettingMineInfoViewController alloc]init];
        [self.navigationController pushViewController:courseVc animated:YES];
    }
    
}



#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height ) style:UITableViewStyleGrouped];
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
