//
//  ELiveHomeClassesHeaderView.m
//  ELearingLive
//
//  Created by microleo on 2017/5/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveHomeClassesHeaderView.h"

@interface ELiveHomeClassesHeaderView (){
    UIImageView *iconView;
    UILabel *titleLabel;
}

@end

@implementation ELiveHomeClassesHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    iconView=[[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor greenColor];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    
    CGFloat iconH =  Main_Screen_Width/3.0 * 0.5;
    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 1;
    titleLabel.text = @"课程";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(3);
        make.right.equalTo(self.mas_right).offset(-3);
        make.top.equalTo(self.mas_top).offset(8);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.width.height.equalTo(@(iconH));
    }];
}

@end
