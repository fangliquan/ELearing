//
//  ELiveSettingUserInfoViewCell.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingUserInfoViewCell.h"
#import "PHTextView.h"
#import "UserTruthInfo.h"
@interface ELiveSettingUserInfoViewCell()<UITextViewDelegate> {
    
    UILabel *titleLable;
    PHTextView *phTextView;
}

@end

@implementation ELiveSettingUserInfoViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ELiveSettingUserInfoViewCell";
    ELiveSettingUserInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[ELiveSettingUserInfoViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    titleLable = [[UILabel alloc]init];
    titleLable.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLable.font = [UIFont systemFontOfSize :EL_TEXTFONT_FLOAT_TITLE];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLable];
    
    phTextView = [[PHTextView alloc]init];
    phTextView.placeholder = @"请输入...";
    phTextView.tintColor = EL_TEXTCOLOR_GRAY;
    phTextView.keyboardType = UIKeyboardTypeDefault;
    phTextView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.6];
    phTextView.textColor = EL_TEXTCOLOR_DARKGRAY;
    phTextView.font = [UIFont systemFontOfSize:15];
    phTextView.delegate = self;
    [self.contentView addSubview:phTextView];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@75);
        make.top.equalTo (self.contentView.mas_top).offset (18);
    }];
    
    [phTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_right).offset(4);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo (self.contentView.mas_top).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
    }];
}

-(void)setSettingUserInfoModel:(ELiveSettingUserInfoModel *)settingUserInfoModel{
    _settingUserInfoModel = settingUserInfoModel;
    
    titleLable.text = settingUserInfoModel.title;
    phTextView.text = settingUserInfoModel.content;

    if (settingUserInfoModel.type ==ELive_Set_User_Phone) {
        phTextView.placeholder = @"请输入手机号";
        phTextView.text =_userTruthInfo.mobile;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Name) {
        phTextView.placeholder = @"请输入姓名";
        phTextView.text = _userTruthInfo.real_name;
    }else if (settingUserInfoModel.type ==ELive_Set_User_ID) {
        phTextView.placeholder = @"请输入身份证";
        phTextView.text =_userTruthInfo.idcard;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Email) {
        phTextView.placeholder = @"请输入邮箱";
         phTextView.text =_userTruthInfo.email;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Desp) {
        phTextView.placeholder = @"请输入简介";
         phTextView.text =_userTruthInfo.intro;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Commpany) {
        phTextView.placeholder = @"请输入公司名称";
         phTextView.text =_userTruthInfo.commpany;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Profession) {
        phTextView.placeholder = @"请输入职业";
         phTextView.text =_userTruthInfo.profession;
    }else if (settingUserInfoModel.type ==ELive_Set_User_Age) {
        phTextView.placeholder = @"请输入年龄";
        phTextView.text =_userTruthInfo.age;
    }
    
    if (settingUserInfoModel.type ==ELive_Set_User_Header) {
        phTextView.hidden = YES;
    }else{
         phTextView.hidden = NO;
    }

}


-(void)setIsUserInfo:(BOOL)isUserInfo{
    _isUserInfo = isUserInfo;
    if (isUserInfo) {
        phTextView.backgroundColor = [UIColor whiteColor];
        phTextView.textAlignment = NSTextAlignmentRight;
    }else{
        phTextView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.6];
        phTextView.textAlignment = NSTextAlignmentLeft;
    }
        
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length >0) {
        self.settingUserInfoModel.content = textView.text;
        if (_settingUserInfoModel.type ==ELive_Set_User_Phone) {
            _userTruthInfo.mobile = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Name) {
            _userTruthInfo.real_name = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_ID) {
            _userTruthInfo.idcard = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Email) {
            _userTruthInfo.email = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Desp) {
           _userTruthInfo.intro = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Commpany) {
            _userTruthInfo.commpany = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Profession) {
            _userTruthInfo.profession = phTextView.text;
        }else if (_settingUserInfoModel.type ==ELive_Set_User_Age) {
            _userTruthInfo.age = phTextView.text;
        }
    }
}
@end

@implementation ELiveSettingUserInfoModel



@end
