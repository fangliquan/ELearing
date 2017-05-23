//
//  ELiveHomeClassesHeaderView.h
//  ELearingLive
//
//  Created by microleo on 2017/5/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveHomeClassesHeaderView : UIView

@property (nonatomic, copy) void (^lookCourseListHandler)(NSInteger index);

@property(nonatomic,strong) NSString *titleStr;

@property(nonatomic,strong) NSString *imageStr;
@end
