
#import "RPMDeviceManager+Device.h"
#import "RPMDeviceManager+Private.h"
#import "UIDevice-Hardware.h"
#import "PublicUtil.h"

@implementation RPMDeviceManager (Device)

-(NSString*)createSerialNumber {
    NSString *ret = nil;
    ret = [self createSerialNumberForUser:@""
                               deviceType:@""];
    
    return ret;
}

-(NSString*)createSerialNumberForUser:(NSString*)userName
                           deviceType:(NSString*)deviceType {
    NSString *uuid = nil;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        uuid = [self getMacAddress];
    }
    
    NSLog(@"Device uuid = %@", uuid);
    
    NSString *origin = [NSString stringWithFormat:@"%@%@%@",userName, uuid, deviceType];
    NSString *strMD5 = [self md5:origin];
    
    const char* base = [[strMD5 uppercaseString] UTF8String];
    NSString *strRet = [[NSString alloc]initWithFormat:@"%c%c%c%c%c%c%c%c-%c%c%c%c-%c%c%c%c-%c%c%c%c-%c%c%c%c%c%c%c%c%c%c%c%c",base[0],base[1],base[2],base[3],base[4],base[5],base[6],base[7],base[8],base[9],base[10],base[11],base[12],base[13],base[14],base[15],base[16],base[17],base[18],base[19],base[20],base[21],base[22],base[23],base[24],base[25],base[26],base[27],base[28],base[29],base[30],base[31]];
    
    return strRet;
}

-(NSString *)currentNetworkIp {
    NSString *ret = nil;
    ret = [PublicUtil getLocalIpAddr];
    
    return ret;
}

-(NSString *)cpuDescription {
    NSString *ret = nil;
    ret = @"";
    
    return ret;
}

-(NSUInteger)cpuCores {
    NSUInteger ret = 0;
    ret = [[UIDevice currentDevice] cpuCount];
    
    return ret;
}

-(NSUInteger)cpuFreq {
    NSUInteger ret = 0;
    ret = [[UIDevice currentDevice] cpuFrequency];
    
    return ret;
}

-(NSString *)deviceModel {
    NSString *ret = nil;
    ret = [[UIDevice currentDevice] platform];
    
    return ret;
}

@end
