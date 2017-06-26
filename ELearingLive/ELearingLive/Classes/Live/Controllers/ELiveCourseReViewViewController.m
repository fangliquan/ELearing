//
//  ELiveCourseReViewViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/22.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCourseReViewViewController.h"
#import "RootNavigationViewController.h"


#import <AliyunPlayerSDK/AliyunPlayerSDK.h>

#import <MediaPlayer/MediaPlayer.h>

#import <AVFoundation/AVAudioSession.h>

#import "CloudManager+Course.h"
#import "UcCourseIndex.h"
#import "HUDHelper.h"
#import "ELiveCoursePushView.h"
@interface ELiveCourseReViewViewController (){
    
    AliVcMediaPlayer* mPlayer;
}



@property (nonatomic, strong) UIView *mPlayerView;
@property(nonatomic,strong)  ELiveCoursePushView *pushView;
@property(nonatomic,strong) CourseDetailInfoModel *courseInfo;

@end

@implementation ELiveCourseReViewViewController


+ (void)presentFromViewController:(UIViewController *)viewController courseId:(NSString *)courseId  periodid:(NSString *)periodid completion:(void(^)())completion{
    ELiveCourseReViewViewController *pushVc = [[ELiveCourseReViewViewController alloc]init];
    pushVc.courseId = courseId;
    pushVc.periodid = periodid;
    pushVc.viewController = viewController;
    RootNavigationViewController *naVC = [[RootNavigationViewController alloc] initWithRootViewController:pushVc];
    naVC.hidesBottomBarWhenPushed = YES;
    naVC.navigationBarHidden = YES;
    [viewController presentViewController: naVC animated:YES completion:completion];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];

    [self getPlayInfo];
    [self createPushView];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
- (void)orientChange:(NSNotification *)noti
    {
        
        NSDictionary* ntfDict = [noti userInfo];
        
        UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
        
        switch (orient)
        {
            case UIDeviceOrientationPortrait:
                [self updateFrame];
                break;
            case UIDeviceOrientationLandscapeLeft:
                  [self updateFrame];
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                break;
            case UIDeviceOrientationLandscapeRight:
                break;
            default:
                break;
        }
}


