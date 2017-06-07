//
//  HomeIndex.m
//  ELearingLive
//
//  Created by microleo on 2017/6/6.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "HomeIndex.h"

@implementation HomeIndex
//
//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"snewsSearchs" : @"newsSearchs"};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"slider":[IndexSliderModel class],@"cates":[IndexCatesModel class],@"recommand":[IndexRecommandModel class]};
}


@end

@implementation IndexSliderModel


@end

@implementation IndexCatesModel



@end

@implementation IndexRecommandModel



@end
