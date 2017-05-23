//
//  ELiveVCManagerHelper.h
//  ELearingLive
//
//  Created by microleo on 2017/5/23.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELiveVCManagerHelper : NSObject

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;


@end
