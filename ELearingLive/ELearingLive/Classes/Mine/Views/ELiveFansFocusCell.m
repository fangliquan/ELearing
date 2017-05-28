//
//  ELiveFansFocusCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveFansFocusCell.h"


@interface ELiveFansFocusCell(){
    UILabel *titleLabel;
    UILabel *timeLabel;
    UIImageView *userHeaderIcon;
}

@end
@implementation ELiveFansFocusCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveFansFocusCell";
    ELiveFansFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveFansFocusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    userHeaderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 50, 50)];
    userHeaderIcon.layer.masksToBounds = YES;
    userHeaderIcon.layer.cornerRadius = 25;
    userHeaderIcon.image = [UIImage imageNamed:@"image_default_userheader"];
    [self.contentView addSubview:userHeaderIcon];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIcon.frame) +5, 12, Main_Screen_Width, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"王江林";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIcon.frame) +5, CGRectGetMaxY(titleLabel.frame), Main_Screen_Width, 20)];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.text = @"2014-09-08 12:00";
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:timeLabel];
}


@end
