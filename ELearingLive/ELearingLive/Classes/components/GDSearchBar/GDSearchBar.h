//
//  GDSearchBar.h
//  GDMall
//
//  Created by 陆存璐 on 16/10/31.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDSearchBar : UISearchBar

@property (nonatomic, copy) void (^searchBarShouldBeginEditingBlock)(); // 点击回调
@property (nonatomic, copy) void (^searchBarTextDidChangedBlock)();     // 编辑回调
@property (nonatomic, copy) void (^searchBarDidSearchBlock)();          // 编辑回调

+ (GDSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder;

@end
