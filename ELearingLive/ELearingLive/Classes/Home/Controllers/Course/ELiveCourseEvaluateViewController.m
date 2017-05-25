//
//  ELiveCourseEvaluateViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseEvaluateViewController.h"
#import "ELiveCourseEvaluateCell.h"
@interface ELiveCourseEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ELiveCourseEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configtableView];
    [self createHeaderView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewControllerFrame:(CGRect)frame {

}
-(void)createHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 20)];
    titleLabel.text = @"综合评论";
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:titleLabel];
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 15,Main_Screen_Width -2*70, 20)];
    commentLabel.text = @"(9345人评分)";
    commentLabel.textColor = EL_TEXTCOLOR_GRAY;
    commentLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:commentLabel];
    
    
    UILabel *commentBtn= [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80, 15, 70, 20)];
    commentBtn.text = @"添加评论";
    commentBtn.textColor = EL_COLOR_RED;
    commentBtn.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:commentBtn];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;//self.courseArrays.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseEvaluateCellFrame *cellFrem =[[ELiveCourseEvaluateCellFrame alloc]init];
    cellFrem.temp =@"  ";
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseEvaluateCell *cell = [ELiveCourseEvaluateCell cellWithTableView:tableView];
    
    ELiveCourseEvaluateCellFrame *cellFrem =[[ELiveCourseEvaluateCellFrame alloc]init];
    cellFrem.temp =@"  ";
    cell.cellFrame = cellFrem;
    // Configure the cell...
    
    return cell;
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
