//
//  ELiveNewsDetialViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/7.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseDetailViewController.h"
#import "ELiveCourseDetailHeaderView.h"
#import "MXSegmentedPager+ParallaxHeader.h"
#import "ELiveCourseIntroViewController.h"
#import "ELiveCourseCatalogViewController.h"
#import "ELiveCourseEvaluateViewController.h"
#import "ELivePersonHomeViewController.h"
#import "CloudManager+Course.h"
#import "UcCourseIndex.h"
@interface ELiveCourseDetailViewController (){
    
}

@property (nonatomic, strong) NSMutableArray * pages;
@property (nonatomic, strong) NSMutableArray * pageTitles;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) ELiveCourseDetailHeaderView * headerView;

@property(nonatomic,strong) CourseDetailInfoModel *courseDetailInfoModel;

@property(nonatomic,strong)  ELiveCourseCatalogViewController * catelogVC;
@property(nonatomic,strong)  ELiveCourseIntroViewController * introVC;
@property(nonatomic,strong)  ELiveCourseEvaluateViewController * evaluteVC;
@end

@implementation ELiveCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitles = [NSMutableArray array];
    self.title = @"详情";

    [self configSegmentPager];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getCourseDatail];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)getCourseDatail{
    __unsafe_unretained typeof(self) unself = self;
    [[CloudManager sharedInstance]asyncGetCourseDetailInfoWithCateId:_courseId andPeriodid:nil andMore:nil completion:^(CourseDetailInfoModel *ret, CMError *error) {
        if (error ==nil) {
            unself.courseDetailInfoModel= ret;
            [unself configData];
        }
    }];
}

-(void)configData{
     self.headerView.courseDetailInfoModel = self.courseDetailInfoModel;
    self.introVC.courseDetailInfoModel = self.courseDetailInfoModel;
}

#pragma mark- Config SegmentPage
- (void)configSegmentPager {
    self.segmentedPager.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.pager.transitionStyle = MXPagerViewTransitionStyleScroll;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.820 green:0.161 blue:0.176 alpha:1.00], NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.820 green:0.161 blue:0.176 alpha:1.00];
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedPager.segmentedControlPosition = MXSegmentedControlPositionTop;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    
    self.segmentedPager.segmentedControl.selectedSegmentIndex = 0;
    [self configPages];
    [self configHeaderView];

}


-(void)configHeaderView{
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    self.headerView = [[ELiveCourseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width *9/16.0)];
    [bgView addSubview:self.headerView];
    [self.segmentedPager setParallaxHeaderView:bgView mode:VGParallaxHeaderModeTopFill height:CGRectGetHeight(self.headerView.frame)];
    [self addSegmentControlLine];

}

- (void)addSegmentControlLine {
    UILabel * topLine =  [[UILabel alloc] init];
    topLine.backgroundColor = CELL_BORDER_COLOR;

    UILabel * bottomLine =  [[UILabel alloc] init];
    bottomLine.backgroundColor = CELL_BORDER_COLOR;
    
    [self.segmentedPager.segmentedControl addSubview:topLine];
    [self.segmentedPager.segmentedControl addSubview:bottomLine];
    topLine.frame = CGRectMake(0, 0, Main_Screen_Width, 1);
    bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.segmentedPager.segmentedControl.frame) - 1, Main_Screen_Width, 1);
}

#pragma mark- config pages
- (void)configPages {

    self.pageTitles = [NSMutableArray arrayWithArray: @[@"简介", @"目录", @"评论"]];
    self.pages = [NSMutableArray array];
    
    ELiveCourseIntroViewController * introVC = [[ELiveCourseIntroViewController alloc] initWithStyle:UITableViewStyleGrouped];
    introVC.userHomePageHandler =^(NSString *teacerId){
        ELivePersonHomeViewController *eliveVc = [[ELivePersonHomeViewController alloc]init];
        [self.navigationController pushViewController:eliveVc animated:YES];
    };
    introVC.title = @"简介";
    [self.pages addObject:introVC];
    
    self.introVC = introVC;
    
    ELiveCourseCatalogViewController * catelogVC = [[ELiveCourseCatalogViewController alloc] initWithStyle:UITableViewStyleGrouped];
    catelogVC.title = @"目录";
    [self.pages addObject:catelogVC];
    self.catelogVC = catelogVC;
    
    ELiveCourseEvaluateViewController * evaluteVC = [[ELiveCourseEvaluateViewController alloc] init];
    evaluteVC.title =@"评论";
    [self.pages addObject:evaluteVC];
    
    self.evaluteVC = evaluteVC;
    
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : EL_COLOR_RED, NSFontAttributeName : [UIFont systemFontOfSize:15]};
    
    [self.segmentedPager reloadData];
    
    //[self.segmentedPager scrollToPageAtIndex:self.selectIndex animated:NO];
}


#pragma mark <MXPageControllerDataSource>
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    NSString *pageTitle = self.pageTitles[index];
    return pageTitle;
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return self.pageTitles.count;
}

- (UIViewController *)segmentedPager:(MXSegmentedPager *)segmentedPager viewControllerForPageAtIndex:(NSInteger)index {

    UIViewController * circleVC = self.pages.count > index ? self.pages[index] : nil;
    
    
    if ([circleVC isKindOfClass:[ELiveCourseEvaluateViewController class]]) {
        ELiveCourseEvaluateViewController *evaluateVc =  (ELiveCourseEvaluateViewController * )circleVC;
        [evaluateVc updateViewControllerFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44)];
    }else if ([circleVC isKindOfClass:[ELiveCourseCatalogViewController class]]) {
        ELiveCourseCatalogViewController *evaluateVc =  (ELiveCourseCatalogViewController * )circleVC;
        [evaluateVc updateViewControllerFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44)];
    }else if ([circleVC isKindOfClass:[ELiveCourseCatalogViewController class]]) {
        ELiveCourseCatalogViewController *evaluateVc =  (ELiveCourseCatalogViewController * )circleVC;
        [evaluateVc updateViewControllerFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44)];
    }
    return circleVC;
}


@end
