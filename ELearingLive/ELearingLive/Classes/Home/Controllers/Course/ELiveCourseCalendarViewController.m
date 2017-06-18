//
//  ELiveCourseCalendarViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/18.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseCalendarViewController.h"
#import "ELiveCourseItemCell.h"
#import "ELiveCourseDetailViewController.h"
#import "MJRefresh.h"
#import "UcTeacherModel.h"
#import "CloudManager+Teacher.h"
#import "CloudManager+Course.h"
#import "DailyAttendanceHeaderView.h"
@interface ELiveCourseCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSUInteger page;
}

@property(nonatomic,strong) NSMutableArray *teachArrays;

@property(nonatomic,strong) NSMutableArray *studyArrays;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSDate *currentDate;
@property(nonatomic,strong) TeacherMyCourseModel *teacherMyCourseModel;

@end

@implementation ELiveCourseCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configtableView];
    self.title = @"课程";
    page = 0;
    _currentDate = [NSDate date];
    self.teachArrays = [NSMutableArray array];
    self.studyArrays = [NSMutableArray array];
    [self createHeaderView];
    
    [self getCourseData];

    
}

-(void)createHeaderView{
    DailyAttendanceHeaderView *headerView = [[DailyAttendanceHeaderView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
    headerView.getAttendanceDateHandler = ^(NSDate *date) {
        _currentDate = date;
        [self getCourseData];
    };
    self.tableView.tableHeaderView = headerView;
}


-(void)getCourseData{
    
    NSString *dateStr = [DateHelper stringFormatOfTime:[DateHelper timeIntervalOfChangedDate:_currentDate] style:WWTimeStringDateOfLineShortStyle];
    
    [[CloudManager sharedInstance]asyncGetMyCourseCarlendarListWithDate:dateStr completion:^(TeacherMyCourseModel *ret, CMError *error) {
        if (error ==nil) {
            _teacherMyCourseModel = ret;
            [self changeCourseModel];
        }
    }];
}


-(void)changeCourseModel{
    [self.teachArrays removeAllObjects];
    [self.teachArrays addObjectsFromArray:[self configData:self.teacherMyCourseModel.teach_list]];
    [self.studyArrays removeAllObjects];
    [self.studyArrays addObjectsFromArray:[self configData:self.teacherMyCourseModel.study_list]];
    
    [self.tableView reloadData];
    
}

-(NSMutableArray *)configData:(NSArray *)ret{
    
    NSMutableArray *arrayConvert = [NSMutableArray array];
    for (TeacherCourseListItem *courseItem in ret) {
        ELiveCourseItemCellFrame *cellFrame  = [[ELiveCourseItemCellFrame alloc]init];
        cellFrame.teacherCourseListItem  = courseItem;
        [arrayConvert addObject:cellFrame];
    }
    
    return arrayConvert;
    //[self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return _teachArrays.count;
    }else{
        return _studyArrays.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, Main_Screen_Width, 20)];
    dateLabel.text = [DateHelper stringFormatOfTime:[DateHelper timeIntervalOfChangedDate:_currentDate] style:WWTimeStringDateOfLineShortStyle];
    
    
    dateLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    dateLabel.font = [UIFont systemFontOfSize:15];
    
    [headerView addSubview:dateLabel];
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ELiveCourseItemCellFrame *cellFrem;
    
    if (indexPath.section ==0) {
        cellFrem = self.teachArrays.count >indexPath.row?self.teachArrays[indexPath.row]:nil;
    }else{
        
         cellFrem = _studyArrays.count >indexPath.row?_studyArrays[indexPath.row]:nil;
        
    }
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseItemCell *cell = [ELiveCourseItemCell cellWithTableView:tableView];
    
    ELiveCourseItemCellFrame *cellFrem;
    
    if (indexPath.section ==0) {
        cellFrem = self.teachArrays.count >indexPath.row?self.teachArrays[indexPath.row]:nil;
    }else{
        
        cellFrem = _studyArrays.count >indexPath.row?_studyArrays[indexPath.row]:nil;
    }
    cell.eLiveCourseItemCellFrame = cellFrem;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseItemCellFrame *cellFrem;
    
    if (indexPath.section ==0) {
        cellFrem = self.teachArrays.count >indexPath.row?self.teachArrays[indexPath.row]:nil;
    }else{
        
        cellFrem = _studyArrays.count >indexPath.row?_studyArrays[indexPath.row]:nil;
    }
    ELiveCourseDetailViewController *detailVc = [[ELiveCourseDetailViewController alloc]init];
    detailVc.courseId = cellFrem.teacherCourseListItem.courseid;
    detailVc.chapterid  = cellFrem.teacherCourseListItem.periodid;
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark- TableView Line Width
- (void )configtableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height- 64) style:UITableViewStyleGrouped];
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
