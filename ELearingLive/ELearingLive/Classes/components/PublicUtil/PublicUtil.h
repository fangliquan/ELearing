
#import <Foundation/Foundation.h>

@interface PublicUtil : NSObject

+ (NSString *) getLocalIpAddr;
+ (NSString *) getHostName;
+ (NSString *) getModel;
+ (NSString *) getCurrentTime;


+ (NSString *) NSStringFromCString:(const char*) str;

+ (BOOL) isPhone;
+ (BOOL)setDeviceSNToKeyChain:(NSString*)udid;
+ (NSString*)getDeviceSNFromKeyChain;

+ (NSString *)base64StringFromData:(NSData *)data;
+ (NSData *)dataFromBase64String:(NSString *)base64;
/**
 *  记录设备型号，系统版本，等信息
 *
 *  @return return value description
 */
+(NSString *)getDeviceMoreInfo;

#pragma mark- UUID string
+ (NSString *)getUUIDString;

@end
