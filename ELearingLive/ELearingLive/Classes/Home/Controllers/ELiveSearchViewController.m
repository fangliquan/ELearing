//
//  ELiveSearchViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/23.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSearchViewController.h"

#import "UISearchBar+Expand.h"
#import "MJRefresh.h"
#import "ELiveCourseItemCell.h"
#import "ELiveCourseDetailViewController.h"

#import "UcTeacherModel.h"
#import "CloudManager+Course.h"


@interface ELiveSearchViewController () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL isHeaderRefresh;
    int pageNumber;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSMutableArray *courseArrays;
@property (nonatomic, strong) NSString *keyword;

@end

@implementation ELiveSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 0;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.courseArrays = [NSMutableArray array];
    [self setupNavigationBar];
    [self configtableView];
}

- (void)setupNavigationBar {
    
    self.searchBar = [UISearchBar searchBarOfGeneralNavWithPlaceholder:@"搜科目 老师 课程" delegate:self canEdit:YES];
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    [_searchBar setBackgroundImage:searchBarBg];
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    _searchBar.backgroundImage = [UIImage imageNamed:@"search_bg.png"];
    _searchBar.delegate = self;
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 5.0f;
        searchField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    self.navigationItem.titleView = self.searchBar;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchGoods) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    
    
}

- (void)returnAction {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchGoods {
    if([self.searchBar.text length] == 0) {
        //[VAMBProgressHUD showBriefAlert:@"请输入产品"];
        
    }else {
        self.keyword = self.searchBar.text;
        [self.searchBar resignFirstResponder];
        [self headerRefreshView];
    }
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(void)headerRefreshView{
    isHeaderRefresh = NO;
    [self loadCourseList];
}

-(void)loadCourseList{
    
    if (isHeaderRefresh) {
        pageNumber = 0;
    }
    pageNumber ++;
   
    [[CloudManager sharedInstance]asyncSearchCourseWithKeyword:self.searchBar.text andPage:[NSString stringWithFormat:@"%d",pageNumber] completion:^(TeacherCourseListModel *ret, CMError *error) {
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
            self.tableView.tableFooterView = [WWExceptionRemindManager exceptionRemindView_LoadfailWithTarget:self action:@selector(loadCourseList)];
        }
    }];
    
}

-(void)configData:(TeacherCourseListModel *)ret{
    for (TeacherCourseListItem *courseItem in ret.list) {
        ELiveCourseItemCellFrame *cellFrame  = [[ELiveCourseItemCellFrame alloc]init];
        cellFrame.teacherCourseListItem  = courseItem;
        cellFrame.isMyFollow = YES;
        [_courseArrays addObject:cellFrame];
    }
    
    [self.tableView reloadData];
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshView)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCourseList)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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


#pragma mark- UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchGoods];
}




@end
