//
//  UcCourseIndex.h
//  ELearingLive
//
//  Created by microleo on 2017/6/10.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "BaseModel.h"

@interface UcCourseIndex : BaseModel

@end


@interface UcCourseCategireModel : BaseModel

@property(nonatomic,strong) NSString *catid;

@property(nonatomic,strong) NSString *name;
@end

@interface UcCourseCategireChildModel : BaseModel

@property(nonatomic,strong) NSString *childid;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *image;
@end

@interface CourseDetailInfoModel : BaseModel
@property(nonatomic,strong) NSString *courseid;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *thumb;

@property(nonatomic,strong) NSString *price;

@property(nonatomic,strong) NSString *desc;

@property(nonatomic,strong) NSString *score;

@property(nonatomic,strong) NSString *hits;

@property(nonatomic,strong) NSString *is_buy;
@property(nonatomic,strong) NSString *is_follow;
@property(nonatomic,strong) NSString *type;

@property(nonatomic,strong) NSString *teacherid;

@property(nonatomic,strong) NSString *teacehr_avatar;

@property(nonatomic,strong) NSString *teacher_name;

@property(nonatomic,strong) NSString *teacher_intro;

@end


@interface CourseChapterlistModel : BaseModel
@property(nonatomic,strong) NSString *courseid;
@property(nonatomic,strong) NSString *currentperiodid;

@property(nonatomic,strong) NSArray *list;
@end
@interface CourseChapterlistItemModel : NSObject

@property(nonatomic,strong) NSString *chapterid;
@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *period_count;
@property(nonatomic,strong) NSArray *periods;
@end


@interface CoursePeriodItemModel : NSObject
@property(nonatomic,strong) NSString *periodid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *is_download;
@property(nonatomic,strong) NSArray *is_free;
@end






