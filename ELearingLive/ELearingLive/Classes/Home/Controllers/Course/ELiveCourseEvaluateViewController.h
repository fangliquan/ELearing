//
//  ELiveCourseEvaluateViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveCourseEvaluateViewController : UIViewController

// 更新view frame 和 tableView frame
- (void)updateViewControllerFrame:(CGRect)frame;


@property(nonatomic,strong) NSString *courseId;

@property (nonatomic, copy) void (^addCourseEvaluateCommentHandler)(void);

@property (nonatomic, copy) void (^pageViewReloadHandler)(void);


-(void) reloadTableView;
@end
