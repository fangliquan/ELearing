//
//  ELiveEarningsCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveEarningsCell.h"
#import "UcCourseIndex.h"

@interface ELiveEarningsCell(){
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *earingLabel;
}

@end
@implementation ELiveEarningsCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveEarningsCell";
    ELiveEarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveEarningsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, Main_Screen_Width - 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"企业级管理";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(titleLabel.frame), Main_Screen_Width- 100, 20)];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.text = @"2014-09-08 12:00";
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:timeLabel];
    
    earingLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) +2, 20,90, 20)];
    earingLabel.font = [UIFont systemFontOfSize:18];
    earingLabel.textColor = EL_COLOR_RED;
    earingLabel.text = @"80￥";
    earingLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:earingLabel];
}

-(void)setIncomingsModelItem:(MyIncomingsModelItem *)incomingsModelItem{
    _incomingsModelItem = incomingsModelItem;
    titleLabel.text = incomingsModelItem.type;
    timeLabel.text = incomingsModelItem.time;
    earingLabel.text = incomingsModelItem.amount;
}
@end
