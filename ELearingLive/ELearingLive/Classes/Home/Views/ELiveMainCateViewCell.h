//
//  ELiveMainCateViewCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UcCourseCategireMainItem,UcCourseCategireChildItem;
@interface ELiveMainCateViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

+ (CGFloat)heightForCellWithModel:(NSString *)remark ;

@property(nonatomic,strong) UcCourseCategireMainItem *courseCategireMainItem;


@end


@interface ELiveCateChildrenView : UIView

@property(nonatomic,strong) UcCourseCategireChildItem *courseCategireChildItem;

@property (nonatomic, copy) void (^courseCateItemHandler)(UcCourseCategireChildItem *childItem);

+(CGFloat)childrenViewWidth:(NSString *)name;

@end
@interface ELiveMainCateModel : NSObject

@property(nonatomic,strong) NSString *title;


@end

