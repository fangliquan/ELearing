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
#import "ELiveTeacherAddNewCourseViewController.h"

#import "FSCalendar.h"
@interface ELiveCourseCalendarViewController ()<UITableViewDelegate,UITableViewDataSource,FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>{
    NSUInteger page;
    void * _KVOContext;
}

@property(nonatomic,strong) NSMutableArray *teachArrays;

@property(nonatomic,strong) NSMutableArray *studyArrays;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) FSCalendar *calendar;
@property(nonatomic,strong) NSDate *currentDate;
@property(nonatomic,strong) TeacherMyCourseModel *teacherMyCourseModel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;


@end

@implementation ELiveCourseCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"课程";
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    page = 0;
    _currentDate = [NSDate date];
    self.teachArrays = [NSMutableArray array];
    self.studyArrays = [NSMutableArray array];
    [self createFsCalendar];
    [self configtableView];
    
    NSString *dateStr = [DateHelper stringFormatOfTime:[DateHelper timeIntervalOfChangedDate:_currentDate] style:WWTimeStringDateOfLineShortStyle];
    [self getCourseData:dateStr];
    if (self.isPushIn) {
        [self setupNav];
    }
    if ([[CloudManager sharedInstance].currentAccount.userLoginResponse.is_teacher isEqualToString:@"2"]) {
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开课" style:UIBarButtonItemStylePlain target:self action:@selector(startCourseClick)];
    }
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
}

-(void)startCourseClick{
    ELiveTeacherAddNewCourseViewController *cvc = [[ELiveTeacherAddNewCourseViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cvc] animated:YES completion:nil];
}
- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)createFsCalendar{
    CGFloat height = Main_Screen_Width * 300/414.0;
    self.calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, height)];
    self.calendar.backgroundColor = [UIColor whiteColor];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
//    self.calendar.appearance.titleWeekendColor = EL_TEXTCOLOR_DARKGRAY;
//    self.calendar.appearance.titleTodayColor = EL_COLOR_RED;
     self.calendar.appearance.headerTitleColor = EL_COLOR_RED;
//    self.calendar.appearance.titleFont = [UIFont systemFontOfSize:14];
//    self.calendar.appearance.headerTitleFont = [UIFont systemFontOfSize:17];
     self.calendar.appearance.headerDateFormat = @"yyyy-MM";
//    self.calendar.appearance.weekdayTextColor = EL_TEXTCOLOR_DARKGRAY;

    self.calendar.scope = FSCalendarScopeWeek;
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
   

    
 
    
    [self.view addSubview:self.calendar];
    
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 35)];
    [clickBtn addTarget:self action:@selector(toggleClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    
}


-(void)getCourseData:(NSString*)dateStr{
    
    [[CloudManager sharedInstance]asyncGetMyCourseCarlendarListWithDate:dateStr completion:^(TeacherMyCourseModel *ret, CMError *error) {
        if (error ==nil) {
            _teacherMyCourseModel = ret;
            [self changeCourseModel];
            if (ret.study_list.count <=0&&ret.teach_list.count<=0) {
                
                self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindViewWithType:ExceptionRemindStyle_Empty];
            }else{
                self.tableView.tableFooterView = [[UIView alloc]init];
            }
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

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
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
    if (section ==0) {
        return _teachArrays.count>0?40:0.001f;
    }else{
        return _studyArrays.count>0?40:0.001f;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, Main_Screen_Width, 20)];
    dateLabel.text = section ==0?@"开课列表":@"听课列表";
    dateLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    dateLabel.font = [UIFont systemFontOfSize:15];
    
    [headerView addSubview:dateLabel];
    
    if (section ==0) {
        return _teachArrays.count>0?headerView:nil;
    }else{
        return _studyArrays.count>0?headerView:nil;
    }

    
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.calendar.frame) + 10,Main_Screen_Width , Main_Screen_Height - CGRectGetMaxY(self.calendar.frame) - 10) style:UITableViewStyleGrouped];
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


- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    NSLog(@"%@ height :%f",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"),bounds.size.height);
    //CGRect cOldF = self.calendar.frame;
    
    if (calendar.scope==FSCalendarScopeWeek) {
        CGFloat fheight = 180;
        CGRect calendarF = self.calendar.frame;
        calendarF.size.height  = fheight;
        self.calendar.frame = calendarF;
        
        CGRect oldF = self.tableView.frame;
        oldF.origin.y = fheight +10;
        oldF.size.height = Main_Screen_Height-  fheight - 10;
        self.tableView.frame = oldF;
    }else{
        
        CGFloat fheight = 360;
        CGRect calendarF = self.calendar.frame;
        calendarF.size.height  = fheight;
        
        self.calendar.frame = calendarF;
        
        CGRect oldF = self.tableView.frame;
        oldF.origin.y = fheight +10;
        oldF.size.height = Main_Screen_Height - fheight - 10;
        self.tableView.frame = oldF;
    }


    // _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
   // [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    
    [self getCourseData:[self.dateFormatter stringFromDate:date]];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}



#pragma mark - Target actions

- (void)toggleClicked:(id)sender
{
    if (self.calendar.scope == FSCalendarScopeMonth) {
        [self.calendar setScope:FSCalendarScopeWeek animated:YES];
    } else {
        [self.calendar setScope:FSCalendarScopeMonth animated:YES];
    }
}

@end
