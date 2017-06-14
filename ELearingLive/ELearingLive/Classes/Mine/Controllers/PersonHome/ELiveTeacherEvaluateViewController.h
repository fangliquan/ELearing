//
//  ELiveTeacherEvaluateViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/6/14.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveTeacherEvaluateViewController : UIViewController

@property(nonatomic,strong) NSString *teacherId;

@property (nonatomic, copy) void (^addCourseEvaluateCommentHandler)(void);


@end
