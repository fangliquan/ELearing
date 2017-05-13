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
#import "ELiveClassificationCataViewController.h"
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
    // Do any additional setup after loading the view.
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
    CGFloat itemWidth = Main_Screen_Width/3.0;
    CGFloat itemHeight = itemWidth *68/98.0;
    CGFloat height = itemHeight + margingY + 20 + margingY *2.5;
    UIView *courseView = [[UIView alloc]initWithFrame:CGRectMake(0, offsetY, Main_Screen_Width, height)];
    courseView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i <3; i ++) {
        ELiveHomeClassesHeaderView *headerItem = [[ELiveHomeClassesHeaderView alloc]initWithFrame:CGRectMake(i *itemWidth, margingY, itemWidth, itemWidth *68/98.0)];
        headerItem.lookCourseListHandler =^(){
            ELiveCourseListViewController *eliveVc = [[ELiveCourseListViewController alloc]init];
            eliveVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:eliveVc animated:YES];
        };
        [courseView addSubview:headerItem];
    }
    
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, margingY + itemHeight + margingY *1.8, Main_Screen_Width - 20, 17)];
    moreLabel.textAlignment = NSTextAlignmentRight;
    moreLabel.text= @"更多课程>";
    moreLabel.textColor = EL_TEXTCOLOR_GRAY;
    moreLabel.font = [UIFont systemFontOfSize:14];
    moreLabel.userInteractionEnabled = YES;
    [moreLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreCourseClick)]];
    [courseView addSubview:moreLabel];
    
    [headerView addSubview:courseView];
    offsetY +=height;
    offsetY += margingY;
    CGRect oldFrame = headerView.frame;
    oldFrame.size.height = offsetY;
    
    headerView.frame = oldFrame;
    self.tableView.tableHeaderView = headerView;
}

-(void)moreCourseClick{
    ELiveClassificationCataViewController *eclassVc = [[ELiveClassificationCataViewController alloc]init];
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
