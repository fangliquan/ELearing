//
//  ELiveMainCateViewCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveMainCateViewCell.h"
#import "UcCourseIndex.h"
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

-(void)setCourseCategireMainItem:(UcCourseCategireMainItem *)courseCategireMainItem{
    _courseCategireMainItem = courseCategireMainItem;
    titleLabel.text = courseCategireMainItem.name;
}



@end

@implementation ELiveMainCateModel



@end

@interface ELiveCateChildrenView (){
    UILabel *titleLabel;
}

@end

@implementation ELiveCateChildrenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
//    self.userInteractionEnabled = YES;
   [self addTarget:self action:@selector(itemClick) forControlEvents:UIControlEventTouchUpInside];
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor =EL_TEXTCOLOR_DARKGRAY ;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.userInteractionEnabled = YES;
    [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick)]];;

    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(0);
        make.right.bottom.equalTo(self).offset(0);
    }];
}

-(void)setCourseCategireChildItem:(UcCourseCategireChildItem *)courseCategireChildItem{
    _courseCategireChildItem = courseCategireChildItem;
    titleLabel.text = courseCategireChildItem.name ;
}

-(void)itemClick{
    if (self.courseCateItemHandler) {
        self.courseCateItemHandler(_courseCategireChildItem);
    }
}

+(CGFloat)childrenViewWidth:(NSString *)name{
    CGFloat width = 12;
    width +=[WWTextManager textSizeWithStringZeroSpace:name width:200 fontSize:15].width + 2;
    return width;
}



@end
