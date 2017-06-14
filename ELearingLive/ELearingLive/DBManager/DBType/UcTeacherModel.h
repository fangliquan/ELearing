//
//  UcTeacherModel.h
//  ELearingLive
//
//  Created by microleo on 2017/6/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "BaseModel.h"

@interface UcTeacherModel : BaseModel

@end

@interface UcMyFollowTeacherModel : BaseModel

@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *totalpage;
@property(nonatomic,strong) NSArray *list;
@end

@interface  UcMyFollowTeacherItem : NSObject

@property(strong,nonatomic) NSString *teacherid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *fans;
@property(nonatomic,strong) NSString *score;
@property(nonatomic,strong) NSString *students;
@property(nonatomic,strong) NSString *is_follow;
@property(nonatomic,strong) NSString *tags;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *intro;
@end


@interface TeacherInfoModel : BaseModel

@property(strong,nonatomic) NSString *teacherId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *fans;
@property(nonatomic,strong) NSString *score;
@property(nonatomic,strong) NSString *students;
@property(nonatomic,strong) NSString *is_follow;
@property(nonatomic,strong) NSString *intro;
@property(nonatomic,strong) NSString *tags;
@property(nonatomic,strong) NSString *profit;
@property(nonatomic,strong) NSString *follow_count;
@property(nonatomic,strong) NSString *share_url;
@property(nonatomic,strong) NSString *share_thumb;
@property(nonatomic,strong) NSString *share_title;
@property(nonatomic,strong) NSString *share_desp;
@end

@interface TeacherCourseListModel : BaseModel
@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *totalpage;

@property(nonatomic,strong) NSArray *list;
@end

@interface TeacherCourseListItem : NSObject

@property(strong,nonatomic) NSString *courseid;
@property(strong,nonatomic) NSString *periodid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *joins;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *teacher_name;

@end

@interface TeacherEvaluateListModel : BaseModel
@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *totalpage;

@property(nonatomic,strong) NSString *can_evaluate;
@property(nonatomic,strong) NSString *evaluate_id;
@property(nonatomic,strong) NSString *evaluate_content;
@property(nonatomic,strong) NSString *evaluate_score;
@property(nonatomic,strong) NSArray *list;
@end

@interface TeacherEvaluateListItem : NSObject

@property(strong,nonatomic) NSString *userid;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *score;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *time;

@end





