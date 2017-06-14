//
//  ELivePersonHomeViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/26.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELivePersonHomeViewController.h"

#import "ELiveHomeHeaderView.h"
#import "MXSegmentedPager+ParallaxHeader.h"
#import "ELiveCourseIntroViewController.h"
#import "ELiveCourseCatalogViewController.h"
#import "ELiveTeacherEvaluateViewController.h"
#import "ELiveAddEvaluateViewController.h"
#import "UcTeacherModel.h"
#import "CloudManager+Teacher.h"

#import "ELiveCourseListViewController.h"
#import "ELiveCourseDetailViewController.h"

@interface ELivePersonHomeViewController (){
    
}

@property (nonatomic, strong) NSMutableArray * pages;
@property (nonatomic, strong) NSMutableArray * pageTitles;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) ELiveTeacherHeaderView * headerView;


@property(nonatomic,strong)   ELiveCourseIntroViewController * introVC;
@property(nonatomic,strong)  ELiveTeacherEvaluateViewController * evaluteVC;
@property(nonatomic,strong) TeacherInfoModel *teacherInfoModel;
@property(nonatomic,strong) TeacherCourseListModel *teacherCourseListModel;
@property(nonatomic,strong) UIView *footerView;
@end

@implementation ELivePersonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitles = [NSMutableArray array];
    self.title = @"详情";
    
    [self configSegmentPager];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getTeacherInfo];
    [self getTeacherCourseData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self createFooterView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCurrentOffsetYNotification:) name:CurrentOffsetYNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideToolView];
    
}



-(void)hideToolView
{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (!keyWindow) {
        keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
    }
    UIView * tempView = [keyWindow viewWithTag:123456123456];
    
    if (tempView) {
        [tempView removeFromSuperview];
    }
}


-(void)createFooterView{
    
    [self hideToolView];
    if (![self.teacherId isEqualToString:[NSString stringWithFormat:@"%lld",[CloudManager sharedInstance].currentAccount.userLoginResponse.userId]]) {
        CGFloat viewH = 50;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 50, Main_Screen_Width, viewH)];
        footerView.tag = 123456123456;
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *rightView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, viewH)];
        if ([_teacherInfoModel.is_follow isEqualToString:@"y"]) {
            [rightView setTitle:@"取消关注" forState:UIControlStateNormal];
            rightView.backgroundColor = CELL_BORDER_COLOR;
        }else{
            [rightView setTitle:@"添加关注" forState:UIControlStateNormal];
            rightView.backgroundColor = EL_COLOR_RED;
        }
       
        [rightView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightView.titleLabel.font = [UIFont systemFontOfSize:17];
        
        rightView.tag = 3;
        [rightView addTarget:self action:@selector(addFollowTeacher) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:rightView];
        self.footerView = footerView;
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        if (!keyWindow) {
            keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
        }
        UIView * tempView = [keyWindow viewWithTag:1234561234];
        
        if (!tempView) {
            [keyWindow addSubview:self.footerView];
        }
        
    }
    
    
    
}

-(void)addFollowTeacher{
    
    BOOL follow = NO;
    if ([_teacherInfoModel.is_follow isEqualToString:@"y"]) {//取消关注
        follow = NO;
    }else {
        follow = YES;
    }
    
    [[CloudManager sharedInstance]asyncGetTeacherFollowedWithTeacherId:self.teacherId andBool:follow completion:^(NSString *ret, CMError *error) {
        if (error == nil) {
            if ([_teacherInfoModel.is_follow isEqualToString:@"y"]) {//取消关注
                _teacherInfoModel.is_follow = @"n";
            }else {
                 _teacherInfoModel.is_follow = @"y";
            }

           
            [self createFooterView];
        }
    }];
}

-(void)getTeacherInfo{
    [[CloudManager sharedInstance]asyncGetTeacherInfoWithId:self.teacherId completion:^(TeacherInfoModel *ret, CMError *error) {
        if (error ==nil) {
            self.teacherInfoModel = ret;
            [self configData];
        }
    }];
}

-(void)getTeacherCourseData{
    [[CloudManager sharedInstance]asyncGetTeacherCourseListWithId:_teacherId andPage:@"1" andPageSize:@"2" completion:^(TeacherCourseListModel *ret, CMError *error) {
        if (error == nil) {
            self.teacherCourseListModel = ret;
            [self configHeaderView];
        }
    }];
}

-(void)configData{
    self.headerView.teacherInfoModel = self.teacherInfoModel;
    self.introVC.teacherInfoModel = self.teacherInfoModel;
    self.evaluteVC.teacherId = self.teacherId;
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
    //[self configHeaderView];
    
}


-(void)configHeaderView{
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    CGFloat offsetY = [ELiveTeacherHeaderView teacherHeaderViewHeight:self.teacherCourseListModel.list.count];
    __unsafe_unretained typeof(self) unself = self;
    self.headerView = [[ELiveTeacherHeaderView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,offsetY)];
    self.headerView.teacherInfoModel = _teacherInfoModel;
    self.headerView.teacherCourseListModel = _teacherCourseListModel;
    self.headerView.teacherCourseItemBlock = ^(TeacherCourseListItem *courseItem) {
        ELiveCourseDetailViewController *vc = [[ELiveCourseDetailViewController alloc]init];
        vc.courseId = courseItem.courseid;
        vc.chapterid = courseItem.periodid;
        [unself.navigationController pushViewController:vc animated:YES];
    };
    self.headerView.lookMoreTeacherCourseBlock = ^{
        ELiveCourseListViewController *vc = [[ELiveCourseListViewController alloc]init];
        vc.teacherId = unself.teacherId;
        vc.isFormTeacher = YES;
        [unself.navigationController pushViewController:vc animated:YES];
    };
    [bgView addSubview:self.headerView];

     //bgView.frame = CGRectMake(0, 0, Main_Screen_Width, offsetY);
  
    [self.segmentedPager setParallaxHeaderView:bgView mode:VGParallaxHeaderModeTopFill height:offsetY];
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
    
    self.pageTitles = [NSMutableArray arrayWithArray: @[@"简介", @"评论"]];
    self.pages = [NSMutableArray array];
     __unsafe_unretained typeof(self) unself = self;
    ELiveCourseIntroViewController * introVC = [[ELiveCourseIntroViewController alloc] initWithStyle:UITableViewStyleGrouped];
    introVC.title = @"简介";
    [self.pages addObject:introVC];
    
    
    ELiveTeacherEvaluateViewController * evaluteVC = [[ELiveTeacherEvaluateViewController alloc] init];
    evaluteVC.title =@"评论";
    evaluteVC.addCourseEvaluateCommentHandler = ^{
        ELiveAddEvaluateViewController *addVc = [[ELiveAddEvaluateViewController alloc]init];
        addVc.teacherId = unself.teacherId;
        [unself.navigationController pushViewController:addVc animated:YES];
    };
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

    return circleVC;
}

@end
