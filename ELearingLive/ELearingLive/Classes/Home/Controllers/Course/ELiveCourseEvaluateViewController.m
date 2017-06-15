//
//  ELiveCourseEvaluateViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseEvaluateViewController.h"
#import "ELiveCourseEvaluateCell.h"
#import "CloudManager+Course.h"
#import "UcCourseIndex.h"
#import "MJRefresh.h"
#import "CWStarRateView.h"
@interface ELiveCourseEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSUInteger page;
    UILabel *commentLabel;
    CWStarRateView *starRateView;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) CourseEvaluateListModel *courseEvaluateListModel;
@property(nonatomic,strong) NSMutableArray *evaluatesArray;
@end

@implementation ELiveCourseEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    page = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//-(void) reloadTableView{
//    [self.tableView reloadData];
//}
-(void)setCourseId:(NSString *)courseId{
    _courseId = courseId;
    self.evaluatesArray = [NSMutableArray array];
    [self configtableView];
    [self createHeaderView];
    [self getCourseEvaluate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCourseEvaluate{
    page ++;
    __unsafe_unretained typeof(self) unself = self;
    [[CloudManager sharedInstance]asyncGetCourseEvaluateListWithCourseId:_courseId andPage:[NSString stringWithFormat:@"%ld",page] completion:^(CourseEvaluateListModel *ret, CMError *error) {
        [unself.tableView.mj_footer endRefreshing];
        if (error ==nil) {
            unself.courseEvaluateListModel = ret;
            commentLabel.text = [NSString stringWithFormat:@"(%@评论)",_courseEvaluateListModel.count] ;
            starRateView.scorePercent =[_courseEvaluateListModel.evaluate_score floatValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [unself.tableView reloadData];
                [unself configData:ret];
            });

            
            if (ret.list.count <=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }];
}

-(void)configData:(CourseEvaluateListModel *)ret{
    for (CourseEvaluateListItem *commentItem in ret.list) {
        ELiveCourseEvaluateCellFrame *cellFrame = [[ELiveCourseEvaluateCellFrame alloc]init];
        cellFrame.courseEvaluateListItem = commentItem;
        [_evaluatesArray addObject:cellFrame];
    }
    [self.tableView reloadData];
    

    
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
    
    starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 12,100, 25) numberOfStars:5];
    starRateView.scorePercent =[_courseEvaluateListModel.evaluate_score floatValue];
    starRateView.allowIncompleteStar = YES;
    starRateView.hasAnimation = NO;
    starRateView.userInteractionEnabled = NO;
    [headerView addSubview:starRateView];
    
    commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starRateView.frame), 15,Main_Screen_Width -2*70, 20)];
    commentLabel.text = [NSString stringWithFormat:@"(%@评论)",_courseEvaluateListModel.count] ;
    commentLabel.textColor = EL_TEXTCOLOR_GRAY;
    commentLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:commentLabel];
    
    
    UILabel *commentBtn= [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80, 15, 70, 20)];
    commentBtn.text = @"评价课程";
    commentBtn.textColor = EL_COLOR_RED;
    commentBtn.font = [UIFont systemFontOfSize:15];
    commentBtn.userInteractionEnabled = YES;
    [commentBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentCourseClick)]];
    [headerView addSubview:commentBtn];
    
    self.tableView.tableHeaderView = headerView;
}

-(void)commentCourseClick{
    if (self.addCourseEvaluateCommentHandler) {
        self.addCourseEvaluateCommentHandler();
    }
}
#pragma mark - Table view data source
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _evaluatesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELiveCourseEvaluateCellFrame *cellFrem  = _evaluatesArray.count >indexPath.row ?_evaluatesArray[indexPath.row]:nil;
    return cellFrem.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveCourseEvaluateCell *cell = [ELiveCourseEvaluateCell cellWithTableView:tableView];
    
    cell.cellFrame =  _evaluatesArray.count >indexPath.row ?_evaluatesArray[indexPath.row]:nil;
    return cell;
}



#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getCourseEvaluate)];
    
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
