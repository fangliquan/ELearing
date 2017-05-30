//
//  ELiveMainCateViewCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMainCateViewCell.h"

@interface ELiveMainCateViewCell(){
    UILabel *titleLabel;
}

@end
@implementation ELiveMainCateViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveMainCateViewCell";
    ELiveMainCateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELiveMainCateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 15.5, Main_Screen_Width/4.0, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.text = @"111";
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.contentView addSubview:titleLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setELiveMainCateModel:(ELiveMainCateModel *)eLiveMainCateModel{
    _eLiveMainCateModel = eLiveMainCateModel;
    titleLabel.text = eLiveMainCateModel.title;
}



@end

@implementation ELiveMainCateModel



@end
