
#import "CloudManagerBase.h"
#import "GCDMulticastDelegate.h"


#import "CMError.h"


@interface CloudManager() {
    
}
@end

@implementation CloudManager


static CloudManager *_sharedInstance = nil;



#pragma mark - singleton method
+(CloudManager *)sharedInstance {
    if (_sharedInstance == nil) {
        @synchronized(self) {
            _sharedInstance = [[CloudManager alloc] init];
        }
    }
    
    return _sharedInstance;
}

-(void)dealloc {
}

-(id)init {
    if(self=[super init]) {
        // init semaphore
        _isLogined = NO;
    
        _delegates = (GCDMulticastDelegate<CloudManagerDelegate> *)[[GCDMulticastDelegate alloc] init];
    }
    
    return self;
}

-(void)addDelegate:(id<CloudManagerDelegate>)delegate {
    @synchronized(_delegates) {
        [_delegates addDelegate:delegate
                  delegateQueue:dispatch_get_main_queue()];
    }
}

-(void)removeDelegate:(id<CloudManagerDelegate>)delegate {
    @synchronized(_delegates) {
        [_delegates removeDelegate:delegate];
    }
}

-(id<CloudManagerDelegate>)getDelegate {
    return _delegates;
}



- (AccountInfo *)currentAccount {
    if (!_currentAccount) {
        //AccountInfo *tempInfo = [[DBManager sharedInstance]loadAccountInfo];
        //_currentAccount = tempInfo;
    }
    return _currentAccount;
}

-(NSString *)getLoginToken{
    if (!_currentAccount) {
        //AccountInfo *tempInfo = [[DBManager sharedInstance]loadAccountInfo];
        //_currentAccount = tempInfo;
    }
    return @"";// _currentAccount.userLoginResponse.token ?  _currentAccount.userLoginResponse.token:@"";
}

@end
