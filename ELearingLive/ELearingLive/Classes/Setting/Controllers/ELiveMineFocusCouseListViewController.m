//
//  ELiveMineFocusCouseListViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/18.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMineFocusCouseListViewController.h"
#import "ELiveMineFocusCourseViewController.h"
#import "ELiveSettingCell.h"

@interface ELiveMineFocusCouseListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *section1Arrays;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation ELiveMineFocusCouseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.section1Arrays = [NSMutableArray array];

 
    ELiveSettingModel *settingModel = [[ELiveSettingModel alloc]init];
    settingModel.type = 1;
    settingModel.title = @"我听过的课程";
    [self.section1Arrays addObject:settingModel];
    

    ELiveSettingModel *settingModel9 = [[ELiveSettingModel alloc]init];
    settingModel9.type = 2;
    settingModel9.title = @"我关注的课程";
    [self.section1Arrays addObject:settingModel9];
    
    [self configtableView];

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
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveSettingCell *cell = [ELiveSettingCell cellWithTableView:tableView];

    cell.eLiveSettingModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELiveSettingModel *settingModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    ELiveMineFocusCourseViewController *courseVc = [[ELiveMineFocusCourseViewController alloc]init];
    courseVc.title = @"我的课程";
    courseVc.showMoreBtn = NO;
    [self.navigationController pushViewController:courseVc animated:YES];

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
