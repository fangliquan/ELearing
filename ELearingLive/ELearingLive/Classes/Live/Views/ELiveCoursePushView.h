//
//  ELiveCoursePushView.h
//  ELearingLive
//
//  Created by microleo on 2017/6/25.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveCoursePushView : UIView

@property (nonatomic, copy) void (^closeLiveHandler)(void);

@property (nonatomic, copy) void (^changeCarmeLiveHandler)(void);


- (instancetype)initWithFrame:(CGRect)frame andLivePlayer:(BOOL)livePlayer  andisScreenHorizontal:(BOOL)isScreenHorizontal;

@end
