//
//  HomeIndex.h
//  ELearingLive
//
//  Created by microleo on 2017/6/6.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "BaseModel.h"

@interface HomeIndex : BaseModel

@property(nonatomic,strong) NSArray *slider;

@property(nonatomic,strong) NSArray *cates;


@property(nonatomic,strong) NSArray *recommand;


@end

@interface IndexSliderModel : NSObject

/*
 "title": "1",
 "thumb": "http://api.yxb.qgpx.com/pic/2017/0601/e1381be525e21edc651fd00754153c08.jpg",
 "topicid": "1"*
 */
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *topicid;
@end

@interface IndexCatesModel : NSObject
/*
 "thumb": "http://api.yxb.qgpx.com/default.jpg",
 "catid": 4,
 "name": "哲学"
 */
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *catid;

@end

@interface IndexRecommandModel : NSObject

@property(nonatomic,strong) NSString *courseid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *teacherid;
@property(nonatomic,strong) NSString *teacher_avatar;
@property(nonatomic,strong) NSString *teacher_name;

/*
 "courseid": "4",
 "name": "逻辑思维到底还能持续多就？",
 "thumb": "http://api.yxb.qgpx.com/pic/2017/0601/e1381be525e21edc651fd00754153c08.jpg",
 "status": "直播中",
 "time": "2017-05-25 09:47:31",
 "teacherid": "17327",
 "teacher_avatar": "http://api.yxb.qgpx.com/default.jpg",
 "teacher_name": "137****8142"
 */
@end
