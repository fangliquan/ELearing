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
#import "CloudManager+Course.h"
#import "UcCourseIndex.h"
@interface ELiveSearchCourseCateViewController()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITableView *tableViewContent;
@property(nonatomic,strong) NSMutableArray *cateMainArray;
@property(nonatomic,strong) UcCourseCategireChildModel *categireChildModel;


@end

@implementation ELiveSearchCourseCateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configtableView];
    [self configtableViewContent];
    if (!self.isSelctCate) {
        [self setupNavigationBar];
    }

    self.cateMainArray = [NSMutableArray array];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self getCourseCategires];
}


-(void)getCourseCategires{
    [[CloudManager sharedInstance]asyncGetCourseCategiresInfo:^(UcCourseCategireModel *ret, CMError *error) {
        if (error ==nil) {
            [self.cateMainArray addObjectsFromArray:ret.list];
            [self.tableView reloadData];
            UcCourseCategireMainItem *firstItem = [ret.list firstObject];
            [self getCourseChildCategiresWithCateId:firstItem.catid];
        }
    }];
}

-(void)getCourseChildCategiresWithCateId:(NSString *)cateId{
    [[CloudManager sharedInstance]asyncGetCourseChildCategiresWithCateId:cateId completion:^(UcCourseCategireChildModel *ret, CMError *error) {
        if (error ==nil) {
            self.categireChildModel = ret;
            [self createHeaderView];
            [self.tableViewContent reloadData];
        }
    }];
}


-(void)createHeaderView{
    
    CGFloat viewWidth = Main_Screen_Width - Main_Screen_Width*1.5/5.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth,0)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat offsetAllY = 0;

    if (_categireChildModel.image && _categireChildModel.image.length >0) {
        offsetAllY +=110;
        UIImageView *headerLoopView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 100)];
        [headerLoopView setImageWithURL:[NSURL URLWithString:_categireChildModel.image] placeholderImage:EL_Default_Image];
        [headerView addSubview:headerLoopView];
    }

    CGFloat growthViewMaxWidth = viewWidth;
    
    offsetAllY = offsetAllY + 8;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    CGFloat marginX = 6;
    CGFloat childItemViewHight = 30;
    __unsafe_unretained typeof(self) unself = self;
    for (int i = 0; i < _categireChildModel.children.count;  i ++) {
        UcCourseCategireChildItem *readGrowthItem = _categireChildModel.children[i];
        CGFloat itemWidth = [ELiveCateChildrenView childrenViewWidth:readGrowthItem.name];
        offsetX += itemWidth;
        
        if (offsetX >= growthViewMaxWidth) {
            offsetX = itemWidth;
            offsetY +=1;
            offsetAllY +=childItemViewHight;
        }
        offsetX +=marginX;
        CGRect growthFrame = CGRectMake(offsetX - itemWidth, offsetAllY, itemWidth, childItemViewHight);
        
        ELiveCateChildrenView * growthItemView = [[ELiveCateChildrenView alloc]initWithFrame:growthFrame];
        growthItemView.courseCategireChildItem = readGrowthItem;
        //growthItemView.backgroundColor = [UIColor redColor];
        growthItemView.userInteractionEnabled = YES;
        growthItemView.courseCateItemHandler = ^(UcCourseCategireChildItem *childItem) {
//            ELiveCourseListViewController *vc = [[ELiveCourseListViewController alloc]init];
//            vc.
            if (unself.isSelctCate) {
                if (unself.selectedCateHandler) {
                    unself.selectedCateHandler(childItem);
                    [unself.navigationController popViewControllerAnimated:YES];
                }
            }else{
                ELiveCourseListViewController *detailVc = [[ELiveCourseListViewController alloc]init];
                detailVc.cateId = childItem.childid;
                [unself.navigationController pushViewController:detailVc animated:YES];
            }

        };
        [headerView addSubview:growthItemView];
    }

    offsetAllY +=8;
    
    
    CGRect oldFrame = headerView.frame;
    oldFrame.size.height = offsetAllY;
    
    headerView.frame = oldFrame;
    self.tableViewContent.tableHeaderView = headerView;
    [self.tableView reloadData];
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
        return 0;
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
        
        cell.courseCategireMainItem = self.cateMainArray.count >indexPath.row ?self.cateMainArray[indexPath.row]:nil;
        
        return cell;
    }else{
        ELiveMainCateViewCell *cell = [ELiveMainCateViewCell cellWithTableView:tableView];
        
        cell.courseCategireMainItem = self.cateMainArray.count >indexPath.row ?self.cateMainArray[indexPath.row]:nil;
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==2) {
  
    }else if (tableView.tag ==1){
       UcCourseCategireMainItem *mainItem =   self.cateMainArray.count >indexPath.row ?self.cateMainArray[indexPath.row]:nil;
        if (mainItem) {
            [self getCourseChildCategiresWithCateId:mainItem.catid];
        }
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
