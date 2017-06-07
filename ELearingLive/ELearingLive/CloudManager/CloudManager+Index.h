//
//  CloudManger+Login.h
//  GDMall
//
//  Created by microleo on 2016/10/29.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "CloudManagerBase.h"
#import "HomeIndex.h"
@interface CloudManager (Index)


- (void)asyncGetHomeIndexData:(void (^)(HomeIndex *ret, CMError *error))completion;


@end
