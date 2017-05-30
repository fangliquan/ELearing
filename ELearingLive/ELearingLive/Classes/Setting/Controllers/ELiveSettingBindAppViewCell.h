//
//  ELiveSettingBindAppViewCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELiveSettingCell.h"
@class ELiveSettingBindAppModel;
@interface ELiveSettingBindAppViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property(nonatomic,strong) ELiveSettingBindAppModel *settingBindAppModel;
@end

@interface ELiveSettingBindAppModel : NSObject

@property(nonatomic, assign) ELiveSetingType type;

@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;

@property(nonatomic, assign) BOOL isSetting;

@end
