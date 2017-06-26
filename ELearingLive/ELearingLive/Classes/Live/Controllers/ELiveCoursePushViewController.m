//
//  ELiveCoursePushViewController.m
//  ELearingLive
//
//  Created by microleo on 2017/6/22.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "ELiveCoursePushViewController.h"
#import "RootNavigationViewController.h"
#import <AlivcLiveVideo/AlivcLiveVideo.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "ELiveCoursePushView.h"
#import "CloudManager+Course.h"
#import "UcCourseIndex.h"
#import "HUDHelper.h"
@interface ELiveCoursePushViewController ()<AlivcLiveSessionDelegate>

@property (nonatomic, strong) AlivcLiveSession *liveSession;

/* 推流模式（横屏or竖屏）*/
@property (nonatomic, assign) BOOL isScreenHorizontal;
/* 推流地址 */
@property (nonatomic, strong) NSString *url;
/* 摄像头方向记录 */
@property (nonatomic, assign) AVCaptureDevicePosition currentPosition;
/* 曝光度记录 */
@property (nonatomic, assign) CGFloat exposureValue;
// UI
@property (weak, nonatomic) IBOutlet UISlider *skinSlider;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;

// 调试
@property (nonatomic, strong) CTCallCenter *callCenter;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *logArray;

@property (nonatomic, assign) BOOL isCTCallStateDisconnected;
@property (nonatomic, assign) CGFloat lastPinchDistance;

@property(nonatomic,strong) ELiveCoursePushView *liveCoursePushView;

@property(nonatomic,strong) CoursePushInfoModel *coursePushInfoModel;
@end

@implementation ELiveCoursePushViewController


+ (void)presentFromViewController:(UIViewController *)viewController courseId:(NSString *)courseId  periodid:(NSString *)periodid completion:(void(^)())completion{
    ELiveCoursePushViewController *pushVc = [[ELiveCoursePushViewController alloc]init];
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //[self addGesture];
    
   // [self createSession];
    
    //[self startDebug];
    
    NSLog(@"版本号:%@", [AlivcLiveSession alivcLiveVideoVersion]);
    [self getLiveData];
    [self createPushView];
}

-(void)getLiveData{
    [[CloudManager sharedInstance]asyncStartPushCourseWithCourseId:_courseId andPeriodid:_periodid completion:^(CoursePushInfoModel *ret, CMError *error) {
        if (error ==nil) {
            self.coursePushInfoModel = ret;
            [self createSession];
        }
    }];

}


#pragma mark - 推流Session 创建 销毁
- (void)createSession{
    
    AlivcLConfiguration *configuration = [[AlivcLConfiguration alloc] init];
    configuration.url = self.coursePushInfoModel.push;
    configuration.videoMaxBitRate = 1500 * 1000;
    configuration.videoBitRate = 600 * 1000;
    configuration.videoMinBitRate = 400 * 1000;
    configuration.audioBitRate = 64 * 1000;
    configuration.videoSize = CGSizeMake(360, 640);// 横屏状态宽高不需要互换
    configuration.fps = 20;
    configuration.preset = AVCaptureSessionPresetiFrame1280x720;
    configuration.screenOrientation = AlivcLiveScreenHorizontal;
    // 重连时长
    configuration.reconnectTimeout = 5;
    // 水印
    configuration.waterMaskImage = [UIImage imageNamed:@"watermask"];
    configuration.waterMaskLocation = 1;
    configuration.waterMaskMarginX = 10;
    configuration.waterMaskMarginY = 10;
    // 摄像头方向
//    if (self.currentPosition) {
//        configuration.position = self.currentPosition;
//    } else {
        configuration.position = AVCaptureDevicePositionFront;
        self.currentPosition = AVCaptureDevicePositionFront;
    //}
    configuration.frontMirror = YES;
    
    // alloc session
    self.liveSession = [[AlivcLiveSession alloc] initWithConfiguration:configuration];
    self.liveSession.delegate = self;
    // 是否静音推流
    self.liveSession.enableMute = NO;
    // 开始预览
    [self.liveSession alivcLiveVideoStartPreview];
    // 开始推流
    [self.liveSession alivcLiveVideoConnectServer];
    
    NSLog(@"开始推流");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 预览view
        [self.view insertSubview:[self.liveSession previewView] atIndex:0];
    });
    
    self.exposureValue = 0;
   
}

- (void)destroySession{
    [self.liveSession alivcLiveVideoDisconnectServer];
    [self.liveSession alivcLiveVideoStopPreview];
    [self.liveSession.previewView removeFromSuperview];
    self.liveSession = nil;
    NSLog(@"销毁推流");
}

