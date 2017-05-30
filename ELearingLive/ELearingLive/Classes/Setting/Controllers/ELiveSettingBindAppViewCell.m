//
//  ELiveSettingBindAppViewCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingBindAppViewCell.h"

@interface ELiveSettingBindAppViewCell() {
    
    UILabel *titleLable;
    UIImageView *iconView;
    UILabel *sateLable;
}

@end

@implementation ELiveSettingBindAppViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"LiveSettingBindAppViewCell";
    ELiveSettingBindAppViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveSettingBindAppViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    iconView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:iconView];
    
    
    titleLable = [[UILabel alloc]init];
    titleLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLable.font = [UIFont systemFontOfSize :EL_TEXTFONT_FLOAT_TITLE];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    sateLable = [[UILabel alloc]init];
    sateLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    sateLable.font = [UIFont systemFontOfSize :EL_TEXTFONT_FLOAT_TITLE];
    sateLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:sateLable];

    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo (self.contentView.mas_top).offset (8);
        make.height.width.equalTo(@45);
    }];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(5);
        make.centerY.equalTo(iconView.mas_centerY);
    }];
    
    [sateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(iconView.mas_centerY);
    }];
    
}

-(void)setSettingBindAppModel:(ELiveSettingBindAppModel *)settingBindAppModel{
    _settingBindAppModel = settingBindAppModel;
    titleLable.text = settingBindAppModel.title;
    if (settingBindAppModel.isSetting) {
        sateLable.text = @"已绑定";
    }else{
        sateLable.text = @"未绑定";
    }
    iconView.image = [UIImage imageNamed:settingBindAppModel.icon];
}



+(CGFloat)heithForCell{
    return 50;
}


@end

@implementation ELiveSettingBindAppModel



@end
