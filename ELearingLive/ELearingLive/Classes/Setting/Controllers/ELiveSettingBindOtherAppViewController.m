//
//  ELiveSettingBindOtherAppViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingBindOtherAppViewController.h"
#import "ELiveSettingBindAppViewCell.h"
#import "ELiveSettingCell.h"
@interface ELiveSettingBindOtherAppViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *section1Arrays;

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation ELiveSettingBindOtherAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.section1Arrays = [NSMutableArray array];
    
    ELiveSettingBindAppModel *settingModel1 = [[ELiveSettingBindAppModel alloc]init];
    settingModel1.type =Setting_Bind_WeiChat;
    settingModel1.title = @"绑定微信";
    settingModel1.icon = @"login_weixin_icon";
    [self.section1Arrays addObject:settingModel1];
    
    
    ELiveSettingBindAppModel *settingModel2 = [[ELiveSettingBindAppModel alloc]init];
    settingModel2.type = Setting_Bind_Qq;
    settingModel2.title = @"绑定QQ";
    settingModel2.icon = @"login_qq_icon";
    [self.section1Arrays addObject:settingModel2];
    
    
    ELiveSettingBindAppModel *settingModel3 = [[ELiveSettingBindAppModel alloc]init];
    settingModel3.type =Setting_Bind_Sina;
    settingModel3.title = @"绑定微博";
    settingModel3.icon = @"login_sina_icon";
    [self.section1Arrays addObject:settingModel3];

    
    
    [self configtableView];
}

-(void)quitAppClick{
    
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveSettingBindAppViewCell *cell = [ELiveSettingBindAppViewCell cellWithTableView:tableView];
    
    cell.settingBindAppModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
    
    //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
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
