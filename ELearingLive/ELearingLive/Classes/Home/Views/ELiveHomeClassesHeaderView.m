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
    //iconView.backgroundColor = [UIColor greenColor];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    iconView.userInteractionEnabled = YES;
    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(couseItemClick)]];
    [self addSubview:iconView];
    
    CGFloat iconH =  Main_Screen_Width/5.0 * 0.5;
    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 1;
    titleLabel.text = @"课程";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self addSubview:titleLabel];
    

    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(6);
        make.width.height.equalTo(@(iconH));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(3);
        make.right.equalTo(self.mas_right).offset(-3);
        make.top.equalTo(iconView.mas_bottom).offset(8);
    }];
    
}

-(void)setCateModel:(IndexCatesModel *)cateModel{
    if (cateModel) {
        _cateModel = cateModel;
        titleLabel.text = cateModel.name;
        if ([cateModel.catid isEqualToString:@"-100000"]) {
            iconView.image = [UIImage imageNamed:@"home_tt_05_"];
        }else{
            [iconView setImageWithURL:[NSURL URLWithString:cateModel.thumb] placeholderImage:EL_Default_Image];
        }
        
    }
}


-(void)couseItemClick{
    if (self.lookCourseListHandler) {
        self.lookCourseListHandler(_cateModel);
    }
}
@end
