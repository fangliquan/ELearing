//
//  ELiveHomeHeaderView.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveHomeHeaderView.h"
#import "UcTeacherModel.h"
#import "ELiveTeacherHeaderCourseView.h"

#import "ELiveCourseItemCell.h"
@interface ELiveHomeHeaderView(){
    UIImageView *iconView;
    UILabel     *liveTagLabel;
    UIView      *bottomView;
    UIImageView *userHeader;
    UILabel *userNameLabel;
    UILabel *userSubLabel;
    UILabel *inPriceL;
    UILabel *inPriceTitleL;
    UILabel *commentL;
    UILabel *fansL;
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
    
    CGFloat offsetY = viewHeight - 50 -userHeaderH - 8;
    CGFloat offsetX = 10;
    
    
    userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX,offsetY, userHeaderH, userHeaderH)];
    userHeader.layer.masksToBounds = YES;
    userHeader.layer.cornerRadius = userHeaderH/2.0;
    userHeader.userInteractionEnabled = YES;
    //[userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHeaderClick)]];
    //[userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHomePageClick)]];
    
    [self addSubview:userHeader];
    
    
    
    userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeader.frame) + 5, CGRectGetMinY(userHeader.frame) + 15, Main_Screen_Width - 120,20)];
    userNameLabel.numberOfLines =1;
    userNameLabel.font = [UIFont systemFontOfSize:16];
    userNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:userNameLabel];
    
    userSubLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeader.frame) + 5, CGRectGetMaxY(userNameLabel.frame)+4, Main_Screen_Width - 120,20)];
    userSubLabel.numberOfLines = 1;
    userSubLabel.font = [UIFont systemFontOfSize:15];
    userSubLabel.textColor = [UIColor whiteColor];
    [self addSubview:userSubLabel];
    

    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, viewHeight - 50, Main_Screen_Width, 50)];
    [self addSubview:bottomView];
    CGFloat itemWidth = (Main_Screen_Width - 3)/ 3.0;
    
    inPriceL = [[UILabel alloc]initWithFrame:CGRectMake(0, 4, itemWidth, 20)];
    inPriceL.textAlignment = NSTextAlignmentCenter;
    inPriceL.textColor = [UIColor whiteColor];
    inPriceL.text = @"12345";
    inPriceL.font = [UIFont systemFontOfSize:15];
    inPriceL.userInteractionEnabled = YES;
    //[inPriceL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(earningClick)]];
    [bottomView addSubview:inPriceL];
    
    inPriceTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(inPriceL.frame), itemWidth, 20)];
    inPriceTitleL.textAlignment = NSTextAlignmentCenter;
    inPriceTitleL.textColor = CELL_BORDER_COLOR;
    inPriceTitleL.text = @"学生";
    inPriceTitleL.font = [UIFont systemFontOfSize:15];
    inPriceTitleL.userInteractionEnabled = YES;
   // [inPriceTitleL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(earningClick)]];
    [bottomView addSubview:inPriceTitleL];
 
    
    UILabel *splitL1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(inPriceL.frame), 8, 0.6, 24)];
    splitL1.backgroundColor = CELL_BORDER_COLOR;
    [bottomView addSubview:splitL1];
    
    
    
    
    commentL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL1.frame), 4, itemWidth, 20)];
    commentL.textAlignment = NSTextAlignmentCenter;
    commentL.textColor = [UIColor whiteColor];
    commentL.text = @"12345";
    commentL.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:commentL];
    
    UILabel *commentLTitleL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL1.frame), CGRectGetMaxY(commentL.frame), itemWidth, 20)];
    commentLTitleL.textAlignment = NSTextAlignmentCenter;
    commentLTitleL.textColor = CELL_BORDER_COLOR;
    commentLTitleL.text = @"评分";
    commentLTitleL.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:commentLTitleL];
    
    
    UILabel *splitL2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentL.frame), 8, 0.6, 24)];
    splitL2.backgroundColor = CELL_BORDER_COLOR;
    [bottomView addSubview:splitL2];
    
    
    
    fansL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL2.frame), 4, itemWidth, 20)];
    fansL.textAlignment = NSTextAlignmentCenter;
    fansL.textColor = [UIColor whiteColor];
    fansL.text = @"12345";
    fansL.font = [UIFont systemFontOfSize:15];
    fansL.userInteractionEnabled = YES;
    //[fansL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fansLableClick)]];
    [bottomView addSubview:fansL];
    
    UILabel *fansLTitleL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL2.frame), CGRectGetMaxY(fansL.frame), itemWidth, 20)];
    fansLTitleL.textAlignment = NSTextAlignmentCenter;
    fansLTitleL.textColor = CELL_BORDER_COLOR;
    fansLTitleL.text = @"粉丝";
    fansLTitleL.font = [UIFont systemFontOfSize:15];
    fansLTitleL.userInteractionEnabled = YES;
   // [fansLTitleL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fansLableClick)]];
    [bottomView addSubview:fansLTitleL];
    
    
    
}

