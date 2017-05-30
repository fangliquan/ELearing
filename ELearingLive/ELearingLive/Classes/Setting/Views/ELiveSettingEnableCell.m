//
//  ELiveSettingEnableCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingEnableCell.h"

@interface ELiveSettingEnableCell() {
    
    UILabel *titleLable;
    UISwitch *switchView;
}

@end

@implementation ELiveSettingEnableCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveSettingEnableCell";
    ELiveSettingEnableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveSettingEnableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void) configUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    titleLable = [[UILabel alloc]init];
    titleLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLable.font = [UIFont systemFontOfSize :EL_TEXTFONT_FLOAT_TITLE];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    switchView = [[UISwitch alloc] init];
    switchView.on = NO;
    switchView.onTintColor = [UIColor colorWithRed:0.075 green:0.816 blue:0.404 alpha:1.00];
    [switchView addTarget:self action:@selector(switchStateChanged) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo (self.contentView.mas_top).offset (8);
        make.height.equalTo(@40);
    }];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo (self.contentView.mas_top).offset (15);
    }];
    
}

-(void)setSettingEnableConfigModel:(ELiveSettingEnableConfigModel *)settingEnableConfigModel{
    _settingEnableConfigModel = settingEnableConfigModel;
    titleLable.text = settingEnableConfigModel.title;
    switchView.on = settingEnableConfigModel.isSetting;
}

-(void)switchStateChanged{
    if (self.eLiveSettingEnableHandler) {
        //eLiveSettingEnableHandler = !self.schoolAttendanceContent.isSetting;
        self.eLiveSettingEnableHandler(self.settingEnableConfigModel.type);
    }
}

+(CGFloat)heithForCell{
    return 50;
}


@end


@implementation ELiveSettingEnableConfigModel



@end
