//
//  ELiveSettingHeaderView.h
//  ELearingLive
//
//  Created by microleo on 2017/5/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveSettingHeaderView : UIView

@property (nonatomic, copy) void (^openMineFansHomeHandler)(void);

@property (nonatomic, copy) void (^openMineEarningHandler)(void);


@property (nonatomic, copy) void (^userHeaderViewHandler)(void);
@end
