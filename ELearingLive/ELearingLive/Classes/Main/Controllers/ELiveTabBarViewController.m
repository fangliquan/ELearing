//
//  ELiveTabBarViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/3.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveTabBarViewController.h"
#import "ELiveHomeMainViewController.h"
#import "ELiveCourseCalendarViewController.h"
#import "ELiveCastMainViewController.h"
#import "ELiveMainMessageViewController.h"
#import "ELiveSettingMainViewController.h"

#import "ELiveNavigationViewController.h"
#import "ELiveTabBar.h"
@interface ELiveTabBarViewController ()<UITabBarControllerDelegate>


@property(nonatomic) UIInterfaceOrientationMask orietation;

@end

@implementation ELiveTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ELiveTabBar *tabBar = [[ELiveTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = EL_COLOR_Segment_Yellow;
    
    [self setupAllChildViewControllers];
}

-(void)roateLandscapeLeft
{
    NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    self.orietation = UIInterfaceOrientationMaskLandscapeLeft;
}

-(void)roatePortrait
{
    NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    self.orietation = UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self roatePortrait];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.orietation;
}

- (void)setupAllChildViewControllers
{
    ELiveHomeMainViewController *news = [[ELiveHomeMainViewController alloc] init];
    [self setupChildViewController:news title:@"主页" imageName:@"tabbar_news" selectedImageName:nil];
    //XAppDelegate.news = news;
    
    ELiveCourseCalendarViewController *focus = [[ELiveCourseCalendarViewController alloc] init];
    [self setupChildViewController:focus title:@"课程" imageName:@"tabbar_pics" selectedImageName:nil];
   // XAppDelegate.focus =focus;
    
//    ELiveCastMainViewController *picture = [[ELiveCastMainViewController alloc] init];
//    [self setupChildViewController:picture title:@"直播" imageName:@"tabbar_video" selectedImageName:nil];
//    //XAppDelegate.picture = picture;
    
    ELiveMainMessageViewController *about = [[ELiveMainMessageViewController alloc] init];
    [self setupChildViewController:about title:@"消息" imageName:@"tabbar_message" selectedImageName:nil];
    
    ELiveSettingMainViewController *setting = [[ELiveSettingMainViewController alloc] init];
    [self setupChildViewController:setting title:@"我" imageName:@"tabbar_about" selectedImageName:nil];
}


- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (selectedImageName != nil)
    {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    childVc.tabBarItem.image = image;
    
    childVc.title = title;
    
    ELiveNavigationViewController *nav = [[ELiveNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}





@end
