//
//  ELiveCourseEvaluateCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/24.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseEvaluateCell.h"
#import "UcCourseIndex.h"
#import "UcTeacherModel.h"
@interface ELiveCourseEvaluateCell(){
    UIImageView *headerView;
    UILabel *userNameLabel;
    UILabel *commentLabel;
    UILabel *timeLabel;
    UIImageView *starView;
    
}

@end
@implementation ELiveCourseEvaluateCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveCourseEvaluateCell";
    ELiveCourseEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveCourseEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    headerView = [[UIImageView alloc]init];
    headerView.layer.masksToBounds = YES;
    headerView.layer.cornerRadius = 25;

    [self.contentView addSubview:headerView];

    
    starView = [[UIImageView alloc]init];
    starView.layer.masksToBounds = YES;
    starView.layer.cornerRadius = 25;

    [self.contentView addSubview:starView];
    
    userNameLabel = [[UILabel alloc]init];
    userNameLabel.numberOfLines = 2;
    userNameLabel.text = @"大家好";
    userNameLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    userNameLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self.contentView addSubview:userNameLabel];
    
    timeLabel =[[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.numberOfLines = 1;
    timeLabel.text = @"2017-08-09 23:00";
    [self.contentView addSubview:timeLabel];
    
    
    commentLabel = [[UILabel alloc]init];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    commentLabel.text = @"大家好啊回到家阿里看见法拉第积分卡两地分居阿克鲁塞德";
    commentLabel.numberOfLines = 0;
    [self.contentView addSubview:commentLabel];
    
}

-(void)setCellFrame:(ELiveCourseEvaluateCellFrame *)cellFrame{
    if (cellFrame) {
        _cellFrame = cellFrame;
        headerView.frame = cellFrame.headerFrame;
        starView.frame = cellFrame.starFrame;
        userNameLabel.frame = cellFrame.userNameLFrame;
        timeLabel.frame = cellFrame.timeLFrame;
        commentLabel.frame = cellFrame.commentDespFrame;
        
        if (cellFrame.courseEvaluateListItem) {
            [headerView setImageWithURL:[NSURL URLWithString:cellFrame.courseEvaluateListItem.avatar] placeholderImage:[UIImage imageNamed:@"image_default_userheader"]];
            userNameLabel.text = cellFrame.courseEvaluateListItem.username;
            timeLabel.text = cellFrame.courseEvaluateListItem.time;
            commentLabel.text = cellFrame.courseEvaluateListItem.content;
        }else{
            [headerView setImageWithURL:[NSURL URLWithString:cellFrame.teacherEvaluateListItem.avatar] placeholderImage:[UIImage imageNamed:@"image_default_userheader"]];
            userNameLabel.text = cellFrame.teacherEvaluateListItem.username;
            timeLabel.text = cellFrame.teacherEvaluateListItem.time;
            commentLabel.text = cellFrame.teacherEvaluateListItem.content;
        }

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation ELiveCourseEvaluateCellFrame


-(void)setTeacherEvaluateListItem:(TeacherEvaluateListItem *)teacherEvaluateListItem{
    _teacherEvaluateListItem = teacherEvaluateListItem;
    CGFloat marginX = 8;
    CGFloat offsetY = 8;
    
    CGFloat headerWidth = 50;
    CGFloat starWidth = 80;
    _headerFrame = CGRectMake(marginX, offsetY, headerWidth, headerWidth);
    _userNameLFrame = CGRectMake(CGRectGetMaxX(_headerFrame) +marginX, marginX *2, 200, 20);
    _starFrame = CGRectMake(Main_Screen_Width - 90, marginX *2, starWidth, 20);
    _timeLFrame = CGRectMake(CGRectGetMaxX(_headerFrame) + marginX, CGRectGetMaxY(_userNameLFrame) + 5, 220, 18);
    
    CGFloat textW = Main_Screen_Width  - CGRectGetMaxX(_headerFrame) - 2*marginX;
    CGFloat textH = [WWTextManager textSizeWithStringZeroSpace: teacherEvaluateListItem.content width:textW fontSize:15].height + 2;
    _commentDespFrame = CGRectMake(CGRectGetMaxX(_headerFrame) + marginX,  CGRectGetMaxY(_headerFrame) + 5, textW, textH);
    _cellHeight = CGRectGetMaxY(_commentDespFrame) + offsetY;
}

-(void)setCourseEvaluateListItem:(CourseEvaluateListItem *)courseEvaluateListItem{
    _courseEvaluateListItem = courseEvaluateListItem;
    CGFloat marginX = 8;
    CGFloat offsetY = 8;
    
    CGFloat headerWidth = 50;
    CGFloat starWidth = 80;
    _headerFrame = CGRectMake(marginX, offsetY, headerWidth, headerWidth);
    _userNameLFrame = CGRectMake(CGRectGetMaxX(_headerFrame) +marginX, marginX *2, 200, 20);
    _starFrame = CGRectMake(Main_Screen_Width - 90, marginX *2, starWidth, 20);
    _timeLFrame = CGRectMake(CGRectGetMaxX(_headerFrame) + marginX, CGRectGetMaxY(_userNameLFrame) + 5, 220, 18);
    
    CGFloat textW = Main_Screen_Width  - CGRectGetMaxX(_headerFrame) - 2*marginX;
    CGFloat textH = [WWTextManager textSizeWithStringZeroSpace: courseEvaluateListItem.content width:textW fontSize:15].height + 2;
    _commentDespFrame = CGRectMake(CGRectGetMaxX(_headerFrame) + marginX,  CGRectGetMaxY(_headerFrame) + 5, textW, textH);
    _cellHeight = CGRectGetMaxY(_commentDespFrame) + offsetY;
}


@end
