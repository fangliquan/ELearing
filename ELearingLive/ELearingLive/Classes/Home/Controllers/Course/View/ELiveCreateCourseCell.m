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
#import "LiveTimePickerView.h"
#import "UcCourseIndex.h"
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
    phTextView.tintColor = EL_TEXTCOLOR_GRAY;
    phTextView.keyboardType = UIKeyboardTypeDefault;
    phTextView.backgroundColor = [UIColor whiteColor];
    phTextView.textColor = EL_TEXTCOLOR_DARKGRAY;
    phTextView.font = [UIFont systemFontOfSize:14];
    phTextView.delegate = self;
    [self.contentView addSubview:phTextView];

    
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >0) {
        if (_isCourseIntro) {
            _createCourseInfo.courseIntro =  phTextView.text;
        }else{
            _createCourseInfo.courseSubject =  phTextView.text;
            
        }
    }

}
-(void)setCreateCourseInfo:(TeacherCreateCourseInfo *)createCourseInfo{
    _createCourseInfo = createCourseInfo;
  
    if (!_isCourseIntro) {
         phTextView.text = createCourseInfo.courseSubject;
         phTextView.placeholder = @"请输入课程主题.";
         titleLable.text = @"课程主题";
         phTextView.frame = CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 10, Main_Screen_Width - 20, 35);
    }else{
         phTextView.text = createCourseInfo.courseIntro;
         phTextView.placeholder = @"请输入课程简介";
         titleLable.text = @"课程简介";
         phTextView.frame =  CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 10, Main_Screen_Width - 20, 150);
    }
}


@end
@implementation CreateTimeModel



@end
@interface ELiveCreateCourseTimeCell()<UITextViewDelegate> {
    
    UILabel *titleLable;
    UITextField *textField;
    UIButton  *deleBtn;
    UIButton  *addBtn;
    
}

@property(nonatomic,strong) NSString *currentDateStr;

@property(nonatomic,strong) NSDate *currentDate;

@property(nonatomic, strong) LiveTimePickerView *livePickerView;

@end

@implementation ELiveCreateCourseTimeCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"eLiveCreateCourseTimeCell";
    ELiveCreateCourseTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveCreateCourseTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, Main_Screen_Width, 20)];
    titleLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLable.text = @"课程时间";
    titleLable.font = [UIFont systemFontOfSize :16];
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:titleLable];
    
    deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 60, 10, 50, 28)];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleBtn setTitleColor:EL_COLOR_RED forState:UIControlStateNormal];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [deleBtn addTarget:self action:@selector(deleteCourseTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleBtn];
    
    addBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 30)/2.0, 10, 30, 30)];
    [addBtn setImage:[UIImage imageNamed:@"plus_addtopic_btnbg"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewCourseTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 15,Main_Screen_Width - 20, 35)];
    textField.tintColor = EL_TEXTCOLOR_GRAY;
    textField.placeholder = @"请选择开始时间";
    textField.textColor = EL_TEXTCOLOR_DARKGRAY;
    textField.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:textField];
    textField.text = @"";
    __unsafe_unretained typeof(self) selfVc = self;
    LiveTimePickerView *livePickerView = [[LiveTimePickerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 230) completeBlock:^(NSDictionary *infoDic) {
        [textField resignFirstResponder];
        if (infoDic) {
            [selfVc changeDateControl:infoDic];
        }
    }];
    self.livePickerView = livePickerView;
    textField.inputView =  self.livePickerView;
    
    
    
}

-(void)deleteCourseTimeClick{
    if (self.deleteCourseTimeHandler) {
        self.deleteCourseTimeHandler(self.createTimeModel);
    }
}
-(void)addNewCourseTimeClick{
    if (self.addNewCourseTimeHandler) {
        self.addNewCourseTimeHandler();
    }
}

-(void)changeDateControl:(NSDictionary *)dic{
    
    NSString *dateValue = dic[@"date_value"];
    NSString *dateStr = dic[@"date_str"];
    self.currentDateStr = dateStr;
    NSDate *formateDate = [DateHelper dateFromString:dateValue style:WWTimeStringDateAndTimeFullStyle];
    _currentDate = [NSDate new];
    _currentDate = formateDate;
    textField.text = dateValue;
    _createTimeModel.courseTime = dateValue;
    _createTimeModel.courseTimestamp = [NSString stringWithFormat:@"%f",[DateHelper timeIntervalOfChangedDate:formateDate]/1000];
}


