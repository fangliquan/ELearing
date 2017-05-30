//
//  ELiveMainCateViewCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELiveMainCateModel;
@interface ELiveMainCateViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property(nonatomic,strong) ELiveMainCateModel *eLiveMainCateModel;

@end

@interface ELiveMainCateModel : NSObject

@property(nonatomic,strong) NSString *title;
@end
