
#import "RPMDeviceManagerBase.h"

@interface RPMDeviceManager (Device)

-(NSString*)createSerialNumber;

-(NSString*)createSerialNumberForUser:(NSString*)userName
                           deviceType:(NSString*)deviceType;

-(NSString *)currentNetworkIp;

-(NSString *)cpuDescription;

-(NSUInteger)cpuCores;

-(NSUInteger)cpuFreq;

-(NSString *)deviceModel;

@end
