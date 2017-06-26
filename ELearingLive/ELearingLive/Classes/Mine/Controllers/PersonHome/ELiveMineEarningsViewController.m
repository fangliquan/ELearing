//
//  ELiveMineEarningsViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMineEarningsViewController.h"
#import "ELiveEarningsCell.h"
#import "UcCourseIndex.h"
#import "CloudManager+Teacher.h"
#import "MJRefresh.h"
@interface ELiveMineEarningsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
     NSInteger page;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *incomeArrays;

@end

@implementation ELiveMineEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page =0;
    _incomeArrays = [NSMutableArray array];
    [self configtableView];
    
    // Do any additional setup after loading the view.
}

-(void)getCourseIncomeData{
    page ++;
    [[CloudManager sharedInstance]asyncMyIncomingsWithPage:[NSString stringWithFormat:@"%ld",page] completion:^(MyIncomingsModel *ret, CMError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error ==nil) {
            // [self.followTeachers addObjectsFromArray:ret.list];
            [self converData:ret.list];
            if (ret.list.count <=0 && self.incomeArrays.count <=0) {
                self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
            }
            if (ret.list.count <=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:self action:@selector(getCourseIncomeData)];
        }
    }];
}

-(void)converData:(NSArray *)ret{
    [self.incomeArrays addObjectsFromArray:ret];
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
    
    return _incomeArrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveEarningsCell *cell = [ELiveEarningsCell cellWithTableView:tableView];
    cell.incomingsModelItem = self.incomeArrays.count >indexPath.row ?self.incomeArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getCourseIncomeData)];

    
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
