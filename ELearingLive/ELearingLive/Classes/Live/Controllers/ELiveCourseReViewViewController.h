//
//  ELiveCourseReViewViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/6/22.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveCourseReViewViewController : UIViewController

@property(nonatomic,strong) NSString *courseId;
@property(nonatomic,strong) NSString *periodid;

@property(nonatomic,strong) UIViewController *viewController;
+ (void)presentFromViewController:(UIViewController *)viewController courseId:(NSString *)courseId  periodid:(NSString *)periodid completion:(void(^)())completion;


@end
