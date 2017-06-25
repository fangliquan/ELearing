//
//  ELiveCourseReViewViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/22.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseReViewViewController.h"
#import "RootNavigationViewController.h"
@interface ELiveCourseReViewViewController ()

@end

@implementation ELiveCourseReViewViewController


+ (void)presentFromViewController:(UIViewController *)viewController courseId:(NSString *)courseId  periodid:(NSString *)periodid completion:(void(^)())completion{
    ELiveCourseReViewViewController *pushVc = [[ELiveCourseReViewViewController alloc]init];
    pushVc.courseId = courseId;
    pushVc.periodid = periodid;
    pushVc.viewController = viewController;
    RootNavigationViewController *naVC = [[RootNavigationViewController alloc] initWithRootViewController:pushVc];
    naVC.hidesBottomBarWhenPushed = YES;
    naVC.navigationBarHidden = YES;
    [viewController presentViewController: naVC animated:YES completion:completion];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
