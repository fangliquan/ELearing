//
//  ELiveMineFocusCourseViewController.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveMineFocusCourseViewController : UITableViewController

@property(nonatomic,assign) BOOL showMoreBtn;

@property(nonatomic,assign) BOOL isMyListen;

@property(nonatomic,assign) BOOL isTopicData;

@property(nonatomic,strong) NSString *topicId;
@end
