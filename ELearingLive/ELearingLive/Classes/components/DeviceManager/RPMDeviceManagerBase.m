
#import "RPMDeviceManagerBase.h"

@implementation RPMDeviceManager

static RPMDeviceManager *_sharedInstance = nil;

#pragma mark - singleton method
+(RPMDeviceManager *)sharedInstance {
    if (_sharedInstance == nil) {
        @synchronized(self) {
            _sharedInstance = [[RPMDeviceManager alloc] init];
        }
    }
    
    return _sharedInstance;
}

@end
