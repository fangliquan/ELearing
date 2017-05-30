//
//  ELiveSettingCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Setting_MineHome =0,
    Setting_CouserM,
    Setting_Focus_Teacher,
    Setting_Focus_Course,
    
    Setting_FaceBook,
    Setting_UpdateInfo,
    
    Setting_BindPhone  = 6,
    Setting_BindOtherApp,
    Setting_ComplateInfo,
    
    Setting_Notification = 9,
    
    Setting_Enable3G4GWatchVideo = 10,
    Setting_Enable3G4GDownLoad,
    Setting_ClearCache,
    Setting_AboutMe,
    
    Setting_Bind_WeiChat,
    Setting_Bind_Sina,
    Setting_Bind_Qq,

} ELiveSetingType;
@class ELiveSettingModel;

@interface ELiveSettingCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

@property(nonatomic,strong) ELiveSettingModel *eLiveSettingModel;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@end

@interface ELiveSettingModel : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) ELiveSetingType  type;
@end
