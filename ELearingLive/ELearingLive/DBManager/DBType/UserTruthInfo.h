//
//  UserTruthInfo.h
//  ELearingLive
//
//  Created by microleo on 2017/6/5.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "BaseModel.h"

@interface UserTruthInfo : BaseModel

@property(copy,nonatomic) NSString *mobile;

@property(copy,nonatomic) NSString *real_name;

@property(copy,nonatomic) NSString *idcard;
@property(copy,nonatomic) NSString  *age;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *email;
@property(nonatomic,copy) NSString  *commpany;
@property(nonatomic,copy) NSString  *profession;

@end

@interface UserApplyTeacherState : BaseModel

@property(copy,nonatomic) NSString *is_teacher;//is_teacher是否老师 2是老师  1审核中  0不是老师


@end


