//
//  ELiveSettingCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Setting_MineHome,
    Setting_CouserM,
    Setting_Focus_Teacher,
    Setting_Focus_Course,
    
    Setting_FaceBook,
    Setting_UpdateInfo,
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
