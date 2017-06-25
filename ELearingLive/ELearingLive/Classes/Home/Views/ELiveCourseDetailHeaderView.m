//
//  ELiveCourseDetailHeaderView.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseDetailHeaderView.h"
#import "UcCourseIndex.h"
@interface ELiveCourseDetailHeaderView(){
    UIImageView *iconView;
    UILabel     *liveTagLabel;
}

@end
@implementation ELiveCourseDetailHeaderView

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
    iconView.image = [UIImage imageNamed:@"sl_08_3x"];
    [self addSubview:iconView];
    
    
    liveTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 6, 60, 20)];
    liveTagLabel.layer.backgroundColor  = EL_COLOR_RED.CGColor;
    liveTagLabel.font = [UIFont systemFontOfSize:11];
    liveTagLabel.layer.cornerRadius = 3;
    liveTagLabel.layer.masksToBounds = YES;
    liveTagLabel.text = @"直播中";
    liveTagLabel.textAlignment = NSTextAlignmentCenter;
    liveTagLabel.textColor = [UIColor whiteColor];
    [self addSubview:liveTagLabel];
}

-(void)setCourseDetailInfoModel:(CourseDetailInfoModel *)courseDetailInfoModel{
    _courseDetailInfoModel = courseDetailInfoModel;
    [iconView setImageWithURL:[NSURL URLWithString:courseDetailInfoModel.thumb] placeholderImage:[UIImage imageNamed:@"sl_08_3x"]];
    if ([courseDetailInfoModel.course_type isEqualToString:@"live"]) {
        liveTagLabel.text = @"直播中";
    }else{
        liveTagLabel.text = @"课程中";
    }
}
+(CGFloat)eLiveCourseDetailHeaderHeight{
    CGFloat height = Main_Screen_Width *9/16.0;
    return height;
}
@end
