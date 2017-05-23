//
//  ELiveCourseListViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseListViewController.h"
#import "ELiveCourseItemCell.h"
#import "ELiveClassificationCataViewController.h"
#import "ELiveCourseDetailViewController.h"
@interface ELiveCourseListViewController ()

@end

@implementation ELiveCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configtableView];
    self.title = @"课程";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_moreBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(searchMoreClick)];
    
}
-(void)searchMoreClick{
    ELiveClassificationCataViewController *eClassVc = [[ELiveClassificationCataViewController alloc]init];
    eClassVc.title= @"检索";
    [self.navigationController pushViewController:eClassVc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseItemCellFrame *cellFrem =[[ELiveCourseItemCellFrame alloc]init];
    cellFrem.temp =@"  ";
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseItemCell *cell = [ELiveCourseItemCell cellWithTableView:tableView];
    
    ELiveCourseItemCellFrame *cellFrem =[[ELiveCourseItemCellFrame alloc]init];
    cellFrem.temp =@"  ";
    cell.eLiveCourseItemCellFrame = cellFrem;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseDetailViewController *detailVc = [[ELiveCourseDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshView)];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHistoryLiveCast)];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
