//
//  ELiveSearchCourseCateViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSearchCourseCateViewController.h"

#import "ELiveSearchViewController.h"
#import "ELiveMainCateViewCell.h"
#import "ELiveCourseListViewController.h"
#import "GDSearchBar.h"
#import "LoopView.h"
@interface ELiveSearchCourseCateViewController()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITableView *tableViewContent;
@property(nonatomic,strong) NSMutableArray *cateMainArray;

@end

@implementation ELiveSearchCourseCateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configtableView];
    [self configtableViewContent];
    [self setupNavigationBar];
    self.cateMainArray = [NSMutableArray array];
    
    
    
    
    for (int i =0;  i< 10;  i++) {
        ELiveMainCateModel *m1 = [[ELiveMainCateModel alloc]init];
        m1.title = @"企业管理";
        [self.cateMainArray addObject:m1];
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    // Do any additional setup after loading the view.
    [self createHeaderView];
}


-(void)createHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width *3.2/5.0, 0)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat offsetY = 110;
    NSMutableArray *imageArrays  = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        [imageArrays addObject:@"http://www2.autoimg.cn/newsdfs/g13/M06/94/4E/640x320_0_autohomecar__wKjBylkNnG2AcWP1AAr60-uT8BI378.jpg"];
    }
    LoopView *headerLoopView =[[LoopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width *3.2/5.0, 100) imageUrls:imageArrays loopPictures:imageArrays handler:^(UIViewController *vc) {
        
    }];
    
    [headerView addSubview:headerLoopView];
    
    CGRect oldFrame = headerView.frame;
    oldFrame.size.height = offsetY;
    
    headerView.frame = oldFrame;
    self.tableViewContent.tableHeaderView = headerView;
}


- (void)setupNavigationBar {
    GDSearchBar *searchBar = [GDSearchBar searchBarWithPlaceholder:@"搜科目 老师 课程"];
    UIImage* searchBarBg = [ELiveVCManagerHelper GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    //设置背景图片
    [searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    searchBar.backgroundImage = [UIImage imageNamed:@"search_bg.png"];
    //    searchBar.delegate = self;
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 5.0f;
        searchField.layer.borderColor = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.00].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    self.navigationItem.titleView = searchBar;
    __weak ELiveSearchCourseCateViewController *weakSelf = self;
    searchBar.searchBarShouldBeginEditingBlock = ^{
        ELiveSearchViewController *searchVC = [[ELiveSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag ==1) {
        return 1;
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag ==1) {
        return self.cateMainArray.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==1) {
        return 45;
    }else{
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView.tag ==1) {
        ELiveMainCateViewCell *cell = [ELiveMainCateViewCell cellWithTableView:tableView];
        
        cell.eLiveMainCateModel = self.cateMainArray.count >indexPath.row ?self.cateMainArray[indexPath.row]:nil;
        
        return cell;
    }else{
        ELiveMainCateViewCell *cell = [ELiveMainCateViewCell cellWithTableView:tableView];
        
        cell.eLiveMainCateModel = self.cateMainArray.count >indexPath.row ?self.cateMainArray[indexPath.row]:nil;
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==2) {
        ELiveCourseListViewController *detailVc = [[ELiveCourseListViewController alloc]init];
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark- TableView Line Width
- (void )configtableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*1.5/5.0, Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.tag =1;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*1.5, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*1.5, 0.0001)];
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

#pragma mark- TableView Line Width
- (void )configtableViewContent {
    
    self.tableViewContent = [[UITableView alloc]initWithFrame:CGRectMake(Main_Screen_Width*1.5/5.0, 64, Main_Screen_Width *3.5/5.0, Main_Screen_Height - 64) style:UITableViewStylePlain];
    self.tableViewContent.tag = 2;
    self.tableViewContent.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableViewContent.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableViewContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width *3.5/5.0, 0.0001)];
    self.tableViewContent.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width *3.5/5.0, 0.0001)];
    self.tableViewContent.dataSource = self;
    self.tableViewContent.delegate = self;
    
    
    [self.view addSubview:self.tableViewContent];
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
