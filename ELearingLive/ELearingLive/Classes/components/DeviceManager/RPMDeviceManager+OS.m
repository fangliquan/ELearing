
#import "RPMDeviceManager+OS.h"
#import "RPMDeviceManager+Private.h"

#define kBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

@implementation RPMDeviceManager (OS)

-(float)OSVersion {
    float ret = 0.;
    ret = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    return ret;
}

-(void)emptyDocumentsDirectory {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if(error) {
        // error
    } else {
        for(NSString *file in files) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            [fileMgr removeItemAtPath:fullPath
                                error:nil];
        }
    }
}

-(NSString *)buildNumber {
    NSString *ret = nil;
    ret = kBundleVersion;
    
    return ret;
}

@end
