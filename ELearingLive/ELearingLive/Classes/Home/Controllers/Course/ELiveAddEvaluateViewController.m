//
//  ELiveAddEvaluateViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/12.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveAddEvaluateViewController.h"
#import "CWStarRateView.h"
#import "PHTextView.h"
#import "CloudManager+Teacher.h"
#import "CloudManager+Course.h"
@interface ELiveAddEvaluateViewController ()<CWStarRateViewDelegate>{
    CWStarRateView *starRateView;
    UIScrollView *bgScroll;
    PHTextView *evaluateContent ;
}

@property(nonatomic,assign) CGFloat newScorePercent;
@end

@implementation ELiveAddEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加评论";
    _newScorePercent = 3;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitEvaluate)];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    bgScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScroll];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgScroll addSubview:headerView];
    
    UILabel *courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,30, 75, 20)];
    courseTitleLabel.text = @"添加评分:";
    courseTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseTitleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:courseTitleLabel];
    
    starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(courseTitleLabel.frame) + 5, 25,120, 30) numberOfStars:5];
    starRateView.scorePercent = 3.0;
    starRateView.allowIncompleteStar = YES;
    starRateView.hasAnimation = NO;
    starRateView.delegate = self;
    [headerView addSubview:starRateView];
    
    
    UILabel *courseMLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(courseTitleLabel.frame) + 20,Main_Screen_Width - 20, 20)];
    courseMLabel.text = @"评论内容:";
    courseMLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseMLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:courseMLabel];
    
    
    evaluateContent = [[PHTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(courseMLabel.frame)+ 5, Main_Screen_Width - 20, Main_Screen_Width - CGRectGetMaxY(courseMLabel.frame) - 20)];
    evaluateContent.tintColor = EL_TEXTCOLOR_GRAY;
    evaluateContent.placeholder = @"请输入评论内容";
    evaluateContent.font = [UIFont systemFontOfSize:15];
    evaluateContent.backgroundColor = [UIColor whiteColor];
    evaluateContent.textColor = EL_TEXTCOLOR_DARKGRAY;
    [headerView addSubview:evaluateContent];
    
    
    bgScroll.contentSize = CGSizeMake(Main_Screen_Width,CGRectGetMaxY(evaluateContent.frame) + 10);
    
    bgScroll.userInteractionEnabled = YES;
    [bgScroll addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenText)]];
    
    
    [self.view addSubview:bgScroll];

    

}


-(void)hiddenText{
    [self.view endEditing:YES];
}
-(void)submitEvaluate{
     [self.view endEditing:YES];
    
    if (evaluateContent.text.length <=0) {
        [MBProgressHUD showError:@"添加评论内容" toView:nil];
        return;
    }
    
    if (_isTeacherEvaluate) {
        [[CloudManager sharedInstance] asyncTeacherAddEvaluate:self.teacherId andContent:evaluateContent.text andScore:[NSString stringWithFormat:@"%0.2f",_newScorePercent] completion:^(NSString *ret, CMError *error) {
            if (error == nil) {
                [MBProgressHUD showSuccess:@"评论成功" toView:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                //[MBProgressHUD showError:@"评论失败" toView:nil];
            }
        }];
    }else{
        [[CloudManager sharedInstance] asyncAddCourseEvaluateListWithCourseId:self.courseId andContent:evaluateContent.text andScore:[NSString stringWithFormat:@"%0.2f",_newScorePercent] completion:^(NSString *ret, CMError *error) {
            if (error == nil) {
                [MBProgressHUD showSuccess:@"评论成功" toView:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                //[MBProgressHUD showError:@"评论失败" toView:nil];
            }
        }];
    }

    
}

-(void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
    _newScorePercent = newScorePercent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
