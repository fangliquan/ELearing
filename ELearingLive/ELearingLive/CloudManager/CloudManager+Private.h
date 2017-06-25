//
//  CloudManager+Private.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"

@interface CloudManager(Private)


-(NSString *)uriBase;
-(NSString *)uriAppInit;
//反馈
-(NSString *)uriAppFeedback;
-(NSString *)uriPhoneLogin;
-(NSString *)uriPhoneRegister;
-(NSString *)uriRegisterCode;
//微信登陆
-(NSString *)uriWechatLogin;
//QQ登陆
-(NSString *)uriQQLogin;
//微信bind
-(NSString *)uriWechatBindUser;
//QQ bind
-(NSString *)uriQQBindUser;

//退出登录
-(NSString *)uriLogout;

//忘记密码 获取验证码
-(NSString *)uriSendForgetPwdCode;
//验证新的验证码
-(NSString *)uriCheckForgetPwdCode;
//设置新密码
-(NSString *)uriSetNewPwd;

//根据用户的code设置密码
-(NSString *)uriSetPasswordByCode;


//讲师申请
-(NSString *)uriUcAuthTeacher;
//是否讲师认证
-(NSString *)uriUcIsTeacher;
//编辑用户信息
-(NSString *)uriUcEditUser;
//用户信息
-(NSString *)uriUcUserInfo;

///uc/avatar用户头像
-(NSString *)uriUcUserAvatar;

///uc/myfollowteacher
//我关注的讲师
-(NSString *)uriUcMyFollowTeacher;
///uc/bindmobile绑定手机号
-(NSString *)uriUcBindMobile;

///uc/bindmobile绑定手机号
-(NSString *)uriHomeIndex;

///teacher/info 讲师主页
-(NSString *)uriTeacherInfo;

///teacher/courselist 讲师的课程列表
-(NSString *)uriTeacherCourseList;
//评价讲师 /teacher/evaluate
-(NSString *)uriTeacherEvaluate;
//评价讲师列表 /teacher/evaluatelist
-(NSString *)uriTeacherEvaluateList;
///teacher/follow 关注讲师
-(NSString *)uriTeacherfollow;
///teacher/unfollow 取消关注讲师
-(NSString *)uriTeacherunfollow;



///course/categires 课程主分类
-(NSString *)uriCourseCategires;
///course/children 课程子分类
-(NSString *)uriCourseChildren;
///course/info 课程信息
-(NSString *)uriCourserInfo;
///course/chapterlist 课程详情目录
-(NSString *)uriCourseChapterlist;
///course/evaluatelist 课程详情评价列表
-(NSString *)uriCourseEvaluatelist;

///course/create 创建课程
-(NSString *)uriCourseCreate;

///course/evaluate 课程详情评价
-(NSString *)uriCourseEvaluate;
///course/follow 关注课程
-(NSString *)uriCoursefollow;
///course/unfollow 取消关注课程
-(NSString *)uriCourseunfollow;
///course/list课程分类类别
-(NSString *)uriCourseList;
///course/buy 购买课程
-(NSString *)uriCourseBuy;
///payment/ beforepayorder
-(NSString *)uriCoursebeforepayorder;

///uc/myfollowcourse 我关注的课程
-(NSString *)uriCourseMyFollower;

////uc/myjoincourse 我听过的课程
-(NSString *)uriCourseMyjoincourse;

////uc/topiccourse 专题课程
-(NSString *)uriCourseTopic;

///course/search 搜索课程
-(NSString *)uriCourseSearch;

///course/mycourses 课程日历模式
-(NSString *)uriCourseMyCourse;

///course/start 开始直播推流
-(NSString *)uriCourseStart;
///course/finish 直播推流结束
-(NSString *)uriCourseFinish;
///course/postprogress
-(NSString *)uriCoursePostprogress;
@end
