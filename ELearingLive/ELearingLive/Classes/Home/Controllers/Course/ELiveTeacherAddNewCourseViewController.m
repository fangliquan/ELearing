//
//  ELiveTeacherAddNewCourseViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/15.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveTeacherAddNewCourseViewController.h"
#import "ELiveCreateCourseCell.h"
#import "ELiveSearchCourseCateViewController.h"
#import "UcTeacherModel.h"
#import "UcCourseIndex.h"
#import "TZImagePickerController.h"
#import "ELiveTeacherSettingCourseTypeViewController.h"
@interface ELiveTeacherAddNewCourseViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) TeacherCreateCourseInfo *teacherCourseInfo;

@end

@implementation ELiveTeacherAddNewCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.teacherCourseInfo = [[TeacherCreateCourseInfo alloc]init];
    
    self.teacherCourseInfo.courseCates = [NSMutableArray array];
    self.teacherCourseInfo.courseItemsTime = [NSMutableArray array];
    
    [self createData];
    [self configtableView];
    
    [self createFooterView:YES];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];
    if (self.isEdit) {
        
    }
    
}

-(void)getCourseData{
    
}


- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {

    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)createData{
    
    CreateTimeModel *addCourse2 = [[CreateTimeModel alloc]init];
    addCourse2.isAddCourse = NO;
    addCourse2.coursePId = @"1";
    [self.teacherCourseInfo.courseItemsTime addObject:addCourse2];
    
    CreateTimeModel *addCourse = [[CreateTimeModel alloc]init];
    addCourse.isAddCourse = YES;
    [self.teacherCourseInfo.courseItemsTime addObject:addCourse];
    
    UcCourseCategireChildItem *cateItem = [[UcCourseCategireChildItem alloc]init];
    cateItem.childid = @"0";
    [self.teacherCourseInfo.courseCates addObject:cateItem];
    

    [self.tableView reloadData];
}

-(void)hiddenTextView{
    [self.view endEditing:YES];
}

-(void)createFooterView:(BOOL)enable{
    

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30,10, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = enable? EL_COLOR_RED:CELL_BORDER_COLOR;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.enabled = enable;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(saveUserInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitBtn];
    self.tableView.tableFooterView = footerView;
}


-(void)createHeaderView:(BOOL)IsTeacher{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
    UILabel *despLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, Main_Screen_Width - 40, 60)];
    despLabel.textColor = EL_TEXTCOLOR_GRAY;
    despLabel.text = IsTeacher?@"您已经是讲师了":@"您的讲师资格正在审核";
    despLabel.textAlignment = NSTextAlignmentCenter;
    despLabel.font = [UIFont systemFontOfSize:17];
    despLabel.numberOfLines = 0;
    
    [headerView addSubview:despLabel];
    self.tableView.tableHeaderView =headerView;
    
}

