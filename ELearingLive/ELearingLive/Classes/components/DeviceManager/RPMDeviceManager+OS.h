
#import "RPMDeviceManagerBase.h"

@interface RPMDeviceManager (OS)

-(float)OSVersion;

-(void)emptyDocumentsDirectory;

-(NSString *)buildNumber;

@end
