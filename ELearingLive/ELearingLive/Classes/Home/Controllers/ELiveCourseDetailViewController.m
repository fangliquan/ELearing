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
#import "ELiveAddEvaluateViewController.h"
#import "ELivePaymentView.h"
#import "AlipayManager.h"
#import "WechatPayManager.h"

#import "ELiveCourseReViewViewController.h"
#import "ELiveTeacherAddNewCourseViewController.h"
@interface ELiveCourseDetailViewController (){
    
}

@property (nonatomic, strong) NSMutableArray * pages;
@property (nonatomic, strong) NSMutableArray * pageTitles;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) ELiveCourseDetailHeaderView * headerView;

@property(nonatomic,strong) CourseDetailInfoModel *courseDetailInfoModel;
@property(nonatomic,strong) CourseBuyReasultModel *courseBuyReasultModel;

@property(nonatomic,strong)  ELiveCourseCatalogViewController * catelogVC;
@property(nonatomic,strong)  ELiveCourseIntroViewController * introVC;
@property(nonatomic,strong)  ELiveCourseEvaluateViewController * evaluteVC;

@property(nonatomic,strong) UIView * footerView;
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
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在加载..." toView:nil];
    [[CloudManager sharedInstance]asyncGetCourseDetailInfoWithCourseId:_courseId andPeriodid:_chapterid andMore:nil completion:^(CourseDetailInfoModel *ret, CMError *error) {
        [hud hide:YES];
        if (error ==nil) {
            self.courseDetailInfoModel= ret;
            [self configData];
        }
    }];
}

-(void)configData{
     self.headerView.courseDetailInfoModel = self.courseDetailInfoModel;
    self.introVC.courseDetailInfoModel = self.courseDetailInfoModel;
    self.catelogVC.courseId = self.courseId;
    self.evaluteVC.courseId = self.courseId;
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
    UIView * tempView = [keyWindow viewWithTag:1234561234];
    
    if (tempView) {
        [tempView removeFromSuperview];
    }
}


-(void)createFooterView{
    [self hideToolView];
    CGFloat viewH = 50;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 50, Main_Screen_Width, viewH)];
    footerView.tag = 1234561234;
    footerView.backgroundColor = [UIColor whiteColor];
    
    if ([self.courseDetailInfoModel.is_owner isEqualToString:@"y"]) {
        
        UIButton *rightView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, viewH)];
        [rightView setTitle:@"修改课程" forState:UIControlStateNormal];
        [rightView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightView.titleLabel.font = [UIFont systemFontOfSize:17];
        rightView.backgroundColor = EL_COLOR_RED;
        rightView.tag = 3;
        [rightView addTarget:self action:@selector(addCourseToMine:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:rightView];

    }else{
        CGFloat leftViewW = 120;
        
        UIButton *leftView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftViewW, viewH)];
        [leftView setTitle:@"收藏" forState:UIControlStateNormal];
        [leftView setTitleColor:EL_TEXTCOLOR_DARKGRAY forState:UIControlStateNormal];
        leftView.titleLabel.font = [UIFont systemFontOfSize:17];
        [leftView addTarget:self action:@selector(followCourseToMine:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:leftView];
        
        if ([self.courseDetailInfoModel.is_follow isEqualToString:@"y"]) {
            [leftView setTitle:@"取消收藏" forState:UIControlStateNormal];
            leftView.tag = 2;
        }else{
            [leftView setTitle:@"收藏" forState:UIControlStateNormal];
            leftView.tag = 1;
        }
        
        UIButton *rightView = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame), 0, Main_Screen_Width - leftViewW, viewH)];
        [rightView setTitle:@"参加本课程" forState:UIControlStateNormal];
        [rightView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightView.titleLabel.font = [UIFont systemFontOfSize:17];
        rightView.backgroundColor = EL_COLOR_RED;
        [rightView addTarget:self action:@selector(addCourseToMine:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:rightView];
        
        if ([self.courseDetailInfoModel.is_buy isEqualToString:@"y"]) {
            [rightView setTitle:@"观看课程" forState:UIControlStateNormal];
            rightView.tag = 2;
        }else{
            [rightView setTitle:@"参加本课程" forState:UIControlStateNormal];
            rightView.tag = 1;
        }
    }
 
    
    
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
    __unsafe_unretained typeof(self) unself = self;
    ELiveCourseIntroViewController * introVC = [[ELiveCourseIntroViewController alloc] initWithStyle:UITableViewStyleGrouped];
    introVC.userHomePageHandler =^(NSString *teacerId){
        ELivePersonHomeViewController *eliveVc = [[ELivePersonHomeViewController alloc]init];
        eliveVc.teacherId = teacerId;
        [unself.navigationController pushViewController:eliveVc animated:YES];
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
    evaluteVC.pageViewReloadHandler = ^{
        [unself.segmentedPager reloadData];
    };
    evaluteVC.addCourseEvaluateCommentHandler = ^{
        ELiveAddEvaluateViewController *addVc = [[ELiveAddEvaluateViewController alloc]init];
        addVc.courseId = unself.courseId;
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


-(void)followCourseToMine:(UIButton *)btn{
    BOOL follow = NO;
    if (btn.tag ==1) {//收藏
        follow = YES;
    }else if (btn.tag ==2){//取消收藏
        follow = NO;
    }
    [[CloudManager sharedInstance]asyncGetCourseFollowedWithCourseId:self.courseId andBool:follow completion:^(NSString *ret, CMError *error) {
        if (error == nil) {
            if (follow) {
                self.courseDetailInfoModel.is_follow = @"y";
            }else{
                self.courseDetailInfoModel.is_follow = @"n";
            }
            [MBProgressHUD showSuccess:follow ?@"收藏成功":@"取消成功" toView:nil];
            [self createFooterView];
        }
    }];
}

-(void)addCourseToMine:(UIButton *)btn{
    if (btn.tag ==1 || btn.tag ==2) {//参加课程
        
        if ([self.courseDetailInfoModel.course_type isEqualToString:@"3"]) {
            [UIAlertView bk_showAlertViewWithTitle:@"提示"message:@"请输入课程密码" style:UIAlertViewStyleSecureTextInput cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex ==1) {
                    UITextField *pwField = [alertView textFieldAtIndex:0];
                    [[CloudManager sharedInstance]asyncGetCourseNeedBuyWithCourseId:self.courseId andPwd:pwField.text completion:^(CourseBuyReasultModel *ret, CMError *error) {
                        if (error == nil) {
                            self.courseBuyReasultModel = ret;
                            [self converbuyReasult:ret];
                        }
                    }];
                }
            }];
        
        }else{
            [[CloudManager sharedInstance]asyncGetCourseNeedBuyWithCourseId:self.courseId andPwd:nil completion:^(CourseBuyReasultModel *ret, CMError *error) {
                if (error == nil) {
                    self.courseBuyReasultModel = ret;
                    [self converbuyReasult:ret];
                }
            }];
        }

    }else if (btn.tag ==3){//修改课程
        ELiveTeacherAddNewCourseViewController *editVc = [[ELiveTeacherAddNewCourseViewController alloc]init];
        editVc.isEdit = YES;
        editVc.courseId = self.courseId;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:editVc] animated:YES completion:nil];
       // [self.navigationController pushViewController:editVc animated:YES];
        
    }
