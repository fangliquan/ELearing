//
//  ELiveCreateCourseCell.m
//  ELearingLive
//
//  Created by microleo on 2017/6/16.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCreateCourseCell.h"

#import "PHTextView.h"
#import "UcTeacherModel.h"
@interface ELiveCreateCourseCell()<UITextViewDelegate> {
    
    UILabel *titleLable;
    PHTextView *phTextView;
    UIButton *deleBtn;
    UIImageView *addImageView;
    
    UIView *courseCateView;
    
}

@end

@implementation ELiveCreateCourseCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveCreateCourseCell";
    ELiveCreateCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveCreateCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void) configUI{
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width, 20)];
    titleLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLable.font = [UIFont systemFontOfSize :16];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    phTextView = [[PHTextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 10, Main_Screen_Width - 20, 35)];
    phTextView.placeholder = @"请输入...";
    phTextView.hidden = YES;
    phTextView.tintColor = EL_TEXTCOLOR_GRAY;
    phTextView.keyboardType = UIKeyboardTypeDefault;
    phTextView.backgroundColor = [UIColor whiteColor];
    phTextView.textColor = EL_TEXTCOLOR_DARKGRAY;
    phTextView.font = [UIFont systemFontOfSize:14];
    phTextView.delegate = self;
    [self.contentView addSubview:phTextView];

    deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 60, 10, 50, 28)];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleBtn setTitleColor:EL_COLOR_RED forState:UIControlStateNormal];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    deleBtn.hidden = YES;
    [self.contentView addSubview:deleBtn];
    
    addImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) +10, Main_Screen_Width - 20, 140)];
    addImageView.hidden = YES;
    
    [self.contentView addSubview:addImageView];
    
    UILabel *addMessageL = [[UILabel alloc]initWithFrame:CGRectMake(10, (140 - 20)/2.0, Main_Screen_Width - 20, 20)];
    addMessageL.text = @"添加图片";
    addMessageL.textColor = EL_TEXTCOLOR_GRAY;
    addMessageL.font = [UIFont systemFontOfSize:15];
    addMessageL.textAlignment = NSTextAlignmentCenter;
    [addImageView addSubview:addMessageL];
    
    courseCateView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 5, Main_Screen_Width - 20, 40)];
    courseCateView.hidden = YES;
    [self.contentView addSubview:courseCateView];
    
    
    
}


-(void)setCreateCourseInfo:(TeacherCreateCourseInfo *)createCourseInfo{
    _createCourseInfo = createCourseInfo;
  
    for (UIView *view in courseCateView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat offsetY = 10;
    CGFloat btnItem = 70;
    CGFloat btnMargin = 15;
    
    for (int i =0; createCourseInfo.courseCates.count; i ++) {
        offsetY = 10 + i *(btnItem +btnMargin);
        UIButton *cateBtn = [[UIButton alloc]initWithFrame:CGRectMake(offsetY, 5, btnItem, 30)];
        [cateBtn setTitle:@"类型" forState:UIControlStateNormal];
        [cateBtn setTitleColor:EL_TEXTCOLOR_DARKGRAY forState:UIControlStateNormal];
         cateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cateBtn.backgroundColor = [UIColor darkGrayColor];
        [courseCateView addSubview:cateBtn];
    }

    if (createCourseInfo.courseCates.count<=3) {
        UIButton *cateBtn = [[UIButton alloc]initWithFrame:CGRectMake(offsetY, 5, btnItem, 30)];
        [cateBtn setTitle:@"添加" forState:UIControlStateNormal];
        [cateBtn setTitleColor:EL_TEXTCOLOR_DARKGRAY forState:UIControlStateNormal];
        cateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cateBtn.backgroundColor = [UIColor darkGrayColor];
        [courseCateView addSubview:cateBtn];
    }

    addImageView.image = createCourseInfo.courseCover;
    
    if (_sectionIndex ==1) {
        
    }
    
    phTextView.text = createCourseInfo.courseIntro;
    

}


@end
