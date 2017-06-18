//
//  ELeaingNewsItemCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/6.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseItemCell.h"
#import "UcTeacherModel.h"
@interface ELiveCourseItemCell (){
    UIImageView *iconView;
    UILabel     *titleLabel;
    UILabel     *liveTagLabel;
    UILabel     *liveTimeLabel;
    UILabel     *courseNumLabel;
    UILabel     *priceLabel;
    UILabel     *joinNumLabel;
}

@end
@implementation ELiveCourseItemCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELeaingNewsItemCell";
    ELiveCourseItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveCourseItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    iconView=[[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:iconView];
    
    
    liveTagLabel = [[UILabel alloc]init];
    liveTagLabel.layer.backgroundColor  = EL_COLOR_BLUE.CGColor;
    liveTagLabel.font = [UIFont systemFontOfSize:11];
    liveTagLabel.layer.cornerRadius = 3;
    liveTagLabel.layer.masksToBounds = YES;
    liveTagLabel.textAlignment = NSTextAlignmentCenter;
    liveTagLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:liveTagLabel];
    
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 1;
    titleLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self.contentView addSubview:titleLabel];
    
    liveTimeLabel =[[UILabel alloc]init];
    liveTimeLabel.font = [UIFont systemFontOfSize:13];
    liveTimeLabel.textColor = EL_TEXTCOLOR_GRAY;
    liveTimeLabel.numberOfLines = 1;
    [self.contentView addSubview:liveTimeLabel];
    
    
    courseNumLabel=[[UILabel alloc]init];
    courseNumLabel.font = [UIFont systemFontOfSize:13];
    courseNumLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseNumLabel.textAlignment = NSTextAlignmentRight;
    courseNumLabel.numberOfLines = 1;
    courseNumLabel.text = @"课程3";
    
    [self.contentView addSubview:courseNumLabel];
    
    priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = EL_COLOR_RED;
    priceLabel.numberOfLines = 1;
    priceLabel.text = @"33$";
    [self.contentView addSubview:priceLabel];
    
    joinNumLabel =[[UILabel alloc]init];
    joinNumLabel.font = [UIFont systemFontOfSize:13];
    joinNumLabel.textColor = EL_TEXTCOLOR_GRAY;
    joinNumLabel.numberOfLines = 1;
    joinNumLabel.text = @"23人已报名";
    [self.contentView addSubview:joinNumLabel];

}
-(void)setELiveCourseItemCellFrame:(ELiveCourseItemCellFrame *)eLiveCourseItemCellFrame{
    _eLiveCourseItemCellFrame = eLiveCourseItemCellFrame;
    liveTagLabel.frame = eLiveCourseItemCellFrame.liveTagLFrame;
    liveTagLabel.text = eLiveCourseItemCellFrame.teacherCourseListItem.type;
    titleLabel.frame = eLiveCourseItemCellFrame.titleLFrame;
    liveTimeLabel.frame = eLiveCourseItemCellFrame.timeLFrame;
    iconView.frame = eLiveCourseItemCellFrame.iconFrame;
    priceLabel.frame = eLiveCourseItemCellFrame.priceLFrame;
    joinNumLabel.frame = eLiveCourseItemCellFrame.joinNumFrame;
    courseNumLabel.frame = eLiveCourseItemCellFrame.couseNumLFrame;
    titleLabel.text =  eLiveCourseItemCellFrame.teacherCourseListItem.name;
    courseNumLabel.text =  eLiveCourseItemCellFrame.teacherCourseListItem.periodid;
    if (eLiveCourseItemCellFrame.isMyFollow) {
           courseNumLabel.text = eLiveCourseItemCellFrame.teacherCourseListItem.teacher_name;
    }else{
           courseNumLabel.text = [NSString stringWithFormat:@"课时%@",eLiveCourseItemCellFrame.teacherCourseListItem.periodid];
    }
 
    liveTimeLabel.text =  eLiveCourseItemCellFrame.teacherCourseListItem.time;
    joinNumLabel.text = [NSString stringWithFormat:@"%@人已报名",eLiveCourseItemCellFrame.teacherCourseListItem.joins];
    if ([eLiveCourseItemCellFrame.teacherCourseListItem.price isEqualToString:@"0.00"]) {
        priceLabel.text = @"免费";
    }else{
        priceLabel.text = [NSString stringWithFormat:@"￥%@",eLiveCourseItemCellFrame.teacherCourseListItem.price];
    }
    
    [iconView setImageWithURL:[NSURL URLWithString: eLiveCourseItemCellFrame.teacherCourseListItem.thumb] placeholderImage:EL_Default_Image];

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

@implementation ELiveCourseItemCellFrame


-(void)setTeacherCourseListItem:(TeacherCourseListItem *)teacherCourseListItem{
    _teacherCourseListItem = teacherCourseListItem;
    
    CGFloat imagePercentage = 96/64.0;
    CGFloat imageHeight  = 80;
    CGFloat imageWidth  = imageHeight * imagePercentage;
    
    CGFloat marginX = 8;
    CGFloat offsetY = 8;
    
    _iconFrame = CGRectMake(marginX, offsetY, imageWidth, imageHeight);
    _liveTagLFrame =  CGRectMake(CGRectGetMaxX(_iconFrame) + marginX, offsetY, 60, 20);
    CGFloat textW = Main_Screen_Width - CGRectGetMaxX(_liveTagLFrame) - 2*marginX;
    _titleLFrame = CGRectMake(CGRectGetMaxX(_liveTagLFrame) + marginX, offsetY, textW, 20);
    _timeLFrame = CGRectMake(CGRectGetMaxX(_iconFrame) +marginX, CGRectGetMaxY(_titleLFrame) + offsetY +3, 120, 18);
    
    _couseNumLFrame = CGRectMake(CGRectGetMaxX(_timeLFrame) +marginX, CGRectGetMaxY(_titleLFrame) +offsetY +3, Main_Screen_Width - CGRectGetMaxX(_timeLFrame) - 2*marginX, 18);
    
    _priceLFrame = CGRectMake(CGRectGetMaxX(_iconFrame) +marginX, CGRectGetMaxY(_timeLFrame)  +offsetY, 60, 22);
    
    _joinNumFrame = CGRectMake(CGRectGetMaxX(_priceLFrame), CGRectGetMaxY(_timeLFrame) +offsetY, Main_Screen_Width - CGRectGetMaxX(_priceLFrame) - 2*marginX, 18);
    
    _cellHeight = CGRectGetMaxY(_iconFrame) + offsetY;
    
}
@end



@interface ELiveCourseItemView (){
    UIImageView *iconView;
    UILabel     *titleLabel;
    UILabel     *liveTagLabel;
    UILabel     *liveTimeLabel;
    UILabel     *courseNumLabel;
    UILabel     *priceLabel;
    UILabel     *joinNumLabel;
}

@end

@implementation ELiveCourseItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    iconView=[[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.layer.masksToBounds = YES;
    iconView.userInteractionEnabled = YES;
    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:iconView];
    
    
    liveTagLabel = [[UILabel alloc]init];
    liveTagLabel.layer.backgroundColor  = EL_COLOR_BLUE.CGColor;
    liveTagLabel.font = [UIFont systemFontOfSize:11];
    liveTagLabel.layer.cornerRadius = 3;
    liveTagLabel.layer.masksToBounds = YES;
    liveTagLabel.textAlignment = NSTextAlignmentCenter;
    liveTagLabel.textColor = [UIColor whiteColor];
    liveTagLabel.userInteractionEnabled = YES;
    [liveTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:liveTagLabel];
    
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 1;
    titleLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.userInteractionEnabled = YES;
    [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:titleLabel];
    
    liveTimeLabel =[[UILabel alloc]init];
    liveTimeLabel.font = [UIFont systemFontOfSize:13];
    liveTimeLabel.textColor = EL_TEXTCOLOR_GRAY;
    liveTimeLabel.numberOfLines = 1;
    liveTimeLabel.userInteractionEnabled = YES;
    [liveTimeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:liveTimeLabel];
    
    
    courseNumLabel=[[UILabel alloc]init];
    courseNumLabel.font = [UIFont systemFontOfSize:13];
    courseNumLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseNumLabel.textAlignment = NSTextAlignmentRight;
    courseNumLabel.numberOfLines = 1;
    courseNumLabel.text = @"课程3";
    courseNumLabel.userInteractionEnabled = YES;
    [courseNumLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:courseNumLabel];
    
    priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = EL_COLOR_RED;
    priceLabel.numberOfLines = 1;
    priceLabel.text = @"33$";
    priceLabel.userInteractionEnabled = YES;
    [priceLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    [self addSubview:priceLabel];
    
    joinNumLabel =[[UILabel alloc]init];
    joinNumLabel.font = [UIFont systemFontOfSize:13];
    joinNumLabel.textColor = EL_TEXTCOLOR_GRAY;
    joinNumLabel.numberOfLines = 1;
    joinNumLabel.userInteractionEnabled = YES;
    [joinNumLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseItemClick)]];
    
    joinNumLabel.text = @"23人已报名";
    [self addSubview:joinNumLabel];
    
 
    
}

