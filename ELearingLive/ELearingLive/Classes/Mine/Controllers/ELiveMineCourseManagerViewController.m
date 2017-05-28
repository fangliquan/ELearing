//
//  ELiveMineCourseManagerViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMineCourseManagerViewController.h"
#import "MXSegmentedPager+ParallaxHeader.h"
#import "ELiveMineFocusViewController.h"
#import "ELiveMineFocusCourseViewController.h"
#import "ELiveMineShopCarCourseViewController.h"
@interface ELiveMineCourseManagerViewController (){
    
}

@property (nonatomic, strong) NSMutableArray * pages;
@property (nonatomic, strong) NSMutableArray * pageTitles;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ELiveMineCourseManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitles = [NSMutableArray array];
    self.title = @"详情";
    
    [self configSegmentPager];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [self.segmentedPager setParallaxHeaderView:bgView mode:VGParallaxHeaderModeTopFill height:0.001f];
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
    
    self.pageTitles = [NSMutableArray arrayWithArray: @[@"关注的讲师", @"关注的课程", @"购物车"]];
    self.pages = [NSMutableArray array];
    
    ELiveMineFocusViewController * introVC = [[ELiveMineFocusViewController alloc] init];
    introVC.title = @"关注的讲师";
    introVC.isFans = NO;
    [self.pages addObject:introVC];
    
    ELiveMineFocusCourseViewController * catelogVC = [[ELiveMineFocusCourseViewController alloc] init];
    catelogVC.title = @"关注的课程";
    [self.pages addObject:catelogVC];
    
    ELiveMineShopCarCourseViewController * evaluteVC = [[ELiveMineShopCarCourseViewController alloc] init];
    evaluteVC.title =@"购物车";
    [self.pages addObject:evaluteVC];
    
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
