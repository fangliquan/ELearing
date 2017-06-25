//
//  ELiveFansFocusCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveFansFocusCell.h"

#import "UcTeacherModel.h"
@interface ELiveFansFocusCell(){
    UILabel *titleLabel;
    UILabel *timeLabel;
    UIImageView *userHeaderIcon;
    UILabel *despLabel;
    UIButton *uFollowBtn;
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
    
    uFollowBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80, 15, 75, 30)];
    uFollowBtn.backgroundColor = EL_COLOR_RED;
    [uFollowBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    [uFollowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uFollowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:uFollowBtn];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIcon.frame) +5, CGRectGetMaxY(titleLabel.frame), Main_Screen_Width, 20)];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.text = @"2014-09-08 12:00";
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:timeLabel];
    
    despLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIcon.frame) +5, CGRectGetMaxY(userHeaderIcon.frame)+5, Main_Screen_Width -CGRectGetMaxX(userHeaderIcon.frame) -20 , 20)];
    despLabel.font = [UIFont systemFontOfSize:15];
    despLabel.textColor = EL_TEXTCOLOR_GRAY;
    despLabel.numberOfLines = 3;
    despLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:despLabel];
}

-(void)setMyFollowTeacherItem:(UcMyFollowTeacherItem *)myFollowTeacherItem{
    if (myFollowTeacherItem) {
        _myFollowTeacherItem = myFollowTeacherItem;
        [userHeaderIcon setImageWithURL:[NSURL URLWithString:myFollowTeacherItem.avatar] placeholderImage:[UIImage imageNamed: @"image_default_userheader"] ];
        titleLabel.text = myFollowTeacherItem.name;
        timeLabel.text = [NSString stringWithFormat:@"评分:%@ 粉丝:%@",myFollowTeacherItem.score,myFollowTeacherItem.fans];
        despLabel.text = myFollowTeacherItem.intro;
        CGFloat height = [WWTextManager textSizeWithStringZeroSpace:myFollowTeacherItem.intro width: Main_Screen_Width -CGRectGetMaxX(userHeaderIcon.frame) -20  fontSize:15].height + 5;
        
        CGRect oldFrame = despLabel.frame;
        
        oldFrame.size.height = height;
        despLabel.frame = oldFrame;
        
        
        
    }
}
-(void)setIsFans:(BOOL)isFans{
    _isFans = isFans;
    if (isFans) {
        uFollowBtn.hidden = YES;
    }else{
        uFollowBtn.hidden = NO;
    }
    
}
+ (CGFloat)heightForCellWithModel:(UcMyFollowTeacherItem *)teacherItem{
    CGFloat height = 66;
    CGFloat introH = [WWTextManager textSizeWithStringZeroSpace:teacherItem.intro width: Main_Screen_Width -58 -20  fontSize:15].height + 5;
    CGFloat maxH = [WWTextManager textOfAlineHeightWithFontSize:15] *3;
    if (introH >maxH) {
        height = height +maxH;
    }else{
        height = height +introH;
    }
    
    return height;
}

@end