-(void)setCreateTimeModel:(CreateTimeModel *)createTimeModel{
    
    _createTimeModel = createTimeModel;
    if (createTimeModel.isAddCourse) {
        textField.hidden = YES;
        deleBtn.hidden = YES;
        addBtn.hidden = NO;
        self.livePickerView.hidden = YES;
        titleLable.text = @"添加课时";
    }else{
        titleLable.text = [NSString stringWithFormat:@"%@",createTimeModel.name?createTimeModel.name:[NSString stringWithFormat:@"课时 %@",createTimeModel.coursePId]];
        textField.text = createTimeModel.courseTime;
        textField.hidden = NO;
        deleBtn.hidden = NO;
        addBtn.hidden = YES;
        self.livePickerView.hidden = NO;
    }

    
}



@end



@interface ELiveCreateAddCateCell()<UITextViewDelegate> {
    
    UILabel *titleLable;
    
    UIView *courseCateView;
    
}

@end

@implementation ELiveCreateAddCateCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveCreateAddCateCell";
    ELiveCreateAddCateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveCreateAddCateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    titleLable.text = @"选择课程类型";
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    courseCateView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 5, Main_Screen_Width - 20, 50)];
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
    NSInteger count = createCourseInfo.courseCates.count;
    if (count >4) {
        count = 4;
    }
    for (int i =0; i< count; i ++) {
        offsetY = 10 + i *(btnItem +btnMargin);
        UcCourseCategireChildItem *cateItem =createCourseInfo.courseCates.count > i? createCourseInfo.courseCates[i]:nil;
        UIButton *cateBtn = [[UIButton alloc]initWithFrame:CGRectMake(offsetY, 5, btnItem, 30)];
        cateBtn.tag = i;
        if ([cateItem.childid isEqualToString:@"0"]) {
              [cateBtn setTitle:@"添加" forState:UIControlStateNormal];
        }else{
              [cateBtn setTitle:cateItem.name forState:UIControlStateNormal];
        }
        [cateBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cateBtn setTitleColor:EL_TEXTCOLOR_DARKGRAY forState:UIControlStateNormal];
        cateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cateBtn.backgroundColor = [UIColor colorWithRed:0.794 green:0.793 blue:0.811 alpha:1.00];
        [courseCateView addSubview:cateBtn];
    }
    

}
-(void)cateBtnClick:(UIButton *)sender{
    NSInteger index = sender.tag;
    UcCourseCategireChildItem *cateItem = self.createCourseInfo.courseCates.count >index?self.createCourseInfo.courseCates[index]:nil;
    if (cateItem) {
        if (self.addCourseCateHandler) {
            self.addCourseCateHandler(cateItem);
        }
    }
}


@end


@interface ELiveCreateAddCoverCell()<UITextViewDelegate> {
    
    UILabel *titleLable;
    UIImageView *addImageView;
}

@end

@implementation ELiveCreateAddCoverCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveCreateAddCoverCell";
    ELiveCreateAddCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveCreateAddCoverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    titleLable.text = @"课程封面";
    titleLable.font = [UIFont systemFontOfSize :16];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    
    addImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) +10, Main_Screen_Width - 20, 140)];
    addImageView.backgroundColor = [UIColor whiteColor];
    addImageView.contentMode = UIViewContentModeScaleAspectFill;
    addImageView.layer.masksToBounds = YES;
    addImageView.userInteractionEnabled = YES;
    [addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addCourseCoverClick)]];
    [self.contentView addSubview:addImageView];
    
    UILabel *addMessageL = [[UILabel alloc]initWithFrame:CGRectMake(10, (140 - 20)/2.0, Main_Screen_Width - 20, 20)];
    addMessageL.text = @"添加图片";
    addMessageL.textColor = EL_TEXTCOLOR_GRAY;
    addMessageL.font = [UIFont systemFontOfSize:15];
    addMessageL.textAlignment = NSTextAlignmentCenter;
    [addImageView addSubview:addMessageL];
    
    
    
    
    
}

-(void)addCourseCoverClick{
    if (self.addCourseCoverHandler) {
        self.addCourseCoverHandler();
    }
}

-(void)setCreateCourseInfo:(TeacherCreateCourseInfo *)createCourseInfo{
    _createCourseInfo = createCourseInfo;
    addImageView.image = createCourseInfo.courseCover;

}


@end

