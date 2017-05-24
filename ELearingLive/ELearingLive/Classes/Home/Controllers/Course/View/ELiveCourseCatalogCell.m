//
//  ELiveCourseCatalogCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/24.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseCatalogCell.h"

@interface ELiveCourseCatalogCell(){
    UILabel *courseNumLabel;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *stateLabel;

}

@end
@implementation ELiveCourseCatalogCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveCourseCatalogCell";
    ELiveCourseCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveCourseCatalogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    courseNumLabel=[[UILabel alloc]init];
    courseNumLabel.font = [UIFont systemFontOfSize:15];
    courseNumLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseNumLabel.textAlignment = NSTextAlignmentRight;
    courseNumLabel.numberOfLines = 1;
    courseNumLabel.text = @"3";
    [self.contentView addSubview:courseNumLabel];

    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 2;
    titleLabel.text = @"大家好啊回到家阿里看见法拉第积分卡两地分居阿克鲁塞德";
    titleLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [self.contentView addSubview:titleLabel];
    
    timeLabel =[[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.numberOfLines = 1;
    timeLabel.text = @"2017-08-09 23:00";
    [self.contentView addSubview:timeLabel];
    
    
    stateLabel = [[UILabel alloc]init];
    stateLabel.layer.backgroundColor  = EL_COLOR_BLUE.CGColor;
    stateLabel.font = [UIFont systemFontOfSize:14];
    stateLabel.layer.cornerRadius = 3;
    stateLabel.layer.masksToBounds = YES;
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.text = @"直播中";
    [self.contentView addSubview:stateLabel];
    
}

-(void)setCellFrame:(ELiveCourseCatalogCellFrame *)cellFrame{
    if (cellFrame) {
        _cellFrame = cellFrame;
        courseNumLabel.frame = cellFrame.couseNumLFrame;
        titleLabel.frame = cellFrame.titleLFrame;
        timeLabel.frame = cellFrame.timeLFrame;
        stateLabel.frame = cellFrame.stateLFrame;
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

@implementation ELiveCourseCatalogCellFrame

-(void)setTemp:(NSString *)temp{
    
    CGFloat marginX = 8;
    CGFloat offsetY = 8;
    
    CGFloat stateTagW = 75;
    
    _couseNumLFrame = CGRectMake(marginX, offsetY+5, 30, 18);
    CGFloat textW = Main_Screen_Width - stateTagW - CGRectGetMaxX(_couseNumLFrame) - 3 *marginX;
    CGFloat textH = [WWTextManager textSizeWithStringZeroSpace:@"大家好啊回到家阿里看见法拉第积分卡两地分居阿克鲁塞德"width:textW fontSize:15].height + 2;
    _titleLFrame = CGRectMake(CGRectGetMaxX(_couseNumLFrame) + marginX, offsetY, textW, textH);
    _timeLFrame = CGRectMake(CGRectGetMaxX(_couseNumLFrame) +marginX, CGRectGetMaxY(_titleLFrame) + 5, textW, 18);
    _stateLFrame =  CGRectMake(CGRectGetMaxX(_titleLFrame) + marginX, offsetY *2, stateTagW, 35);
    if (CGRectGetMaxY(_timeLFrame) >CGRectGetMaxY(_stateLFrame)) {
        _cellHeight = CGRectGetMaxY(_timeLFrame) + offsetY;
    }else{
        _cellHeight = CGRectGetMaxY(_stateLFrame) + offsetY*2;
    }
    
    
    
}

@end
