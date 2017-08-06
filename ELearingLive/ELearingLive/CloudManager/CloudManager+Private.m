//
//  CloudManager+Private.m
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManager+Private.h"

@implementation CloudManager(Private)

-(NSString *)uriBase {
    return [NSString stringWithFormat:@"%@", DEFAULT_SERVER_ADDRESS];
}
-(NSString*)uriAppInit{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/index/init", ret];
    return ret;
}

-(NSString *)uriAppFeedback{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/index/feedback", ret];
    return ret;
}

-(NSString *)uriBaseUser {
    return [NSString stringWithFormat:@"%@", [self uriBase]];
}




-(NSString *)uriPhoneLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/passport/login", ret];
    
    return ret;
}
-(NSString *)uriPhoneRegister{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/phone-register", ret];
    
    return ret;
}

-(NSString *)uriRegisterCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/send-register-code", ret];
    
    return ret;
}

//退出登录
-(NSString *)uriLogout {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/passport/logout", ret];
    return ret;
}

//忘记密码 获取验证码
-(NSString *)uriSendForgetPwdCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/send-forget-pwd-code", ret];
    
    return ret;
}
//验证新的验证码
-(NSString *)uriCheckForgetPwdCode{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/check-forget-pwd-code", ret];
    
    return ret;
}
//设置新密码
-(NSString *)uriSetNewPwd{
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/set-new-pwd", ret];
    
    return ret;
}

//根据用户的code设置密码
-(NSString *)uriSetPasswordByCode {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/set-pwd-by-code", ret];
    return ret;
}

//微信登陆
-(NSString *)uriWechatLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/wechat-login", ret];
    return  ret;
}

//QQ登陆
-(NSString *)uriQQLogin {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/qq-login", ret];
    return  ret;
}

//微信bind
-(NSString *)uriWechatBindUser {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/wechat-bind-user", ret];
    return ret;
}

//QQ bind
-(NSString *)uriQQBindUser {
    NSString *ret = @"";
    ret = [self uriBaseUser];
    ret = [[NSString alloc] initWithFormat:@"%@/qq-bind-user",ret];
    return ret;
}

-(NSString *)uriBaseProfile {
    return [NSString stringWithFormat:@"%@/api/profile", [self uriBase]];
}



//讲师申请
-(NSString *)uriUcAuthTeacher{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/authteacher",ret];
    return ret;
}
//是否讲师认证
-(NSString *)uriUcIsTeacher{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/isteacher",ret];
    return ret;
}

-(NSString *)uriUcEditUser{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/edituser",ret];
    return ret;
}
-(NSString *)uriUcUserInfo{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/userinfo",ret];
    return ret;
}


///uc/avatar用户头像
-(NSString *)uriUcUserAvatar{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/avatar",ret];
    return ret;
}


///uc/myfollowteacher
//我关注的讲师
-(NSString *)uriUcMyFollowTeacher{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/myfollowteacher",ret];
    return ret;
    
}

-(NSString *)uriUcBindMobile{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/bindmobile",ret];
    return ret;
}


-(NSString *)uriHomeIndex{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/index/index",ret];
    return ret;
}
///teacher/info 讲师主页
-(NSString *)uriTeacherInfo{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/info",ret];
    return ret;
}

///teacher/courselist 讲师的课程列表
-(NSString *)uriTeacherCourseList{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/courselist",ret];
    return ret;
}
//评价讲师 /teacher/evaluate
-(NSString *)uriTeacherEvaluate{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/evaluate",ret];
    return ret;
}
//评价讲师列表 /teacher/evaluatelist
-(NSString *)uriTeacherEvaluateList{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/evaluatelist",ret];
    return ret;
}


///teacher/follow 关注讲师
-(NSString *)uriTeacherfollow{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/follow",ret];
    return ret;
}
///teacher/unfollow 取消关注讲师
-(NSString *)uriTeacherunfollow{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/teacher/unfollow",ret];
    return ret;
}



///course/categires 课程主分类
-(NSString *)uriCourseCategires{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/categires",ret];
    return ret;
}

///course/children 课程子分类
-(NSString *)uriCourseChildren{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/children",ret];
    return ret;
}
///course/info 课程信息
-(NSString *)uriCourserInfo{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/info",ret];
    return ret;
}
///course/save
-(NSString *)uriCourseInfoSave{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/save",ret];
    return ret;
}

///course/chapterlist 课程详情目录
-(NSString *)uriCourseChapterlist{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/chapterlist",ret];
    return ret;
}

///course/evaluatelist 课程详情评价列表
-(NSString *)uriCourseEvaluatelist{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/evaluatelist",ret];
    return ret;
}

///course/create 创建课程
-(NSString *)uriCourseCreate{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/create",ret];
    return ret;
}
///course/evaluate 课程详情评价
-(NSString *)uriCourseEvaluate{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/evaluate",ret];
    return ret;
}

-(NSString *)uriCoursefollow{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/follow",ret];
    return ret;
}
///course/unfollow 取消关注课程
-(NSString *)uriCourseunfollow{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/unfollow",ret];
    return ret;
}
///course/list课程分类类别
-(NSString *)uriCourseList{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/list",ret];
    return ret;
}

///course/buy 购买课程
-(NSString *)uriCourseBuy{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/buy",ret];
    return ret;
}
///payment/ beforepayorder
-(NSString *)uriCoursebeforepayorder{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/payment/beforepayorder",ret];
    return ret;
    
}
///uc/myfollowcourse
-(NSString *)uriCourseMyFollower{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/myfollowcourse",ret];
    return ret;
}

//////uc/myjoincourse 我听过的课程
-(NSString *)uriCourseMyjoincourse{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/myjoincourse",ret];
    return ret;
}

////uc/topiccourse 专题课程
-(NSString *)uriCourseTopic{
    
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/topiccourse",ret];
    return ret;
}
///course/search 搜索课程
-(NSString *)uriCourseSearch{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/search",ret];
    return ret;
}


///course/mycourses 课程日历模式
-(NSString *)uriCourseMyCourse{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/mycourses",ret];
    return ret;
}
///course/start 开始直播推流
-(NSString *)uriCourseStart{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/start",ret];
    return ret;
}
///course/finish 直播推流结束
-(NSString *)uriCourseFinish{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/finish",ret];
    return ret;
}
///course/postprogress
-(NSString *)uriCoursePostprogress{
   NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/postprogress",ret];
    return ret;
}
///course/playinfo获取播放详情

-(NSString *)uriCoursePlayinfo{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/playinfo",ret];
    return ret;
}
///course/infoforedit
-(NSString *)uriCourseInfoForEdit{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/course/infoforedit",ret];
    return ret;
}
///uc/myfans 我的粉丝
-(NSString *)uriUcMyFans{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/myfans",ret];
    return ret;
}

///uc/incomings 收益
-(NSString *)uriUcMyIncomings{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/uc/incomings",ret];
    return ret;
}


////passport/extlogin 第三方登录
-(NSString *)uriPassportLogin{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/passport/extlogin",ret];
    return ret;
}
///passport/extbind 绑定
-(NSString *)uriPassportBind{
    NSString *ret = @"";
    ret = [self uriBase];
    ret = [[NSString alloc] initWithFormat:@"%@/passport/extbind",ret];
    return ret;
}
@end
