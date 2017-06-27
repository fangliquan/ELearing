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

@property(nonatomic,strong) NSArray *list;
@end

@interface UcCourseCategireMainItem : BaseModel

@property(nonatomic,strong) NSString *catid;

@property(nonatomic,strong) NSString *name;
@end


@interface UcCourseCategireChildModel : BaseModel

@property(nonatomic,strong) NSArray *children;

@property(nonatomic,strong) NSString *image;
@end

@interface UcCourseCategireChildItem : NSObject
@property(nonatomic,strong) NSString *childid;

@property(nonatomic,strong) NSString *name;
@end

@class CoursePeriodItemModel;
@interface CourseEditInfoModel : BaseModel
@property(nonatomic,strong) NSString *courseid;
@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *thumb;

@property(nonatomic,strong) NSString *price;

@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *course_type;

@property(nonatomic,strong) NSString *teacher_name;
@property(nonatomic,strong) NSString *tags;

@property(nonatomic,strong) NSArray *periods;

@end

@class CoursePlayDetailAdModel;
@interface CourseDetailInfoModel : BaseModel
@property(nonatomic,strong) NSString *courseid;
@property(nonatomic,strong) NSString *periodid;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *thumb;

@property(nonatomic,strong) NSString *price;

@property(nonatomic,strong) NSString *desc;

@property(nonatomic,strong) NSString *score;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *hits;
@property(nonatomic,strong) NSString *joins;
@property(nonatomic,strong) NSString *is_buy;
@property(nonatomic,strong) NSString *is_follow;
@property(nonatomic,strong) NSString *is_owner;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *course_type;

@property(nonatomic,strong) NSString *teacherid;

@property(nonatomic,strong) NSString *teacher_avatar;

@property(nonatomic,strong) NSString *teacher_name;
@property(nonatomic,strong) NSString *teacher_follows;
@property(nonatomic,strong) NSString *teacher_intro;
@property(nonatomic,strong) NSString *share_url;
@property(nonatomic,strong) NSString *share_thumb;
@property(nonatomic,strong) NSString *share_title;
@property(nonatomic,strong) NSString *share_desp;

@property(nonatomic,strong) NSString *second;
@property(nonatomic,strong) NSString *play;//播放地址
@property(nonatomic,strong) NSString *is_live;//是否直播

@property(nonatomic,strong) CoursePlayDetailAdModel *ad;

@end

@interface CoursePlayDetailAdModel : NSObject
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *title;
@end

@interface CourseChapterlistModel : BaseModel
@property(nonatomic,strong) NSString *courseid;
@property(nonatomic,strong) NSString *currentperiodid;

@property(nonatomic,strong) NSArray *list;
@end
@interface CourseChapterlistItemModel : NSObject

@property(nonatomic,strong) NSString *chapterid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *period_count;
@property(nonatomic,strong) NSArray *periods;
@end


@interface CoursePeriodItemModel : NSObject
@property(nonatomic,strong) NSString *periodid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *is_download;
@property(nonatomic,strong) NSString *is_free;
@end



@interface CourseEvaluateListModel : BaseModel

@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *totalpage;

@property(nonatomic,strong) NSArray *list;

@property(nonatomic,strong) NSString *can_evaluate;

@property(nonatomic,strong) NSString *evaluate_id;
@property(nonatomic,strong) NSString *evaluate_content;

@property(nonatomic,strong) NSString *evaluate_score;


@end

@interface CourseEvaluateListItem : NSObject
@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *score;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *content;
@end





@interface CourseBuyReasultModel : BaseModel

@property(nonatomic,strong) NSString *orderid;
@property(nonatomic,strong) NSString *need_pay;
@property(nonatomic,strong) NSString *total_amount;
@property(nonatomic,strong) NSString *is_pay;

@end



@interface CoursePayReasultModel : BaseModel

@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSDictionary *payinfo;

@property(nonatomic,strong) NSString *aliPay;
@property(nonatomic,strong) NSDictionary *weichatPay;
@end

@interface CoursePushInfoModel : BaseModel
@property(nonatomic,strong) NSString *push;
@property(nonatomic,strong) NSString *periodid;
@property(nonatomic,strong) NSString *share_url;
@property(nonatomic,strong) NSString *share_thumb;
@property(nonatomic,strong) NSString *share_title;
@property(nonatomic,strong) NSString *share_desp;
@end

@interface MyIncomingsModelItem : NSObject

@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *balance;
@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *time;

@end


@interface MyIncomingsModel : BaseModel
@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *pagecount;

@property(nonatomic,strong) NSArray *list;
@end
