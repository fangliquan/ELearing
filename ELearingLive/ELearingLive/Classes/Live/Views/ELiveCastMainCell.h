//
//  ELiveCastMainCell.h
//  ELearingLive
//
//  Created by microleo on 2017/6/4.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELiveCastMainCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) NSString *hedoneVedioDTO;


+(CGFloat)cellHeightWithModel:(NSString *)str;



@end