-(void)createPushView{
    ELiveCoursePushView *pushView = [[ELiveCoursePushView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) andLivePlayer:NO  andisScreenHorizontal:YES];
    pushView.closeLiveHandler = ^{
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"要关闭当前的直播吗" style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex ==1) {
                [self buttonCloseClick];
            }
        }];

    };
    
    [self.view addSubview:pushView];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}
//
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
#pragma mark - AlivcLiveVideo Delegate
- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session error:(NSError *)error{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString *msg = [NSString stringWithFormat:@"%zd %@",error.code, error.localizedDescription];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Live Error" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新连接", nil];
//        alertView.delegate = self;
//        [alertView show];
//    });
    
    NSLog(@"liveSession Error : %@", error);
}

- (void)alivcLiveVideoLiveSessionNetworkSlow:(AlivcLiveSession *)session {
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络环境较差" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alertView show];
//    self.textView.text = @"网速过慢，影响推流效果，拉流端会造成卡顿等，建议暂停直播";
    NSLog(@"网速过慢");
    
}

- (void)alivcLiveVideoLiveSessionConnectSuccess:(AlivcLiveSession *)session {
    
    NSLog(@"推流  connect success!");
}


- (void)alivcLiveVideoReconnectTimeout:(AlivcLiveSession *)session error:(NSError *)error {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"重连超时-error:%ld", error.code] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        
//        [alertView show];
//    });
    NSLog(@"重连超时");
}


- (void)alivcLiveVideoOpenAudioSuccess:(AlivcLiveSession *)session {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"麦克风打开成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
}

- (void)alivcLiveVideoOpenVideoSuccess:(AlivcLiveSession *)session {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"摄像头打开成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
}


- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session openAudioError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"麦克风获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [alertView show];
    });
}

- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session openVideoError:(NSError *)error {
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"摄像头获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
}

- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session encodeAudioError:(NSError *)error {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"音频编码初始化失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
    
}

- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session encodeVideoError:(NSError *)error {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"视频编码初始化失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
}

- (void)alivcLiveVideoLiveSession:(AlivcLiveSession *)session bitrateStatusChange:(ALIVC_LIVE_BITRATE_STATUS)bitrateStatus {
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:[NSString stringWithFormat:@"ALIVC_LIVE_BITRATE_STATUS = %ld", bitrateStatus] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alertView show];
    //    });
    NSLog(@"码率变化 %ld", bitrateStatus);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self.liveSession alivcLiveVideoConnectServer];
    } else {
        [self.liveSession alivcLiveVideoDisconnectServer];
    }
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



#pragma mark - Notification
- (void)appResignActive{
    
    // 退入后台停止推流 因为iOS后台机制，不能满足充分的摄像头采集和GPU渲染
    [self destroySession];
    
    // 监听电话
    _callCenter = [[CTCallCenter alloc] init];
    _isCTCallStateDisconnected = NO;
    _callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            _isCTCallStateDisconnected = YES;
        }
        else if([call.callState isEqualToString:CTCallStateConnected])
            
        {
            _callCenter = nil;
        }
    };
    
    NSLog(@"退入后台");
    
}

- (void)appBecomeActive{
    
    if (_isCTCallStateDisconnected) {
        sleep(2);
    }
    // 回到前台重新推流
    [self createSession];
    
    NSLog(@"回到前台");
}

#pragma mark - Actions
- (void)buttonCloseClick {
    [self destroySession];
    [self stopLivePush];
    [_timer invalidate];
    _timer = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)cameraButtonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    self.liveSession.devicePosition = button.isSelected ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    self.currentPosition = self.liveSession.devicePosition;
}

- (IBAction)skinButtonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    [self.skinSlider setHidden:!button.selected];
    [self.liveSession setEnableSkin:button.isSelected];
}

- (IBAction)skinSliderAction:(UISlider *)sender {
    
    [self.liveSession alivcLiveVideoChangeSkinValue:sender.value];
    
}


- (IBAction)flashButtonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    self.liveSession.torchMode = button.isSelected ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
}

- (IBAction)muteButton:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    self.liveSession.enableMute = sender.selected;
}

- (IBAction)disconnectButtonClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.liveSession.dumpDebugInfo.connectStatus == AlivcLConnectStatusNone) {
        [self.liveSession alivcLiveVideoConnectServer];
    }else{
        [self.liveSession alivcLiveVideoDisconnectServer];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)stopLivePush{
    [[CloudManager sharedInstance]asyncStopPushCourseWithPeriodid:self.coursePushInfoModel.periodid completion:^(NSString *ret, CMError *error) {
        if (error ==nil) {
            
        }
    }];
}
@end
