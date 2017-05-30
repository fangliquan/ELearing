//
//  ELiveNewsViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/3.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveHomeMainViewController.h"
#import "MJRefresh.h"
#import "LoopView.h"
#import "ELiveCourseDetailViewController.h"
#import "ELiveHomeClassesHeaderView.h"
#import "ELiewHomeGoodCourseCell.h"
#import "ELiveCourseListViewController.h"
#import "ELiveSearchCourseCateViewController.h"
#import "ELiveSearchViewController.h"
#import "GDSearchBar.h"
@interface ELiveHomeMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *newsArrays;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ELiveHomeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsArrays = [NSMutableArray array];
    for (int i = 0; i <10; i++) {
//        ELeaingNewsItemCellFrame *itemF = [[ELeaingNewsItemCellFrame alloc]init];
//        itemF.temp = @"aijda;kdf;af";
        [self.newsArrays addObject:@""];
    }
    [self configtableView];
    [self createHeaderView];
    [self setupNavigationBar];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    // Do any additional setup after loading the view.
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
    __weak ELiveHomeMainViewController *weakSelf = self;
    searchBar.searchBarShouldBeginEditingBlock = ^{
        ELiveSearchViewController *searchVC = [[ELiveSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    };
}


-(void)createHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat offsetY = 180;
    NSMutableArray *imageArrays  = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        [imageArrays addObject:@"http://www2.autoimg.cn/newsdfs/g13/M06/94/4E/640x320_0_autohomecar__wKjBylkNnG2AcWP1AAr60-uT8BI378.jpg"];
    }
    LoopView *headerLoopView =[[LoopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180) imageUrls:imageArrays loopPictures:imageArrays handler:^(UIViewController *vc) {
        
    }];
    
    [headerView addSubview:headerLoopView];
    CGFloat margingY = 8;
    offsetY +=margingY;
    CGFloat itemWidth = Main_Screen_Width/5.0;
    CGFloat itemHeight = itemWidth *68/98.0;
    CGFloat height = itemHeight + margingY + 20 + margingY;
    UIView *courseView = [[UIView alloc]initWithFrame:CGRectMake(0, offsetY, Main_Screen_Width, height)];
    courseView.backgroundColor = [UIColor whiteColor];
    for (int i = 1; i <6; i ++) {
        ELiveHomeClassesHeaderView *headerItem = [[ELiveHomeClassesHeaderView alloc]initWithFrame:CGRectMake((i -1) *itemWidth, margingY, itemWidth, itemWidth *68/98.0)];
        headerItem.titleStr = i ==5? @"更多":[NSString stringWithFormat:@"课程%d",i];
        headerItem.imageStr = [NSString stringWithFormat:@"home_tt_0%d_",i];
        headerItem.tag = i;
        headerItem.lookCourseListHandler =^(NSInteger index){
            if (index ==5) {
                [self moreCourseClick];
            }else{
                ELiveCourseListViewController *eliveVc = [[ELiveCourseListViewController alloc]init];
                eliveVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:eliveVc animated:YES];
            }

        };
        [courseView addSubview:headerItem];
    }
    
//    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, margingY + itemHeight + margingY *1.8, Main_Screen_Width - 20, 17)];
//    moreLabel.textAlignment = NSTextAlignmentRight;
//    moreLabel.text= @"更多课程>";
//    moreLabel.textColor = EL_TEXTCOLOR_GRAY;
//    moreLabel.font = [UIFont systemFontOfSize:14];
//    moreLabel.userInteractionEnabled = YES;
//    [moreLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreCourseClick)]];
    //[courseView addSubview:moreLabel];
    
    [headerView addSubview:courseView];
    offsetY +=height;
    offsetY += margingY;
    CGRect oldFrame = headerView.frame;
    oldFrame.size.height = offsetY;
    
    headerView.frame = oldFrame;
    self.tableView.tableHeaderView = headerView;
}

-(void)moreCourseClick{
    ELiveSearchCourseCateViewController *eclassVc = [[ELiveSearchCourseCateViewController alloc]init];
    eclassVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eclassVc animated:YES];
}

-(void)loadData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsArrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, Main_Screen_Width, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:bgView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, Main_Screen_Width, 18)];
    titleLabel.text = @"精品课程";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [bgView addSubview:titleLabel];
    
    return headerView ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    
    return [ELiewHomeGoodCourseCell cellHeightWithModel:@""];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiewHomeGoodCourseCell *cell = [ELiewHomeGoodCourseCell cellWithTableView:tableView];
   //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELiveCourseDetailViewController *detailVc = [[ELiveCourseDetailViewController alloc]init];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}



#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
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
