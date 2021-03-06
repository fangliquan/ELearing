//
//  ELiewHomeGoodCourseCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiewHomeGoodCourseCell.h"
@interface ELiewHomeGoodCourseCell ()
{
    UIView  *bgView;
    UIImageView *iconView;
    UILabel *stateLabel;
    UIView *bottomLight;
    UIImageView *userHeaderIcon;
    UILabel *titleLabel;
    UILabel *bottomDespLabel;
}


@end

@implementation ELiewHomeGoodCourseCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    

    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    iconView = [[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor grayColor];
    iconView.image = [UIImage imageNamed:@"sl_07_3x"];
    //    [vedioCover setImageWithURLStr:@"" placeholder:[UIImage imageNamed:@"childshow_placeholder"]];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    [bgView addSubview:iconView];
    
  
    stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:11];
    stateLabel.backgroundColor = [UIColor blueColor];
    stateLabel.text = @"已预约";
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.layer.masksToBounds = YES;
    stateLabel.layer.cornerRadius = 2;
    [bgView addSubview:stateLabel];
    
    
    
    bottomLight = [[UIView alloc]init];
    bottomLight.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
   // bottomLight.alpha = 0.2;
    [self.contentView addSubview:bottomLight];

    
    
    userHeaderIcon = [[UIImageView alloc]init];
    userHeaderIcon.layer.masksToBounds = YES;
    userHeaderIcon.layer.cornerRadius = 19;
    userHeaderIcon.image = [UIImage imageNamed:@"image_default_userheader"];
    [bottomLight addSubview:userHeaderIcon];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"xxxxx";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [bottomLight addSubview:titleLabel];
    
    
    bottomDespLabel = [[UILabel alloc] init];
    bottomDespLabel.font = [UIFont systemFontOfSize:12];
    bottomDespLabel.textColor = [UIColor whiteColor];
    bottomDespLabel.text = @"xxxxx";
    bottomDespLabel.textAlignment = NSTextAlignmentLeft;
    [bottomLight addSubview:bottomDespLabel];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0 ,0, 0, 0));
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.top.equalTo(bgView.mas_top).offset(8);
        make.height.equalTo(iconView.mas_width).multipliedBy(7/16.0);
    }];
    
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.top.equalTo(bgView.mas_top).offset(8);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    [bottomLight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        make.height.equalTo(@50);
    }];
    
    [userHeaderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLight.mas_left).offset(8);
        make.top.equalTo(bottomLight.mas_top).offset(6);
        make.height.equalTo(@38);
        make.width.equalTo(@38);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userHeaderIcon.mas_right).offset(8);
        make.right.equalTo(bottomLight.mas_right).offset(-8);
        make.top.equalTo(bottomLight.mas_top).offset(6);
    }];
    
    [bottomDespLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userHeaderIcon.mas_right).offset(8);
        make.right.equalTo(bottomLight.mas_right).offset(-8);
        make.top.equalTo(titleLabel.mas_bottom).offset(0);
    }];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"eLiewHomeGoodCourseCell";
    ELiewHomeGoodCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiewHomeGoodCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setIndexRecommandModel:(IndexRecommandModel *)indexRecommandModel{
    if (indexRecommandModel) {
        _indexRecommandModel = indexRecommandModel;
        [iconView setImageWithURL:[NSURL URLWithString:indexRecommandModel.thumb] placeholderImage:EL_Default_Image];
        stateLabel.text = indexRecommandModel.status;
        
        [userHeaderIcon setImageWithURL:[NSURL URLWithString:indexRecommandModel.teacher_avatar] placeholderImage:EL_Default_Image];
        
        titleLabel.text = indexRecommandModel.name;
        bottomDespLabel.text = [NSString stringWithFormat:@"%@ %@", indexRecommandModel.teacher_name,indexRecommandModel.time];
    }
}

+(CGFloat)cellHeightWithModel:(IndexRecommandModel *)str{
    CGFloat height = Main_Screen_Width *7/16.0 + 8;
    return height;
}

@end
