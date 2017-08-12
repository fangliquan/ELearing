//
//  ELivePaymentView.m
//  wwface
//
//  Created by leo on 2017/5/26.
//  Copyright © 2017年 fo. All rights reserved.
//

#import "ELivePaymentView.h"

#import "UcCourseIndex.h"

@interface ELivePaymentView (){

    UILabel *payMoneyLab;
}

@property (nonatomic,strong)UIView *payInfoView;

@end
@implementation ELivePaymentView

- (instancetype)initWithFrame:(CGRect)frame {
    //注册通知
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.4];
    
    UIView *payInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 270)];
    payInfoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:payInfoView];
    self.payInfoView = payInfoView;
    
    UILabel *payTitleLab = [[UILabel alloc]init];
    [payInfoView addSubview:payTitleLab];
    payTitleLab.backgroundColor = [UIColor whiteColor];
    payTitleLab.text = @"付款详情";
    payTitleLab.textColor = EL_COLOR_RED;
    payTitleLab.font = EL_TEXTFONT_(16);
    payTitleLab.textAlignment = NSTextAlignmentCenter;
    [payTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payInfoView);
        make.height.equalTo(@30);
        make.top.equalTo(payInfoView.mas_top).offset(10);
        make.right.equalTo(payInfoView);
    }];
    
    UIButton *payCloseBtn = [[UIButton alloc]init];
    [payInfoView addSubview:payCloseBtn];
    [payCloseBtn setImage:[UIImage imageNamed:@"close_qa"] forState:UIControlStateNormal];
    [payCloseBtn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    [payCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payInfoView);
        make.top.equalTo(payInfoView.mas_top).offset(10);
        make.width.height.equalTo(@30);
    }];
    
    UIView *payLine1 = [[UIView alloc]init];
    [payInfoView addSubview:payLine1];
    payLine1.backgroundColor = CELL_BORDER_COLOR;
    [payLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payCloseBtn.mas_bottom).offset(10);
        make.height.equalTo(@0.6);
    }];
    
    UILabel *payDesLab = [[UILabel alloc]init];
    [payInfoView addSubview:payDesLab];
    payDesLab.backgroundColor = [UIColor whiteColor];
    payDesLab.text = @"支付";
    payDesLab.textAlignment = NSTextAlignmentCenter;
    payDesLab.font = EL_TEXTFONT_(12);
    payDesLab.textColor = EL_TEXTCOLOR_DARKGRAY;
    [payDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payLine1.mas_bottom).offset(6);
        make.height.equalTo(@20);
    }];
    
    payMoneyLab = [[UILabel alloc]init];
    [payInfoView addSubview:payMoneyLab];
    payMoneyLab.textColor = [UIColor blackColor];
    payMoneyLab.font = EL_TEXTFONT_(16);
    payMoneyLab.textAlignment = NSTextAlignmentCenter;
    [payMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payDesLab.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    UILabel *payTypeLab = [[UILabel alloc]init];
    [payInfoView addSubview:payTypeLab];
    payTypeLab.text = @"支付方式";
    payTypeLab.textColor = EL_TEXTCOLOR_DARKGRAY;
    payTypeLab.font = EL_TEXTFONT_(13);
    payTypeLab.backgroundColor = [UIColor whiteColor];
    [payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payInfoView).offset(10);
        make.right.equalTo(payInfoView).offset(-10);
        make.top.equalTo(payMoneyLab.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    UIView *payLine2 = [[UIView alloc]init];
    [payInfoView addSubview:payLine2];
    payLine2.backgroundColor = CELL_BORDER_COLOR;
    [payLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payTypeLab.mas_bottom);
        make.height.equalTo(@0.6);
    }];
    
    UIView *payWechatView = [[UIView alloc]init];
    [payInfoView addSubview:payWechatView];
    [payWechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payLine2.mas_bottom);
        make.left.right.equalTo(payInfoView);
        make.height.equalTo(@44);
    }];
    
    UITapGestureRecognizer* payWechatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWechatTap)];
    [payWechatView addGestureRecognizer:payWechatTap];
    
    UIImageView *payWechatImg = [[UIImageView alloc]init];
    [payWechatView addSubview:payWechatImg];
    payWechatImg.image = [UIImage imageNamed:@"pay_wechat"];
    [payWechatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payInfoView).offset(10);
        make.top.equalTo(payLine2.mas_bottom).offset(10);
        make.width.height.equalTo(@25);
    }];
    
    UILabel *payWechatLab = [[UILabel alloc]init];
    [payWechatView addSubview:payWechatLab];
    payWechatLab.backgroundColor = [UIColor whiteColor];
    payWechatLab.text = @"微信支付";
    payWechatLab.font = EL_TEXTFONT_(14);
    payWechatLab.textAlignment = NSTextAlignmentLeft;
    payWechatLab.textColor = EL_TEXTCOLOR_DARKGRAY;
    [payWechatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payInfoView).offset(-30);
        make.left.equalTo(payWechatImg.mas_right).offset(8);
        make.centerY.equalTo(payWechatImg);
        make.height.equalTo(@20);
    }];
    
    UIImageView *payArrowImg1 = [[UIImageView alloc]init];
    payArrowImg1.image = [UIImage imageNamed:@"arrow_qa"];
    [payWechatView addSubview:payArrowImg1];
    [payArrowImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payInfoView).offset(-10);
        make.centerY.equalTo(payWechatImg);
        make.height.equalTo(@13);
        make.width.equalTo(@8);
    }];
    
    UIView *payLine3 = [[UIView alloc]init];
    [payInfoView addSubview:payLine3];
    payLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [payLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payWechatImg.mas_bottom).offset(10);
        make.height.equalTo(@0.6);
    }];
    
    UIView *payAliView = [[UIView alloc]init];
    [payInfoView addSubview:payAliView];
    [payAliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payLine3.mas_bottom);
        make.left.right.equalTo(payInfoView);
        make.height.equalTo(@44);
    }];
    
    UITapGestureRecognizer* payAliTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payAliTap)];
    [payAliView addGestureRecognizer:payAliTap];
    
    UIImageView *payAliImg = [[UIImageView alloc]init];
    [payAliView addSubview:payAliImg];
    payAliImg.image = [UIImage imageNamed:@"pay_ali"];
    [payAliImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payInfoView).offset(10);
        make.top.equalTo(payLine3.mas_bottom).offset(10);
        make.width.height.equalTo(@25);
    }];
    
    UILabel *payAliLab = [[UILabel alloc]init];
    [payAliView addSubview:payAliLab];
    payAliLab.backgroundColor = [UIColor whiteColor];
    payAliLab.text = @"支付宝钱包支付";
    payAliLab.font = EL_TEXTFONT_(14);
    payAliLab.textAlignment = NSTextAlignmentLeft;
    payAliLab.textColor = EL_TEXTCOLOR_DARKGRAY;
    [payAliLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payInfoView).offset(-30);
        make.left.equalTo(payAliImg.mas_right).offset(8);
        make.centerY.equalTo(payAliImg);
        make.height.equalTo(@20);
    }];
    
    UIImageView *payArrowImg2 = [[UIImageView alloc]init];
    payArrowImg2.image = [UIImage imageNamed:@"arrow_qa"];
    [payAliView addSubview:payArrowImg2];
    [payArrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payInfoView).offset(-10);
        make.centerY.equalTo(payAliImg);
        make.height.equalTo(@13);
        make.width.equalTo(@8);
    }];
    
    
    UIView *payLine4 = [[UIView alloc]init];
    [payInfoView addSubview:payLine4];
    payLine4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [payLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(payInfoView);
        make.top.equalTo(payAliImg.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *payLogo = [[UIImageView alloc]init];
    [payInfoView addSubview:payLogo];
    payLogo.image = [UIImage imageNamed:@"pay_logo"];
    [payLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payLine4.mas_bottom).offset(15);
        make.centerX.equalTo(payInfoView);
        make.height.equalTo(@13);
        make.width.equalTo(@60);
    }];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self addGestureRecognizer:tap];

}