-(void)courseItemClick{
    if (self.teacherCourseItemBlock) {
        self.teacherCourseItemBlock(_eLiveCourseItemCellFrame.teacherCourseListItem);
    }
}
-(void)setELiveCourseItemCellFrame:(ELiveCourseItemCellFrame *)eLiveCourseItemCellFrame{
    _eLiveCourseItemCellFrame = eLiveCourseItemCellFrame;
    liveTagLabel.frame = eLiveCourseItemCellFrame.liveTagLFrame;
    liveTagLabel.text = eLiveCourseItemCellFrame.teacherCourseListItem.type;
    titleLabel.frame = eLiveCourseItemCellFrame.titleLFrame;
    liveTimeLabel.frame = eLiveCourseItemCellFrame.timeLFrame;
    iconView.frame = eLiveCourseItemCellFrame.iconFrame;
    priceLabel.frame = eLiveCourseItemCellFrame.priceLFrame;
    joinNumLabel.frame = eLiveCourseItemCellFrame.joinNumFrame;
    courseNumLabel.frame = eLiveCourseItemCellFrame.couseNumLFrame;
    titleLabel.text =  eLiveCourseItemCellFrame.teacherCourseListItem.name;
    courseNumLabel.text = [NSString stringWithFormat:@"课时%@",eLiveCourseItemCellFrame.teacherCourseListItem.periodid];
    liveTimeLabel.text =  eLiveCourseItemCellFrame.teacherCourseListItem.time;
    joinNumLabel.text = [NSString stringWithFormat:@"%@人已报名",eLiveCourseItemCellFrame.teacherCourseListItem.joins];
    if ([eLiveCourseItemCellFrame.teacherCourseListItem.price isEqualToString:@"0.00"]) {
        priceLabel.text = @"免费";
    }else{
        priceLabel.text = [NSString stringWithFormat:@"￥%@",eLiveCourseItemCellFrame.teacherCourseListItem.price];
    }
  
    [iconView setImageWithURL:[NSURL URLWithString: eLiveCourseItemCellFrame.teacherCourseListItem.thumb] placeholderImage:EL_Default_Image];
}


@end
