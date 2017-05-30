//
//  ELiveSettingEnableCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ELiveSettingCell.h"

@class ELiveSettingEnableConfigModel;

@interface ELiveSettingEnableCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property (nonatomic, copy) void (^eLiveSettingEnableHandler)(ELiveSetingType type);


@property(nonatomic,strong) ELiveSettingEnableConfigModel *settingEnableConfigModel;
@end

@interface ELiveSettingEnableConfigModel : NSObject


@property(nonatomic, assign) ELiveSetingType type;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *content;

@property(nonatomic, assign) BOOL isSetting;

@end
