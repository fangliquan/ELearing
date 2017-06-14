//
//  ELiveCourseIntroViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseIntroViewController.h"
#import "ELivePersonHomeViewController.h"
@interface ELiveCourseIntroViewController ()

@end

@implementation ELiveCourseIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewControllerFrame:(CGRect)frame {

}

-(void)setCourseDetailInfoModel:(CourseDetailInfoModel *)courseDetailInfoModel{
    if (courseDetailInfoModel) {
        _courseDetailInfoModel = courseDetailInfoModel;
        
        [self createHeaderView];
    }
   
}

-(void)setTeacherInfoModel:(TeacherInfoModel *)teacherInfoModel{
    _teacherInfoModel = teacherInfoModel;
    [self createTeacherHeader];
}

-(void)createTeacherHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat teacherIntroDespH = [WWTextManager textSizeWithStringZeroSpace:_courseDetailInfoModel.teacher_intro width:Main_Screen_Width - 20 fontSize:14].height +2;
    UILabel *teacherIntroLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,12, Main_Screen_Width - 20, teacherIntroDespH)];
    teacherIntroLabel.text = _teacherInfoModel.intro;
    teacherIntroLabel.textColor = EL_TEXTCOLOR_GRAY;
    teacherIntroLabel.font = [UIFont systemFontOfSize:14];
    teacherIntroLabel.numberOfLines = 0;
    [headerView addSubview:teacherIntroLabel];
    
    headerView.frame = CGRectMake(0, 0, Main_Screen_Width, CGRectGetMaxY(teacherIntroLabel.frame) + 15);
    self.tableView.tableHeaderView = headerView;
}
-(void)createHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat titleW =[WWTextManager textSizeWithStringZeroSpace:_courseDetailInfoModel.name width:Main_Screen_Width -10 - 80 fontSize:17].width + 2;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, titleW, 20)];
    titleLabel.text = _courseDetailInfoModel.name;
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:titleLabel];
    
    UILabel *priceLabel= [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80, 15, 70, 20)];
    priceLabel.text = @"$45.00";
    priceLabel.textColor = EL_COLOR_RED;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:priceLabel];
    
    if ([_courseDetailInfoModel.price isEqualToString:@"0.00"]) {
        priceLabel.text = @"免费";
    }else{
       priceLabel.text = [NSString stringWithFormat:@"%@￥", _courseDetailInfoModel.price];
    }
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 5,80, 20)];
    commentLabel.text = [NSString stringWithFormat:@"%@阅读",_courseDetailInfoModel.hits];// @"45人报名";
    commentLabel.textColor = EL_TEXTCOLOR_GRAY;
    commentLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:commentLabel];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 210, CGRectGetMaxY(titleLabel.frame) + 5,200, 20)];
    timeLabel.text = _courseDetailInfoModel.time;
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:timeLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(commentLabel.frame) + 15, Main_Screen_Width, 0.6)];
    line.backgroundColor = CELL_BORDER_COLOR;
    [headerView addSubview:line];
    
    
    UILabel *courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(line.frame) + 15, 70, 20)];
    courseTitleLabel.text = @"课程描述";
    courseTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseTitleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:courseTitleLabel];
    
    CGFloat courseDespH = [WWTextManager textSizeWithStringZeroSpace:_courseDetailInfoModel.desc width:Main_Screen_Width - 20 fontSize:14].height +2;
    UILabel *courseDespLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(courseTitleLabel.frame)+ 6, Main_Screen_Width - 20, courseDespH)];
    courseDespLabel.text = _courseDetailInfoModel.desc;
    courseDespLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseDespLabel.font = [UIFont systemFontOfSize:14];
    courseDespLabel.numberOfLines = 0;
    [headerView addSubview:courseDespLabel];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(courseDespLabel.frame) + 15, Main_Screen_Width, 0.6)];
    line2.backgroundColor = CELL_BORDER_COLOR;
    [headerView addSubview:line2];
    
    
    
    UIImageView *userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line2.frame) + 20, 50, 50)];
    userHeader.layer.masksToBounds = YES;
    userHeader.layer.cornerRadius = 25;
    userHeader.userInteractionEnabled = YES;
    [userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHomePageClick)]];
    [headerView addSubview:userHeader];
    
    [userHeader setImageWithURL:[NSURL URLWithString:_courseDetailInfoModel.teacehr_avatar] placeholderImage:[UIImage imageNamed:@"image_default_userheader"]];
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeader.frame) +6, CGRectGetMinY(userHeader.frame) + 10, Main_Screen_Width - CGRectGetMaxX(userHeader.frame) - 12, 20)];
    userNameLabel.numberOfLines = 2;
    userNameLabel.text = _courseDetailInfoModel.teacher_name;
    userNameLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    userNameLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [headerView addSubview:userNameLabel];
    
    
    
    CGFloat teacherIntroDespH = [WWTextManager textSizeWithStringZeroSpace:_courseDetailInfoModel.teacher_intro width:Main_Screen_Width - CGRectGetMaxX(userHeader.frame) - 16 fontSize:14].height +2;
    UILabel *teacherIntroLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeader.frame) +6,CGRectGetMaxY(userNameLabel.frame)+ 6, Main_Screen_Width - CGRectGetMaxX(userHeader.frame) - 16, teacherIntroDespH)];
    teacherIntroLabel.text = _courseDetailInfoModel.teacher_intro;
    teacherIntroLabel.textColor = EL_TEXTCOLOR_GRAY;
    teacherIntroLabel.font = [UIFont systemFontOfSize:14];
    teacherIntroLabel.numberOfLines = 0;
    [headerView addSubview:teacherIntroLabel];
    
    headerView.frame = CGRectMake(0, 0, Main_Screen_Width, CGRectGetMaxY(teacherIntroLabel.frame) + 15);
    self.tableView.tableHeaderView = headerView;
}

-(void)userHomePageClick{
    if (self.userHomePageHandler) {
        self.userHomePageHandler(_courseDetailInfoModel.teacherid);
    }

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 0;
}


@end
