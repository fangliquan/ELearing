//
//  ELiveMineFocusViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/3.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMineFocusViewController.h"
#import "ELiveFansFocusCell.h"
#include "ELivePersonHomeViewController.h"

#include "CloudManager+Teacher.h"
#import "UcTeacherModel.h"
#import "MJRefresh.h"
@interface ELiveMineFocusViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *followTeachers;

@property(nonatomic,strong) NSMutableArray *myfans;

@end

@implementation ELiveMineFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 0;
    [self configtableView];
    self.followTeachers = [NSMutableArray array];
    self.myfans = [NSMutableArray array];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)loadData{
    if (self.isFans){
        [self getMyFansData];
    }else{
        [self getMyFollerTeacher];
    }
}

-(void)getMyFansData{
    pageIndex ++;
    [[CloudManager sharedInstance]asyncMyFansWithPage:[NSString stringWithFormat:@"%ld",pageIndex] completion:^(UcMyFollowTeacherModel *ret, CMError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error ==nil) {
            // [self.followTeachers addObjectsFromArray:ret.list];
            [self converData:ret.list];
            if (ret.list.count <=0 && self.followTeachers.count <=0) {
                self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
            }
            if (ret.list.count <=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:self action:@selector(loadData)];
        }
    }];
}
-(void)getMyFollerTeacher{
    pageIndex ++;
    [[CloudManager sharedInstance]asyncMyFollowTeacherWithPage:[NSString stringWithFormat:@"%ld",pageIndex] completion:^(UcMyFollowTeacherModel *ret, CMError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error ==nil) {
           // [self.followTeachers addObjectsFromArray:ret.list];
            [self converData:ret.list];
            if (ret.list.count <=0 && self.followTeachers.count <=0) {
                self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
            }
            if (ret.list.count <=0) {
                  [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:self action:@selector(loadData)];
        }
    }];
}

-(void)converData:(NSArray*)ret{
    
    if (_isFans) {
        [_myfans addObjectsFromArray:ret];
    }else{
        [_followTeachers addObjectsFromArray:ret];
    }
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isFans) {
        return _myfans.count;
    }else{
        return _followTeachers.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    if (_isFans) {
        return [ELiveFansFocusCell heightForCellWithModel: self.myfans.count >indexPath.row ?self.myfans[indexPath.row]:nil];
    }else{
        return [ELiveFansFocusCell heightForCellWithModel: self.followTeachers.count >indexPath.row ?self.followTeachers[indexPath.row]:nil];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveFansFocusCell *cell = [ELiveFansFocusCell cellWithTableView:tableView];
    
    if (_isFans) {
         cell.myFollowTeacherItem = self.myfans.count >indexPath.row ?self.myfans[indexPath.row]:nil;
    }else{
         cell.myFollowTeacherItem = self.followTeachers.count >indexPath.row ?self.followTeachers[indexPath.row]:nil;
    }
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELivePersonHomeViewController *homeVc = [[ELivePersonHomeViewController alloc]init];
    [self.navigationController pushViewController:homeVc animated:YES];
}



#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

    
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