-(void)show:(CourseBuyReasultModel *)weiyinPayRequest{

    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) {
        keyWindow = [[UIApplication sharedApplication].windows firstObject];
    }
    [keyWindow addSubview:self];
    payMoneyLab.text =[NSString stringWithFormat:@"总金额¥%@,需要支付￥%@",weiyinPayRequest.total_amount,weiyinPayRequest.need_pay];
    self.center = CGPointMake(keyWindow.bounds.size.width/2.0f, keyWindow.bounds.size.height/2.0f);
    [self animateShow];
}

- (void)hidden {
    [self animateHidden];
}


-(void)payWechatTap{
    [self hidden];
    if (self.userSelectPayActionBlock) {
        self.userSelectPayActionBlock(1);
    }
}

-(void)payAliTap{
    [self hidden];
    if (self.userSelectPayActionBlock) {
        self.userSelectPayActionBlock(2);
    }
}


#pragma mark - Animated Mthod
- (void)animateShow {
    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    self.alpha = 0;
    CGRect oldFrame =self.payInfoView.frame;
    oldFrame.origin.y = Main_Screen_Height;
    self.payInfoView.frame = oldFrame;
    
    [UIView animateWithDuration:0.45 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
        CGRect oldFrame =self.payInfoView.frame;
        oldFrame.origin.y = Main_Screen_Height - 270;
        self.payInfoView.frame = oldFrame;
    }];
}

- (void)animateHidden {
    [UIView animateWithDuration:0.45 animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 0.0;
        CGRect oldFrame =self.payInfoView.frame;
        oldFrame.origin.y = Main_Screen_Height;
        self.payInfoView.frame = oldFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


@end
