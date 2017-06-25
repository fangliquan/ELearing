//
//  RootNavigationViewController.m
//  wwface
//
//  Created by pc on 8/31/14.
//  Copyright (c) 2014 fo. All rights reserved.
//

#import "RootNavigationViewController.h"
@interface RootNavigationViewController () //<UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL currentAnimating;

@end

@implementation RootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;//[self.visibleViewController supportedInterfaceOrientations];//
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}


@end
