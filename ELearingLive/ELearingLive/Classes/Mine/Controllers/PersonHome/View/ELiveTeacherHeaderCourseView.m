//
//  ELiveTeacherHeaderCourseView.m
//  ELearingLive
//
//  Created by microleo on 2017/6/14.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveTeacherHeaderCourseView.h"
#import "ELiveCourseItemCell.h"
@interface ELiveTeacherHeaderCourseView(){
    
    UIView *courseView;
}

@end
@implementation ELiveTeacherHeaderCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, Main_Screen_Width, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 100, 18)];
    titleLabel.text = @"课程";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [bgView addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 2, Main_Screen_Width -CGRectGetMaxX(titleLabel.frame) - 8 , 18)];
    subtitleLabel.text = @"查看更多课程";
    subtitleLabel.userInteractionEnabled = YES;
    [subtitleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookMoreCourseClick)]];
    subtitleLabel.font = [UIFont systemFontOfSize:15];
    subtitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    subtitleLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:subtitleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 9, Main_Screen_Width, 1)];
    lineLabel.backgroundColor = CELL_BORDER_COLOR;
    [bgView addSubview:lineLabel];
    
    [self addSubview:headerView];
    
    courseView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), Main_Screen_Width, 0)];
    courseView.userInteractionEnabled = YES;
    [self addSubview:courseView];
    
}

-(void)lookMoreCourseClick{
    if (self.lookMoreTeacherCourseBlock) {
        self.lookMoreTeacherCourseBlock();
    }
}
-(void)setCourseArray:(NSMutableArray *)courseArray{
    _courseArray = courseArray;
    
    for (UIView *view in courseView.subviews) {
        [view removeFromSuperview];
    }
    
    if (courseArray.count >0) {
        CGFloat offsetY = 0;
        __unsafe_unretained typeof(self) unself = self;
        for (int i =0; i <courseArray.count; i ++) {
            TeacherCourseListItem *courseItem = courseArray[i];
            ELiveCourseItemCellFrame *cellframe = [[ELiveCourseItemCellFrame alloc]init];
            cellframe.teacherCourseListItem = courseItem;
            
            ELiveCourseItemView *itemView = [[ELiveCourseItemView alloc]initWithFrame:CGRectMake(0, cellframe.cellHeight *i, Main_Screen_Width, cellframe.cellHeight)];
            itemView.eLiveCourseItemCellFrame = cellframe;
            itemView.tag = i;
            itemView.teacherCourseItemBlock = ^(TeacherCourseListItem *courseItem) {
                if (unself.teacherCourseItemBlock) {
                     unself.teacherCourseItemBlock(courseItem);
                }
               
            };
            
            [courseView addSubview:itemView];
            
            offsetY += cellframe.cellHeight;
            if (i<1) {
                UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, offsetY, Main_Screen_Width, 1)];
                lineLabel.backgroundColor = CELL_BORDER_COLOR;
                [courseView addSubview:lineLabel];
            }
      
        }
        CGRect oldF = courseView.frame;
        oldF.size.height = offsetY;
        courseView.frame = oldF;
  
    }

    
}

+(CGFloat)teacherHeaderCourseViewHeight:(NSArray *)courseArray{
    
    CGFloat height = 40;
    if (courseArray.count >0) {
        ELiveCourseItemCellFrame *cellframe = [[ELiveCourseItemCellFrame alloc]init];
        cellframe.teacherCourseListItem = [courseArray firstObject];
        
        height = height + courseArray.count *(cellframe.cellHeight + 1);
    }
    return height;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
