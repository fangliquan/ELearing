//
//  ELeaingNewsItemCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/6.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELiveCourseItemCellFrame,TeacherCourseListItem;

@interface ELiveCourseItemCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

@property(nonatomic,strong) ELiveCourseItemCellFrame *eLiveCourseItemCellFrame;



@end

@interface ELiveCourseItemView : UIView

@property (nonatomic, copy) void (^teacherCourseItemBlock)(TeacherCourseListItem *courseItem);
@property(nonatomic,strong) ELiveCourseItemCellFrame *eLiveCourseItemCellFrame;


@end

@interface ELiveCourseItemCellFrame: NSObject

@property (nonatomic,strong)  TeacherCourseListItem *teacherCourseListItem;
@property (nonatomic, assign) CGRect  iconFrame;
@property (nonatomic, assign) CGRect  liveTagLFrame;
@property (nonatomic, assign) CGRect  titleLFrame;
@property (nonatomic, assign) CGRect  timeLFrame;
@property (nonatomic, assign) CGRect  couseNumLFrame;
@property (nonatomic, assign) CGRect  priceLFrame;
@property (nonatomic, assign) CGRect  joinNumFrame;
@property (nonatomic, assign) CGFloat cellHeight;

@property(nonatomic,assign) BOOL isMyFollow;
@end
