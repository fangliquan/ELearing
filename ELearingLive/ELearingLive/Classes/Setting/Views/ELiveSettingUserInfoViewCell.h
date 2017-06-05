//
//  ELiveSettingUserInfoViewCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
   
    ELive_Set_User_Name =0,
    ELive_Set_User_Age,
    ELive_Set_User_Profession,
    ELive_Set_User_Commpany,
    ELive_Set_User_Phone,
    ELive_Set_User_ID,
    ELive_Set_User_Email,
    ELive_Set_User_Desp,
} ELive_Set_UserInfoType;
@class ELiveSettingUserInfoModel,UserTruthInfo;
@interface ELiveSettingUserInfoViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property(nonatomic,strong) UserTruthInfo *userTruthInfo;

@property(nonatomic,strong) ELiveSettingUserInfoModel *settingUserInfoModel;
@end

@interface ELiveSettingUserInfoModel : NSObject

@property(nonatomic,assign) ELive_Set_UserInfoType type;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *content;


@end
