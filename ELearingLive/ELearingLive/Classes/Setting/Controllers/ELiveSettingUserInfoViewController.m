//
//  ELiveSettingUserInfoViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/5/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveSettingUserInfoViewController.h"
#import "ELiveSettingUserInfoViewCell.h"
#import "ELiveSettingBindPhoneViewController.h"
#import "UserTruthInfo.h"
#import "CloudManager+Teacher.h"
#import "TZImagePickerController.h"
@interface ELiveSettingUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) NSMutableArray *sectionhArrays;

@property(nonatomic,strong) NSMutableArray *section1Arrays;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UserTruthInfo *userTruthInfo;

@property(nonatomic,strong) UIImage *userHeader;

@end

@implementation ELiveSettingUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sectionhArrays = [NSMutableArray array];
    
    ELiveSettingUserInfoModel *settingModelH = [[ELiveSettingUserInfoModel alloc]init];
    settingModelH.type =ELive_Set_User_Header;
    settingModelH.title = @"头像";
    [self.sectionhArrays addObject:settingModelH];
    
    
    self.section1Arrays = [NSMutableArray array];
    
    self.userTruthInfo = [[UserTruthInfo alloc]init];
    _userTruthInfo.mobile = [CloudManager sharedInstance].currentAccount.userLoginResponse.phone;
    _userTruthInfo.real_name = [CloudManager sharedInstance].currentAccount.userLoginResponse.nickname;
    ELiveSettingUserInfoModel *settingModel1 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel1.type =ELive_Set_User_Name;
    settingModel1.title = @"姓名:";
    [self.section1Arrays addObject:settingModel1];
    
    
    ELiveSettingUserInfoModel *settingModel2 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel2.type =ELive_Set_User_Age;
    settingModel2.title = @"年龄:";
    [self.section1Arrays addObject:settingModel2];
    
    
    ELiveSettingUserInfoModel *settingModel3 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel3.type =ELive_Set_User_Profession;
    settingModel3.title = @"职业:";
    [self.section1Arrays addObject:settingModel3];
    
    
    ELiveSettingUserInfoModel *settingModel4 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel4.type =ELive_Set_User_Commpany;
    settingModel4.title = @"公司:";
    [self.section1Arrays addObject:settingModel4];
    
    
    ELiveSettingUserInfoModel *settingModel5 = [[ELiveSettingUserInfoModel alloc]init];
    settingModel5.type =ELive_Set_User_Phone;
    settingModel5.title = @"手机:";
    [self.section1Arrays addObject:settingModel5];
    
    
    [self configtableView];
    [self createFooterView];
    
    [self loadUserInfo];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTextView)]];
}

-(void)hiddenTextView{
    [self.view endEditing:YES];
}

-(void)createFooterView{
    
    //    UIView *footerView = [UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 64, Main_Screen_Width, 64)
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, Main_Screen_Height - 54, Main_Screen_Width - 60, 40)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = EL_COLOR_RED;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(saveUserInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

-(void)saveUserInfoClick{
    if (self.userTruthInfo.real_name.length <=0) {
        [MBProgressHUD showError:@"输入姓名" toView:nil];
        return;
    }
    if (self.userTruthInfo.mobile.length <=0) {
        [MBProgressHUD showError:@"输入手机号" toView:nil];
        return;
    }
    
    [[CloudManager sharedInstance]asyncUpdateUserTruthInfo:self.userTruthInfo completion:^(NSString *ret, CMError *error) {
        if (error ==nil) {
            [MBProgressHUD showSuccess:@"修改成功" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:ret toView:nil];
        }
    }];
}


-(void)loadUserInfo{
    [[CloudManager sharedInstance]asyncUpdateUserTruthInfo:^(UserTruthInfo *ret, CMError *error) {
        if (error ==nil) {
            self.userTruthInfo = ret;
            [self.tableView reloadData];
        }else{
            //[MBProgressHUD showError:ret toView:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) {
        return self.sectionhArrays.count;
    }else{
        return self.section1Arrays.count;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return 80;
    }else{
        return 60;
    }
    // ELeaingNewsItemCellFrame *itemFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELiveSettingUserInfoViewCell *cell = [ELiveSettingUserInfoViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.isUserInfo = YES;
    if (indexPath.section ==0) {
        cell.settingUserInfoModel = self.sectionhArrays.count >indexPath.row ?self.sectionhArrays[indexPath.row]:nil;
        cell.userTruthInfo = self.userTruthInfo;
    }else{
        cell.settingUserInfoModel = self.section1Arrays.count >indexPath.row ?self.section1Arrays[indexPath.row]:nil;
        cell.userTruthInfo = self.userTruthInfo;
    }
  
    //cell.eLeaingNewsItemCellFrame = self.newsArrays.count >indexPath.row ?self.newsArrays[indexPath.row]:nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        [self addCourseCover];
    }


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
    
    self.userHeader = originalImage;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateUserAvator];
    });

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
                self.userHeader = photo;
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self updateUserAvator];
            });
        });
    }
}


-(void)updateUserAvator{
    [[CloudManager sharedInstance]asyncUpdateUserHeaderImageWithimage:self.userHeader completion:^(NSString *ret, CMError *error) {
        if (error ==nil) {
            [MBProgressHUD showSuccess:@"头像更新成功" toView:nil];
        }else{
            [MBProgressHUD showSuccess:@"头像更新失败" toView:nil];
        }
    }];
}

#pragma mark- TableView Line Width
- (void )configtableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height -64) style:UITableViewStyleGrouped];
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
