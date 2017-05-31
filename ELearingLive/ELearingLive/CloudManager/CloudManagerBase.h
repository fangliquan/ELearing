
#import <Foundation/Foundation.h>
#import "CloudManagerDefs.h"
#import "CloudManagerDelegate.h"
#import "GCDMulticastDelegate.h"
#import <CoreLocation/CoreLocation.h>
//#import "UserLoginResponse.h"
#import "AccountInfo.h"
#define kOneSecond 1000000000ul
#define LOOP_INTERVAL 10*kOneSecond
#define SCAN_INTERVAL 3*kOneSecond


@interface CloudManager : NSObject {
   
    AccountInfo *_currentAccount;
    
    GCDMulticastDelegate<CloudManagerDelegate> *_delegates;
    
    NSThread *_connectionMaitainThread;

    BOOL _isLogined;
}

#pragma mark - singleton method
+(CloudManager *)sharedInstance;

+(void)handleCMError:(CMError*)error;

-(void)addDelegate:(id<CloudManagerDelegate>)delegate;
-(void)removeDelegate:(id<CloudManagerDelegate>)delegate;
-(id<CloudManagerDelegate>)getDelegate;
-(NSString *)getLoginToken;


@property (nonatomic, strong,readonly) AccountInfo *currentAccount;

@end
