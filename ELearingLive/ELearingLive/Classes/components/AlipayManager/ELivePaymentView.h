//
//  ELivePaymentView
//  wwface
//
//  Created by leo on 2017/5/26.
//  Copyright © 2017年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseBuyReasultModel;
@interface ELivePaymentView : UIView

-(void)show:(CourseBuyReasultModel *)weiyinPayRequest;

@property(nonatomic,copy)void(^(userSelectPayActionBlock))(int payment);


@end
