//
//  ELiveCastMainCell.m
//  ELearingLive
//
//  Created by microleo on 2017/6/4.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCastMainCell.h"

@interface ELiveCastMainCell ()
{
    UIView  *bgView;
    UIImageView *iconView;
    UILabel *stateLabel;
    UIView *bottomLight;
   // UIImageView *userHeaderIcon;
    UILabel *titleLabel;
    //UILabel *bottomDespLabel;
}


@end

@implementation ELiveCastMainCell


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
    iconView.image = [UIImage imageNamed:@"sl_08_3x"];
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
    bottomLight.backgroundColor = [UIColor groupTableViewBackgroundColor];   // bottomLight.alpha = 0.2;
    [self.contentView addSubview:bottomLight];
    
    
    
//    userHeaderIcon = [[UIImageView alloc]init];
//    userHeaderIcon.layer.masksToBounds = YES;
//    userHeaderIcon.layer.cornerRadius = 19;
//    userHeaderIcon.image = [UIImage imageNamed:@"image_default_userheader"];
//    [bottomLight addSubview:userHeaderIcon];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"xxxxx";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [bottomLight addSubview:titleLabel];
//
//    
//    bottomDespLabel = [[UILabel alloc] init];
//    bottomDespLabel.font = [UIFont systemFontOfSize:12];
//    bottomDespLabel.textColor = [UIColor whiteColor];
//    bottomDespLabel.text = @"xxxxx";
//    bottomDespLabel.textAlignment = NSTextAlignmentLeft;
//    [bottomLight addSubview:bottomDespLabel];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0 ,0, 0, 0));
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(0);
        make.left.equalTo(bgView.mas_left).offset(0);
        make.top.equalTo(bgView.mas_top).offset(0);
        make.height.equalTo(iconView.mas_width).multipliedBy(7/16.0);
    }];
    
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.top.equalTo(bgView.mas_top).offset(8);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    [bottomLight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        make.height.equalTo(@30);
    }];
    
//    [userHeaderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bottomLight.mas_left).offset(8);
//        make.top.equalTo(bottomLight.mas_top).offset(6);
//        make.height.equalTo(@38);
//        make.width.equalTo(@38);
//    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLight.mas_left).offset(8);
        make.right.equalTo(bottomLight.mas_right).offset(-8);
        make.top.equalTo(bottomLight.mas_top).offset(6);
    }];
    
//    [bottomDespLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(userHeaderIcon.mas_right).offset(8);
//        make.right.equalTo(bottomLight.mas_right).offset(-8);
//        make.top.equalTo(titleLabel.mas_bottom).offset(0);
//    }];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"liveastMainCell";
    ELiveCastMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveCastMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

+(CGFloat)cellHeightWithModel:(NSString *)str{
    CGFloat height = Main_Screen_Width *7/16.0 +  38;
    return height;
}

@end