-(void)updateFrame{
     _mPlayerView.frame = CGRectMake(0, 0,Main_Screen_Width,Main_Screen_Height);
     self.pushView.frame = CGRectMake(0, 0,Main_Screen_Width,Main_Screen_Height);
}
-(void)getPlayInfo{
    MBProgressHUD *hud = [MBProgressHUD showMessage:@""];
    [[CloudManager sharedInstance]asyncPushCourseInfoWithCourseId:_courseId andPeriodid:_periodid completion:^(CourseDetailInfoModel *ret, CMError *error) {
        [hud hide:YES];
        if (error ==nil) {
            self.courseInfo = ret;
            if (ret.play &&ret.play.length >0) {
                if ([ret.is_live isEqualToString:@"y"]) {
                    [self PlayMoive];
                }else{
                    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"直播已结束" style:UIAlertViewStyleDefault cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                }
            }else{
                [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"视频地址获取失败" style:UIAlertViewStyleDefault cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                       [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        
        }else{
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"视频地址获取失败" style:UIAlertViewStyleDefault cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
}

- (void) PlayMoive
{

    _mPlayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Main_Screen_Width,Main_Screen_Height)];
    _mPlayerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mPlayerView];
    
    //new the player
    mPlayer = [[AliVcMediaPlayer alloc] init];
    mPlayer.mediaType = MediaType_AUTO;
    mPlayer.timeout = 25000;
    mPlayer.dropBufferDuration = 8000;
    //create player, and  set the show view
    [mPlayer create:_mPlayerView];
    
    //register notifications
   
    

    //注册准备完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoPrepared:) name:AliVcMediaPlayerLoadDidPreparedNotification object:mPlayer];
    //注册错误通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoError:) name:AliVcMediaPlayerPlaybackErrorNotification object:mPlayer];
    //prepare and play the video
    AliVcMovieErrorCode err = [mPlayer prepareToPlay:[NSURL URLWithString:self.courseInfo.play]];
    if(err != ALIVC_SUCCESS) {
        NSLog(@"preprare failed,error code is %d",(int)err);
        return;
    }
    
    err = [mPlayer play];
    if(err != ALIVC_SUCCESS) {
        NSLog(@"play failed,error code is %d",(int)err);
        return;
    }
    
    //[self addPlayerObserver];
    //[self performSelector:@selector(hideControls:) withObject:nil afterDelay:fadeDelay];
    
    [self showLoadingIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    //[[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeLeft animated: NO ];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    //[[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationPortrait animated: NO ];
}



-(void)createPushView{
    ELiveCoursePushView *pushView = [[ELiveCoursePushView alloc]initWithFrame:CGRectMake(0, 0,Main_Screen_Width, Main_Screen_Height) andLivePlayer:NO  andisScreenHorizontal:YES];
    pushView.closeLiveHandler = ^{
        [self closePlay];
    };
    self.pushView = pushView;
    [self.view addSubview:pushView];
}

- (void)closePlay{

    
    if(mPlayer != nil)
        [mPlayer destroy];
    
    [self removePlayerObserver];
    
    mPlayer = nil;

    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)showLoadingIndicators {
    [[HUDHelper sharedInstance]syncLoading:@""];
}

- (void)hideLoadingIndicators {
    [[HUDHelper sharedInstance]syncStopLoading];
}


//recieve prepared notification
- (void)OnVideoPrepared:(NSNotification *)notification {
    

    
    [self hideLoadingIndicators];
 
}

//recieve error notification
- (void)OnVideoError:(NSNotification *)notification {

    
    
    NSString* error_msg = @"未知错误";
    AliVcMovieErrorCode error_code = mPlayer.errorCode;
    
//    switch (error_code) {
//        case ALIVC_ERR_FUNCTION_DENIED:
//            error_msg = @"未授权";
//            break;
//        case ALIVC_ERR_ILLEGALSTATUS:
//            error_msg = @"非法的播放流程";
//            break;
//        case ALIVC_ERR_INVALID_INPUTFILE:
//            error_msg = @"无法打开";
//            [self hideLoadingIndicators];
//            break;
//        case ALIVC_ERR_NO_INPUTFILE:
//            error_msg = @"无输入文件";
//            [self hideLoadingIndicators];
//            break;
//        case ALIVC_ERR_NO_NETWORK:
//            error_msg = @"网络连接失败";
//            break;
//        case ALIVC_ERR_NO_SUPPORT_CODEC:
//            error_msg = @"不支持的视频编码格式";
//            [self hideLoadingIndicators];
//            break;
//        case ALIVC_ERR_NO_VIEW:
//            error_msg = @"无显示窗口";
//            [self hideLoadingIndicators];
//            break;
//        case ALIVC_ERR_NO_MEMORY:
//            error_msg = @"内存不足";
//            break;
//        case ALIVC_ERR_DOWNLOAD_TIMEOUT:
//            error_msg = @"网络超时";
//            break;
//        case ALIVC_ERR_UNKOWN:
//            error_msg = @"未知错误";
//            break;
//        default:
//            break;
//    }
    
    //NSLog(error_msg);
    
    if(error_code == ALIVC_ERR_DOWNLOAD_TIMEOUT) {
        
        //[mPlayer pause];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误提示"
//                                                        message:error_msg
//                                                       delegate:self
//                                              cancelButtonTitle:@"等待"
//                                              otherButtonTitles:@"重新连接",nil];
//        
//        [alert show];
    }
    //the error message is important when error_cdoe > 500
    else if(error_code > 500 || error_code == ALIVC_ERR_FUNCTION_DENIED) {
        
        [mPlayer reset];
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"视频地址获取失败" style:UIAlertViewStyleDefault cancelButtonTitle:nil otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];

        return;
    }
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //[self showLoadingIndicators];
    
    if (buttonIndex == 0) {
        [mPlayer play];
    }
    //reconnect
    else if(buttonIndex == 1) {
        [mPlayer stop];
        [self showLoadingIndicators];
    }
}

//recieve finish notification
- (void)OnVideoFinish:(NSNotification *)notification {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"播放完成" message:@"播放完成" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    
    [mPlayer stop];
    [self PlayMoive];
    
    //    [seekBackwardButton setSelected:NO];
    //    [seekForwardButton setSelected:NO];
}

//recieve seek finish notification
- (void)OnSeekDone:(NSNotification *)notification {
    //bSeeking = NO;
}

//recieve start cache notification
- (void)OnStartCache:(NSNotification *)notification {
    [self showLoadingIndicators];
}

//recieve end cache notification
- (void)OnEndCache:(NSNotification *)notification {
    [self hideLoadingIndicators];
}



- (void)becomeActive{
    [self EnterForeGroundPlayVideo];
}

- (void)resignActive{
    [self EnterBackGroundPauseVideo];
}


-(void) EnterBackGroundPauseVideo
{
    if(mPlayer) {
        [mPlayer pause];
    }
    
}

-(void) EnterForeGroundPlayVideo
{
    if(mPlayer ) {
        [mPlayer play];

    }
}


-(void)addPlayerObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoPrepared:)
                                                 name:AliVcMediaPlayerLoadDidPreparedNotification object:mPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoError:)
                                                 name:AliVcMediaPlayerPlaybackErrorNotification object:mPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoFinish:)
                                                 name:AliVcMediaPlayerPlaybackDidFinishNotification object:mPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnSeekDone:)
                                                 name:AliVcMediaPlayerSeekingDidFinishNotification object:mPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnStartCache:)
                                                 name:AliVcMediaPlayerStartCachingNotification object:mPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnEndCache:)
                                                 name:AliVcMediaPlayerEndCachingNotification object:mPlayer];
}

-(void)removePlayerObserver
{
    if (mPlayer) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerLoadDidPreparedNotification object:mPlayer];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerPlaybackErrorNotification object:mPlayer];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerPlaybackDidFinishNotification object:mPlayer];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerSeekingDidFinishNotification object:mPlayer];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerStartCachingNotification object:mPlayer];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AliVcMediaPlayerEndCachingNotification object:mPlayer];
    }

}
   

@end
