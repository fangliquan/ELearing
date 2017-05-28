//
//  ELiveSettingCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingCell.h"

@interface ELiveSettingCell(){
    UILabel *titleLabel;
}

@end
@implementation ELiveSettingCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveSettingCell";
    ELiveSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


-(void)createUI{
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15.5, Main_Screen_Width - 20, 20)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.contentView addSubview:titleLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setELiveSettingModel:(ELiveSettingModel *)eLiveSettingModel{
    if (eLiveSettingModel) {
        _eLiveSettingModel = eLiveSettingModel;
        
        titleLabel.text = eLiveSettingModel.title;
    }
}

@end

@implementation ELiveSettingModel



@end
