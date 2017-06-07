//
//  ELiveHomeClassesHeaderView.h
//  ELearingLive
//
//  Created by microleo on 2017/5/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveHomeClassesHeaderView : UIView

@property (nonatomic, copy) void (^lookCourseListHandler)(IndexCatesModel *model);

@property(nonatomic,strong) IndexCatesModel *cateModel;
@end
