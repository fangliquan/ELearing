//
//  ELiveCreateCourseCell.h
//  ELearingLive
//
//  Created by microleo on 2017/6/16.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherCreateCourseInfo,CreateTimeModel,UcCourseCategireChildItem;
@interface ELiveCreateCourseCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;


@property(nonatomic,assign) BOOL  isCourseIntro;

@property(nonatomic,strong) TeacherCreateCourseInfo *createCourseInfo;

@end


@interface CreateTimeModel : NSObject

@property(nonatomic,strong) NSString *courseTime;
@property(nonatomic,strong) NSString *coursePId;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *courseTimestamp;

@property(nonatomic,assign) BOOL isAddCourse;


@end


@interface ELiveCreateCourseTimeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) CreateTimeModel *createTimeModel;

@property (nonatomic, copy) void (^addNewCourseTimeHandler)(void);

@property (nonatomic, copy) void (^deleteCourseTimeHandler)(CreateTimeModel *timeModel);

@end


@interface ELiveCreateAddCateCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) TeacherCreateCourseInfo *createCourseInfo;


@property (nonatomic, copy) void (^addCourseCateHandler)(UcCourseCategireChildItem *cateItem);

@end

@interface ELiveCreateAddCoverCell :UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) TeacherCreateCourseInfo *createCourseInfo;

@property (nonatomic, copy) void (^addCourseCoverHandler)(void);

@end
