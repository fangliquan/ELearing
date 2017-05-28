//
//  ELiveHomeHeaderView.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveHomeHeaderView.h"
@interface ELiveHomeHeaderView(){
    UIImageView *iconView;
    UILabel     *liveTagLabel;
}

@end
@implementation ELiveHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    iconView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width *9/16.0)];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    iconView.image = [UIImage imageNamed:@"sl_07_3x"];
    [self addSubview:iconView];
    
    CGFloat userHeaderH = 70;

    CGFloat viewHeight = Main_Screen_Width *9/16.0;
    
    CGFloat offsetY = (viewHeight - userHeaderH)/2.0 - userHeaderH/2.0;
    CGFloat offsetX =(Main_Screen_Width - userHeaderH)/2.0;
    
    
    UIImageView *userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX,offsetY, userHeaderH, userHeaderH)];
    userHeader.layer.masksToBounds = YES;
    userHeader.layer.cornerRadius = userHeaderH/2.0;
    userHeader.userInteractionEnabled = YES;
    //[userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHomePageClick)]];
    userHeader.image = [UIImage imageNamed:@"image_default_userheader"];
    [self addSubview:userHeader];
    
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(userHeader.frame) + 5, Main_Screen_Width - 120,20)];
    userNameLabel.numberOfLines = 2;
    userNameLabel.text = @"王大大";
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    userNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:userNameLabel];
    
    
    
}

+(CGFloat)eLiveHomeHeaderHeight{
    CGFloat height = Main_Screen_Width *9/16.0;
    return height;
}


@end
