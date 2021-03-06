//
//  ELiveCourseCatalogViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseCatalogViewController.h"
#import "ELiveCourseCatalogCell.h"
#import "ELiveCourseDetailViewController.h"
#import "UcCourseIndex.h"

#import "CloudManager+Course.h"
@interface ELiveCourseCatalogViewController (){
    
}
@property(nonatomic,strong) NSMutableArray *courseArrays;
@property(nonatomic,strong) CourseChapterlistModel *chapterlistModel;
@end

@implementation ELiveCourseCatalogViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.courseArrays = [NSMutableArray array];
    [self configtableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setCourseId:(NSString *)courseId{
    _courseId = courseId;
    [self getCourseData];
}

-(void)getCourseData{
    [[CloudManager sharedInstance]asyncGetCourseChapterListWithCourseId:self.courseId completion:^(CourseChapterlistModel *ret, CMError *error) {
        if (error ==nil) {
            self.chapterlistModel = ret;
            [self configData];
            [self.tableView reloadData];
        }
    }];
}

-(void)configData{
    for (CourseChapterlistItemModel *itemModel in self.chapterlistModel.list) {
        ELiveCourseCatalogCellFrame *cellFrem =[[ELiveCourseCatalogCellFrame alloc]init];
        cellFrem.chapterlistItemModel = itemModel;
        [self.courseArrays addObject:cellFrem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewControllerFrame:(CGRect)frame {

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.courseArrays.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseCatalogCellFrame *cellFrem = self.courseArrays.count >indexPath.row?self.courseArrays[indexPath.row]:nil;
    
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseCatalogCell *cell = [ELiveCourseCatalogCell cellWithTableView:tableView];
    cell.cellFrame = self.courseArrays.count >indexPath.row?self.courseArrays[indexPath.row]:nil;
    
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001f)];
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