-(void)saveUserInfoClick{
    if (_teacherCourseInfo.courseSubject.length <=0) {
        [MBProgressHUD showError:@"请输入主题" toView:nil];
        return;
    }
    
    if (_teacherCourseInfo.courseSubject.length <=0) {
        [MBProgressHUD showError:@"请输入简介" toView:nil];
        return;
    }
    
    if (!_teacherCourseInfo.courseCover) {
        [MBProgressHUD showError:@"请添加封面" toView:nil];
        return;
    }
    
    if (_teacherCourseInfo.courseCates.count <2) {
        [MBProgressHUD showError:@"请添加分类" toView:nil];
        return;
    }
    
    ELiveTeacherSettingCourseTypeViewController *typeVc = [[ELiveTeacherSettingCourseTypeViewController alloc]init];
    typeVc.teacherCourseInfo = self.teacherCourseInfo;
    [self.navigationController pushViewController:typeVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) {
        return 1;
    }else if (section ==1) {
        return self.teacherCourseInfo.courseItemsTime.count;
    }
    return 1;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    if (indexPath.section ==3) {
        return 190;
    }
    if (indexPath.section ==4) {
        return 190;
    }
    return 90;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __unsafe_unretained typeof(self) unself = self;
    if (indexPath.section ==0) {
        ELiveCreateCourseCell *subCell = [ELiveCreateCourseCell cellWithTableView:tableView];
        subCell.isCourseIntro = NO;
        subCell.createCourseInfo = self.teacherCourseInfo;
        return subCell;
    }else if(indexPath.section ==1){
        ELiveCreateCourseTimeCell *timeCell = [ELiveCreateCourseTimeCell cellWithTableView:tableView];
        timeCell.deleteCourseTimeHandler = ^(CreateTimeModel *timeModel) {
            for (CreateTimeModel *currentT in unself.teacherCourseInfo.courseItemsTime) {
                if (!currentT.isAddCourse && [currentT.coursePId isEqualToString:timeModel.coursePId]) {
                    [unself.teacherCourseInfo.courseItemsTime removeObject:currentT];
                    break;
                }
            }
            [unself.tableView reloadData];
        };
        timeCell.addNewCourseTimeHandler = ^{
            CreateTimeModel *addCourseNew = [[CreateTimeModel alloc]init];
            addCourseNew.isAddCourse = NO;
            addCourseNew.coursePId = [NSString stringWithFormat:@"%ld", unself.teacherCourseInfo.courseItemsTime.count ];
            [unself.teacherCourseInfo.courseItemsTime insertObject:addCourseNew atIndex:unself.teacherCourseInfo.courseItemsTime.count-1] ;
            [unself.tableView reloadData];
        };
        timeCell.createTimeModel = self.teacherCourseInfo.courseItemsTime.count >indexPath.row?self.teacherCourseInfo.courseItemsTime[indexPath.row]:nil;
        return timeCell;
    }else if(indexPath.section ==2){
        ELiveCreateAddCateCell *cateCell = [ELiveCreateAddCateCell cellWithTableView:tableView];
        cateCell.createCourseInfo = self.teacherCourseInfo;
        cateCell.addCourseCateHandler = ^(UcCourseCategireChildItem *cateItem) {
            ELiveSearchCourseCateViewController *selectVc = [[ELiveSearchCourseCateViewController alloc]init];
            selectVc.isSelctCate = YES;
            selectVc.selectedCateHandler = ^(UcCourseCategireChildItem *cateItem) {
                [unself.teacherCourseInfo.courseCates insertObject:cateItem atIndex:0];
                [unself.tableView reloadData];
            };
            [unself.navigationController pushViewController:selectVc animated:YES];
        };
        return cateCell;
    }else if(indexPath.section ==3){
        ELiveCreateAddCoverCell *coverCell = [ELiveCreateAddCoverCell cellWithTableView:tableView];
        coverCell.createCourseInfo = self.teacherCourseInfo;
        coverCell.addCourseCoverHandler = ^{
            [unself addCourseCover];
        };
        return coverCell;
    }else if(indexPath.section ==4) {
        ELiveCreateCourseCell *subCell = [ELiveCreateCourseCell cellWithTableView:tableView];
        subCell.isCourseIntro = YES;
        subCell.createCourseInfo = self.teacherCourseInfo;
        return subCell;
    }else {
        ELiveCreateCourseCell *subCell = [ELiveCreateCourseCell cellWithTableView:tableView];
        subCell.isCourseIntro = YES;
        subCell.createCourseInfo = self.teacherCourseInfo;
        return subCell;
    }


    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}


-(void)addCourseCover{
    typeof(self) __weak weakSelf = self;
    UIActionSheet * actionSheet = [UIActionSheet bk_actionSheetWithTitle:@"请选择" destructiveTitle:@"拍一张" otherButtonTitles:@[@"从手机相册选择"] cancelButtonTitle:@"取消" andDidDismissBlock:^(UIActionSheet *sheet, NSInteger buttonIndex) {
        if(buttonIndex == 0) {
            if (![WWPermissionManager hasPermissionForCapture]) return;
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = weakSelf;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            }
            [self presentViewController:picker animated:YES completion:nil];
        } else if(buttonIndex == 1){
            if (![WWPermissionManager hasPermissionForPhotoGallery]) return;
            [weakSelf chooseFromPhotos];
        }
    }];
    [actionSheet showInView:self.view];
}

- (void)chooseFromPhotos {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.autoDismiss = YES;
    imagePickerVc.barItemTextColor = EL_COLOR_RED;
    imagePickerVc.barItemTextFont = [UIFont systemFontOfSize:18];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    [self presentViewController:imagePickerVc animated:YES completion:NULL];
}

#pragma mark- UIImagePickerControllerDelegate UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * originalImage = info[UIImagePickerControllerOriginalImage];

    self.teacherCourseInfo.courseCover = originalImage;
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count>0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (UIImage * photo in photos) {
               self.teacherCourseInfo.courseCover = photo;
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
               
                [self.tableView reloadData];
            });
        });
    }
}

#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.0001)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
