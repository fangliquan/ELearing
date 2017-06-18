//
//  LiveTimePickerView.h
//
//
//  Created by leo on 16/6/23.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveTimePickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

-(id)initWithFrame:(CGRect)frame completeBlock:(void (^)(NSDictionary *infoDic))completeBlock;

-(void)updateReLoadDate;

@end
