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

@property(strong,nonatomic) NSString *teacherId;
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
