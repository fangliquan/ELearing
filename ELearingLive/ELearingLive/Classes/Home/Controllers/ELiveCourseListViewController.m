//
//  ELiveCourseListViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseListViewController.h"
#import "ELiveCourseItemCell.h"
#import "ELiveSearchCourseCateViewController.h"
#import "ELiveCourseDetailViewController.h"
#import "MJRefresh.h"
#import "UcTeacherModel.h"
#import "CloudManager+Teacher.h"
@interface ELiveCourseListViewController (){
     NSUInteger page;
}

@property(nonatomic,strong) NSMutableArray *courseArrays;
@end

@implementation ELiveCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configtableView];
    self.title = @"课程";
    page = 0;
    self.courseArrays = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_moreBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(searchMoreClick)];
    [self getTeacherCourseData];
}

-(void)getTeacherCourseData{
    page ++;
    [[CloudManager sharedInstance]asyncGetTeacherCourseListWithId:_teacherId andPage:[NSString stringWithFormat:@"%ld",page] andPageSize:nil completion:^(TeacherCourseListModel *ret, CMError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error == nil) {
            [self configData:ret];
            if (ret.list.count <=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (self.courseArrays.count <=0) {
                
                self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
            }
          
        }else{
            self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:self action:@selector(getTeacherCourseData)];
        }
    }];
}

-(void)configData:(TeacherCourseListModel *)ret{
    for (TeacherCourseListItem *courseItem in ret.list) {
        ELiveCourseItemCellFrame *cellFrame  = [[ELiveCourseItemCellFrame alloc]init];
        cellFrame.teacherCourseListItem  = courseItem;
        [_courseArrays addObject:cellFrame];
    }
    
    [self.tableView reloadData];
    
}


-(void)searchMoreClick{
    ELiveSearchCourseCateViewController *eClassVc = [[ELiveSearchCourseCateViewController alloc]init];
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
    return _courseArrays.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseItemCellFrame *cellFrem = self.courseArrays.count >indexPath.row?self.courseArrays[indexPath.row]:nil;
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseItemCell *cell = [ELiveCourseItemCell cellWithTableView:tableView];
    
    cell.eLiveCourseItemCellFrame = self.courseArrays.count >indexPath.row?self.courseArrays[indexPath.row]:nil;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseItemCellFrame *cellFrem = self.courseArrays.count >indexPath.row?self.courseArrays[indexPath.row]:nil;
    ELiveCourseDetailViewController *detailVc = [[ELiveCourseDetailViewController alloc]init];
    detailVc.courseId = cellFrem.teacherCourseListItem.courseid;
    detailVc.chapterid  = cellFrem.teacherCourseListItem.periodid;
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark- TableView Line Width
- (void )configtableView {

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getTeacherCourseData)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
