//
//  ELiveTabBar.m
//  ELearingLive
//
//  Created by microleo on 2017/6/17.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveTabBar.h"
#import "ELiveTeacherAddNewCourseViewController.h"
#import "ELiveCourseCalendarViewController.h"
#import "JXButton.h"
#define kCount 5

@implementation ELiveTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addComposeBtn];
    return self;
}

- (void)addComposeBtn {
    JXButton *composeBtn = [[JXButton alloc] init];
    [self addSubview:composeBtn];
    [composeBtn setImage:[UIImage imageNamed:@"tabbar_video"] forState:UIControlStateNormal];
    [composeBtn setTitle:@"直播" forState:UIControlStateNormal];
    [composeBtn setTitleColor:[UIColor colorWithRed:0.529 green:0.529 blue:0.529 alpha:1.00]forState:UIControlStateNormal];
    [composeBtn setTitleColor:EL_COLOR_RED forState:UIControlStateHighlighted];
    //composeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    //[composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_video"] forState:UIControlStateNormal];
    //[composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [composeBtn addTarget:self action:@selector(compose:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int i = 0;
    CGFloat w = Main_Screen_Width / kCount;
    CGFloat h = self.frame.size.height;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat x = w * (i < 2? i : (i + 1));
            CGFloat y = 0;
            subView.frame = CGRectMake(x, y, w, h);
            i++;
        } else if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(w * 2, 0, w, h);
        }
    }
}

- (void)compose:(id)sender {
    
    if ([[CloudManager sharedInstance].currentAccount.userLoginResponse.is_teacher isEqualToString:@"2"]) {
        ELiveTeacherAddNewCourseViewController *cvc = [[ELiveTeacherAddNewCourseViewController alloc] init];
        [[self getViewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:cvc] animated:YES completion:nil];
    }else{
        ELiveCourseCalendarViewController *courseVc = [[ELiveCourseCalendarViewController alloc]init];
        courseVc.isPushIn = YES;
        [[self getViewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:courseVc] animated:YES completion:nil];
    }

}

- (UIViewController *)getViewController {
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }
    return nil;
}

@end