//    
//    else if (){//观看课程
//        [ELiveCourseReViewViewController presentFromViewController:self courseId:self.courseId periodid:self.courseDetailInfoModel.periodid completion:^{
//            
//        }];
//        
//    }
}

-(void)converbuyReasult:(CourseBuyReasultModel *)ret{
    if ([ret.is_pay isEqualToString:@"n"]) {
        ELivePaymentView *paymentView = [[ELivePaymentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        paymentView.userSelectPayActionBlock=^(int payment){
            [self selectPayment:payment];
        };
        [paymentView show:ret];
        
    }else{
        [ELiveCourseReViewViewController presentFromViewController:self courseId:self.courseId periodid:self.courseDetailInfoModel.periodid completion:^{
            
        }];
        
    }
    
}
-(void)selectPayment:(int)payment {
    
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    [[CloudManager sharedInstance]asyncGetPaymentWithOrderId:self.courseBuyReasultModel.orderid andType:[NSString stringWithFormat:@"%d",payment] completion:^(NSObject *ret, CMError *error) {
        [hud hide:YES];
        if (error ==nil) {
            if (payment ==2) {
                CourseAliPayReasultModel *alipayModel = (CourseAliPayReasultModel*)ret;
                [AlipayManager paymentWithInfo:alipayModel.payinfo result:^(NSURLRequest *request, BOOL succeed) {
//                    if (succeed) {
//                        hud.labelText = @"支付成功";
//                        [hud hide:YES afterDelay:1];
//                        
//                    }else{
//                        hud.labelText = @"支付失败";
//                        [hud hide:YES afterDelay:1];
//                    }
                }];
            }else{
                CoursePayWeiXinReasultModel *weixinModel = (CoursePayWeiXinReasultModel*)ret;
                [WechatPayManager wechatPaymentWithInfo:weixinModel.payinfo result:^(NSURLRequest *request, BOOL succeed) {
//                    if (succeed) {
//                        hud.labelText = @"支付成功";
//                        [hud hide:YES afterDelay:1];
//                        
//                    }else{
//                        hud.labelText = @"支付失败";
//                        [hud hide:YES afterDelay:1];
//                    }
                }];
            }
        }
    }];

}



@end
