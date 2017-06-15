//
//  ELiveSettingHeaderView.m
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingHeaderView.h"
@interface ELiveSettingHeaderView(){
    UIImageView *iconView;
    UILabel     *liveTagLabel;
    UIView      *bottomView;
}

@end
@implementation ELiveSettingHeaderView

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
    
    CGFloat offsetY = (viewHeight - userHeaderH)/2.0 - userHeaderH/2.0;
    CGFloat offsetX =(Main_Screen_Width - userHeaderH)/2.0;
    
    
    UIImageView *userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX,offsetY, userHeaderH, userHeaderH)];
    userHeader.layer.masksToBounds = YES;
    userHeader.layer.cornerRadius = userHeaderH/2.0;
    userHeader.userInteractionEnabled = YES;
    [userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHeaderClick)]];
    //[userHeader addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHomePageClick)]];
   
    [self addSubview:userHeader];
    
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(userHeader.frame) + 5, Main_Screen_Width - 120,20)];
    userNameLabel.numberOfLines = 2;
    
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    userNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:userNameLabel];
    
    if ([CloudManager sharedInstance].currentAccount.userLoginResponse.isLogined) {
        [userHeader setImageWithURL:[NSURL URLWithString:[CloudManager sharedInstance].currentAccount.userLoginResponse.avatar] placeholderImage:[UIImage imageNamed:@"image_default_userheader"]];
         userNameLabel.text = [CloudManager sharedInstance].currentAccount.userLoginResponse.nickname;
    }else{
        userHeader.image = [UIImage imageNamed:@"notLogin_default"];
        userNameLabel.text = @"登录";
    }
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, viewHeight - 50, Main_Screen_Width, 50)];
    [self addSubview:bottomView];
    CGFloat itemWidth = (Main_Screen_Width - 3)/ 3.0;
    
    UILabel *inPriceL = [[UILabel alloc]initWithFrame:CGRectMake(0, 4, itemWidth, 20)];
    inPriceL.textAlignment = NSTextAlignmentCenter;
    inPriceL.textColor = [UIColor whiteColor];
    inPriceL.text =  [CloudManager sharedInstance].currentAccount.userLoginResponse.profit;
    inPriceL.font = [UIFont systemFontOfSize:15];
    inPriceL.userInteractionEnabled = YES;
    [inPriceL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(earningClick)]];
    [bottomView addSubview:inPriceL];
    
    UILabel *inPriceTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(inPriceL.frame), itemWidth, 20)];
    inPriceTitleL.textAlignment = NSTextAlignmentCenter;
    inPriceTitleL.textColor = CELL_BORDER_COLOR;
    inPriceTitleL.text = @"收益";
    inPriceTitleL.font = [UIFont systemFontOfSize:15];
    inPriceTitleL.userInteractionEnabled = YES;
    [inPriceTitleL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(earningClick)]];
    [bottomView addSubview:inPriceTitleL];
    
    
    UILabel *splitL1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(inPriceL.frame), 8, 0.6, 24)];
    splitL1.backgroundColor = CELL_BORDER_COLOR;
    [bottomView addSubview:splitL1];
    
    
    
    
    UILabel *commentL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL1.frame), 4, itemWidth, 20)];
    commentL.textAlignment = NSTextAlignmentCenter;
    commentL.textColor = [UIColor whiteColor];
    commentL.text =  [CloudManager sharedInstance].currentAccount.userLoginResponse.score;
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
    
    
    
    UILabel *fansL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL2.frame), 4, itemWidth, 20)];
    fansL.textAlignment = NSTextAlignmentCenter;
    fansL.textColor = [UIColor whiteColor];
    fansL.text =  [CloudManager sharedInstance].currentAccount.userLoginResponse.fans;
    fansL.font = [UIFont systemFontOfSize:15];
    fansL.userInteractionEnabled = YES;
    [fansL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fansLableClick)]];
    [bottomView addSubview:fansL];
    
    UILabel *fansLTitleL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(splitL2.frame), CGRectGetMaxY(fansL.frame), itemWidth, 20)];
    fansLTitleL.textAlignment = NSTextAlignmentCenter;
    fansLTitleL.textColor = CELL_BORDER_COLOR;
    fansLTitleL.text = @"粉丝";
    fansLTitleL.font = [UIFont systemFontOfSize:15];
    fansLTitleL.userInteractionEnabled = YES;
    [fansLTitleL addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fansLableClick)]];
    [bottomView addSubview:fansLTitleL];
    
    
    
}

-(void)userHeaderClick{
    if (self.userHeaderViewHandler) {
        self.userHeaderViewHandler();
    }
}

-(void)earningClick{
    if (self.openMineEarningHandler) {
        self.openMineEarningHandler();
    }
}
-(void)fansLableClick{
    if (self.openMineFansHomeHandler) {
        self.openMineFansHomeHandler();
    }
}
+(CGFloat)eLiveHomeHeaderHeight{
    CGFloat height = Main_Screen_Width *9/16.0;
    return height;
}


@end
