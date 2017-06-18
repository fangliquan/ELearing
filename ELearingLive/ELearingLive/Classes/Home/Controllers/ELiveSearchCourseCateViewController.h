//
//  ELiveSearchCourseCateViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UcCourseCategireChildItem;
@interface ELiveSearchCourseCateViewController : UIViewController

@property(nonatomic,assign) BOOL isSelctCate;
@property (nonatomic, copy) void (^selectedCateHandler)(UcCourseCategireChildItem *cateItem);

@end

