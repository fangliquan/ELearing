//
//  ELiveCourseListViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveCourseListViewController : UITableViewController

@property(nonatomic,strong) NSString *teacherId;

@property(nonatomic,assign) BOOL isFormTeacher;

@property(nonatomic,strong) NSString *cateId;

@end
