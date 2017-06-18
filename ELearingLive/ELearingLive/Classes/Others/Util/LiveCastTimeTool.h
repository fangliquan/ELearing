//
//  LiveCastTimeTool.h
//  
//
//  Created by leo on 16/6/23.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveCastTimeTool : NSObject


+(NSArray *)daysFromNowToSevenDay;

+(NSArray *)daysStrFromNowToSevenDay;

+(NSInteger)currentDateHour;

+(NSInteger)currentDateMinute;

+(NSString *)displayedSummaryTimeUsingString:(NSString *)string;

@end