+(CGFloat)eLiveHomeHeaderHeight{
    CGFloat height = Main_Screen_Width *9/16.0;
    return height;
}


-(void)setTeacherInfoModel:(TeacherInfoModel *)teacherInfoModel{
    _teacherInfoModel = teacherInfoModel;
    [userHeader setImageWithURL:[NSURL URLWithString:teacherInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"image_default_userheader"]];
    
    userNameLabel.text = teacherInfoModel.name;
    userSubLabel.text = teacherInfoModel.tags;
    fansL.text = teacherInfoModel.follow_count;
    commentL.text = teacherInfoModel.score;
    inPriceL.text = teacherInfoModel.students;
    
}
@end



@interface ELiveTeacherHeaderView (){
    
}

@property(nonatomic,strong) ELiveHomeHeaderView *userHeaderView;

@property(nonatomic,strong) ELiveTeacherHeaderCourseView *headerCourseViewView;
@end


@implementation ELiveTeacherHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    CGFloat offsetY = Main_Screen_Width *9/16.0;
    self.userHeaderView = [[ELiveHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width *9/16.0)];
    [self addSubview:self.userHeaderView];
    
    offsetY +=8;
    CGFloat courseViewH = [ELiveTeacherHeaderCourseView teacherHeaderCourseViewHeight:self.teacherCourseListModel.list];
    self.headerCourseViewView = [[ELiveTeacherHeaderCourseView alloc]initWithFrame:CGRectMake(0, offsetY, Main_Screen_Width, courseViewH)];
    self.headerCourseViewView.courseArray =[NSMutableArray arrayWithArray:self.teacherCourseListModel.list];
    
    __unsafe_unretained typeof(self) unself = self;
    self.headerCourseViewView.lookMoreTeacherCourseBlock = ^{
        if (unself.lookMoreTeacherCourseBlock) {
            unself.lookMoreTeacherCourseBlock();
        }
    };
    self.headerCourseViewView.teacherCourseItemBlock = ^(TeacherCourseListItem *courseItem) {
        if (unself.teacherCourseItemBlock) {
            unself.teacherCourseItemBlock(courseItem);
        }
    };
    [self addSubview:self.headerCourseViewView];

}

-(void)setTeacherInfoModel:(TeacherInfoModel *)teacherInfoModel{
    _teacherInfoModel = teacherInfoModel;
    self.userHeaderView.teacherInfoModel = teacherInfoModel;
}

-(void)setTeacherCourseListModel:(TeacherCourseListModel *)teacherCourseListModel{
    _teacherCourseListModel = teacherCourseListModel;
    self.headerCourseViewView.courseArray =[NSMutableArray arrayWithArray:self.teacherCourseListModel.list];
    
    CGRect olderFrame = self.headerCourseViewView.frame;
    olderFrame.size.height  = [ELiveTeacherHeaderCourseView teacherHeaderCourseViewHeight:teacherCourseListModel.list];
    self.headerCourseViewView.frame = olderFrame;

}

+(CGFloat)teacherHeaderViewHeight:(NSInteger)courseCount{
    
    CGFloat height = 40 + Main_Screen_Width *9/16.0 + 8;
    if (courseCount >0) {
        ELiveCourseItemCellFrame *cellframe = [[ELiveCourseItemCellFrame alloc]init];
        cellframe.teacherCourseListItem = [[TeacherCourseListItem alloc]init];
        
        height = height + courseCount *(cellframe.cellHeight + 1);
    }
    
    return height ;
    
}

@end
