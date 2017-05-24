//
//  ELiveCourseCatalogCell.h
//  ELearingLive
//
//  Created by microleo on 2017/5/24.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELiveCourseCatalogCellFrame;
@interface ELiveCourseCatalogCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;
@property(nonatomic,strong) ELiveCourseCatalogCellFrame *cellFrame;
@end

@interface ELiveCourseCatalogCellFrame: NSObject

@property (nonatomic,strong) NSString *temp;

@property (nonatomic, assign) CGRect  stateLFrame;
@property (nonatomic, assign) CGRect  titleLFrame;
@property (nonatomic, assign) CGRect  timeLFrame;
@property (nonatomic, assign) CGRect  couseNumLFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
