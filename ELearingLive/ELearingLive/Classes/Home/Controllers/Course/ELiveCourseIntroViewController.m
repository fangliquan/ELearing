//
//  ELiveCourseIntroViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/13.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseIntroViewController.h"

@interface ELiveCourseIntroViewController ()

@end

@implementation ELiveCourseIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeaderView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewControllerFrame:(CGRect)frame {

}

-(void)createHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 90, 20)];
    titleLabel.text = @"企业管理秘籍";
    titleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:titleLabel];
    
    UILabel *priceLabel= [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80, 15, 70, 20)];
    priceLabel.text = @"$45.00";
    priceLabel.textColor = EL_COLOR_RED;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:priceLabel];
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 5,80, 20)];
    commentLabel.text = @"45人报名";
    commentLabel.textColor = EL_TEXTCOLOR_GRAY;
    commentLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:commentLabel];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 210, CGRectGetMaxY(titleLabel.frame) + 5,200, 20)];
    timeLabel.text = @"直播时间:2016-09-18 13:00";
    timeLabel.textColor = EL_TEXTCOLOR_GRAY;
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:timeLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(commentLabel.frame) + 15, Main_Screen_Width, 0.6)];
    line.backgroundColor = CELL_BORDER_COLOR;
    [headerView addSubview:line];
    
    
    UILabel *courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(line.frame) + 15, 70, 20)];
    courseTitleLabel.text = @"课程描述";
    courseTitleLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    courseTitleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:courseTitleLabel];
    
    
    UILabel *courseDespLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(courseTitleLabel.frame)+ 6, Main_Screen_Width - 20, 70)];
    courseDespLabel.text = @"课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述课程描述";
    courseDespLabel.textColor = EL_TEXTCOLOR_GRAY;
    courseDespLabel.font = [UIFont systemFontOfSize:14];
    courseDespLabel.numberOfLines = 0;
    [headerView addSubview:courseDespLabel];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(courseDespLabel.frame) + 15, Main_Screen_Width, 0.6)];
    line2.backgroundColor = CELL_BORDER_COLOR;
    [headerView addSubview:line2];
    
    
    
    UIImageView *userHeader = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line2.frame) + 20, 50, 50)];
    userHeader.layer.masksToBounds = YES;
    userHeader.layer.cornerRadius = 25;
    userHeader.image = [UIImage imageNamed:@"image_default_userheader"];
    [headerView addSubview:userHeader];
    
    
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeader.frame) +6, CGRectGetMaxY(line2.frame) + 10, Main_Screen_Width - CGRectGetMaxX(userHeader.frame) - 12, 80)];
    userNameLabel.numberOfLines = 2;
    userNameLabel.text = @"王大大";
    userNameLabel.font = [UIFont systemFontOfSize:EL_TEXTFONT_FLOAT_TITLE];
    userNameLabel.textColor = EL_TEXTCOLOR_DARKGRAY;
    [headerView addSubview:userNameLabel];
    
    headerView.frame = CGRectMake(0, 0, Main_Screen_Width, CGRectGetMaxY(userNameLabel.frame) + 15);
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
