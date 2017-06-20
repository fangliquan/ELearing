//
//  BaseViewController.m
//  
//
//  Created by pc on 15/2/12.
//  Copyright (c) 2015年 fo. All rights reserved.
//

#import "BaseViewController.h"
//#import "MTA.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
//                                                                             style:UIBarButtonItemStyleDone
//                                                                            target:self action:nil];
}

- (void)didReceiveMemoryWarning {
    [[SDImageCache sharedImageCache] clearMemory]; // clear memory
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (pageName == nil) {
        pageName = [NSString stringWithFormat:@"%@", self.navigationItem.title];
    }
    //[MTA trackPageViewBegin:pageName];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (pageName == nil) {
        pageName = [NSString stringWithFormat:@"%@", self.navigationItem.title];
    }
   // [MTA trackPageViewEnd:pageName];
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return NO;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
