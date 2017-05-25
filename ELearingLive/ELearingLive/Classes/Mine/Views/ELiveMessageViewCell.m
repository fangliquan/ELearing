//
//  ELiveMessageViewCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/25.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMessageViewCell.h"

@interface ELiveMessageViewCell(){
    UILabel *titleLabel;
    UIImageView *iconView;
}

@end
@implementation ELiveMessageViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveMessageViewCell";
    ELiveMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveMessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 38, 38)];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 19;
    iconView.image = [UIImage imageNamed:@"image_default_userheader"];
    [self.contentView addSubview:iconView];
  
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) +4, 10, Main_Screen_Width -CGRectGetMaxX(iconView.frame)- 10 , 80)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息新的消息";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
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

@end
