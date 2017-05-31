
#import <netdb.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <sys/sysctl.h>
#import "PublicUtil.h"
#import "RPMDeviceManager.h"

@implementation PublicUtil

+(NSString*) getLocalIpAddr
{
    NSString* wifiAddress = nil;
    NSString* vpnAddress = nil;
    NSString* telecomAddress = nil;
    
    struct ifaddrs* interfaces = NULL;
    struct ifaddrs* temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (0 == success)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
//                if (strcmp(temp_addr->ifa_name, (ReachableViaWiFi == curStatus? "en0" : "pdp_ip0")) == 0)
                if(strcmp(temp_addr->ifa_name, "en0") == 0)
                {
                    // Get NSString from C String
                    wifiAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                
                if(strcmp(temp_addr->ifa_name, "pdp_ip0") == 0)
                {
                    // Get NSString from C String
                    telecomAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                
                if(strcmp(temp_addr->ifa_name, "utun0") == 0)
                {
                    // Get NSString from C String
                    vpnAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    if (vpnAddress)
        return vpnAddress;
    if (wifiAddress)
        return wifiAddress;
    
    return telecomAddress;
}

+(NSString *) getHostName
{
    NSString *hostname = nil;
    char hn[1024] = {0};
    int ret = gethostname(hn, 1024);
    if (ret == 0) {
        hostname = [NSString stringWithUTF8String:hn];
    }
    return hostname;
}

+ (NSString *) getModel {
    // Gets a string with the device model
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    NSString *deviceModel = [[platform componentsSeparatedByString:@","] objectAtIndex:0];
    return deviceModel;    
//    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1";
//    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3";
//    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3S";
//    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (Verizon)";
//    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
//    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
//    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
//    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
//    
//    if ([platform isEqualToString:@"iPod1,1"])      return @"iPodTouch 1";
//    if ([platform isEqualToString:@"iPod2,1"])      return @"iPodTouch 2";
//    if ([platform isEqualToString:@"iPod3,1"])      return @"iPodTouch 3";
//    if ([platform isEqualToString:@"iPod4,1"])      return @"iPodTouch 4";
//    if ([platform isEqualToString:@"iPod5,1"])      return @"iPodTouch 5";
//    
//    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1";
//    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,5"])      return @"iPadMini 1 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,6"])      return @"iPadMini 1 (GSM)";
//    if ([platform isEqualToString:@"iPad2,7"])      return @"iPadMini 1 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
//    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
//    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
//    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
//    if ([platform isEqualToString:@"iPad4,4"])      return @"iPadMini 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad4,5"])      return @"iPadMini 2 (Cellular)";
//    
//    if ([platform isEqualToString:@"i386"])         return @"Simulator";
//    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
}

+ (NSString *) getCurrentTime
{
    NSDate *current = [NSDate date];
    NSDateFormatter *dateForamatter = [[NSDateFormatter alloc] init];
    [dateForamatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.SSS"];
    
    NSString *dateString = [dateForamatter stringFromDate:current];
    return dateString;
}

+ (NSString *) NSStringFromCString:(const char*) str
{
    NSString *ret = @"";
    if (str)
    {
        ret = [NSString stringWithUTF8String:str];
    }
    
    return ret;
}


+ (BOOL) isPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO;
}
#define kDeviceSnSecItemName @"DeviceSN"

+ (BOOL)setDeviceSNToKeyChain:(NSString*)deviceSN
{
    [self deleteDeviceSNFromKeyChain];
    
    NSMutableDictionary *dictForAdd = [[NSMutableDictionary alloc] init];
    
    [dictForAdd setValue:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [dictForAdd setValue:kDeviceSnSecItemName forKey:(__bridge id)kSecAttrGeneric];
    
    const char *deviceSNStr = [deviceSN UTF8String];
    NSData *deviceSNData = [NSData dataWithBytes:deviceSNStr length:strlen(deviceSNStr)];
    [dictForAdd setValue:deviceSNData forKey:(__bridge id)kSecValueData];
    
    OSStatus writeErr = SecItemAdd((__bridge CFDictionaryRef)dictForAdd, NULL);
    if (writeErr != errSecSuccess) {
        NSLog(@"Add KeyChain Item Error!!! Error Code:%d", (int)writeErr);
        return NO;
    }
    else {
        NSLog(@"Add KeyChain Item Success!!!");
        return YES;
    }
}

+ (NSString*)getDeviceSNFromKeyChain
{
    NSMutableDictionary *dictForQuery = [[NSMutableDictionary alloc] init];
    [dictForQuery setValue:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [dictForQuery setObject:kDeviceSnSecItemName forKey:(__bridge id)kSecAttrGeneric];
    
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(__bridge id)kSecMatchCaseInsensitive];
    [dictForQuery setValue:CFBridgingRelease(kSecMatchLimitOne) forKey:(__bridge id)kSecMatchLimit];
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    OSStatus queryErr   = noErr;
    NSData   *udidValue = nil;
    NSString *udid      = nil;
    CFTypeRef result = nil;
    queryErr = SecItemCopyMatching((__bridge CFDictionaryRef)dictForQuery, &result);
    if (queryErr == errSecItemNotFound) {
        NSLog(@"get KeyChain Item: %@ not found!!!", kDeviceSnSecItemName);
    }
    else if (queryErr != errSecSuccess) {
        NSLog(@"get KeyChain Item Error!!! Error code:%d", (int)queryErr);
    }
    if (queryErr == errSecSuccess) {
        udidValue = (__bridge NSData*)result;
        if (udidValue) {
            udid = [NSString stringWithUTF8String:udidValue.bytes];
        }
    }
    
    if (!udid) {
        udid = [[RPMDeviceManager sharedInstance] createSerialNumberForUser:@"" deviceType:@""];
        [self setDeviceSNToKeyChain:udid];
    }
    
    return udid;
}

+(void) deleteDeviceSNFromKeyChain
{
    NSMutableDictionary *dictForQuery = [[NSMutableDictionary alloc] init];
    [dictForQuery setValue:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [dictForQuery setObject:kDeviceSnSecItemName forKey:(__bridge id)kSecAttrGeneric];
    
    OSStatus queryErr = SecItemDelete((__bridge CFDictionaryRef)(dictForQuery));
    if (queryErr != errSecSuccess)
    {
        NSLog(@"delete KeyChain Item Error!!! Error code:%d", (int)queryErr);
    }
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+ (NSString *)base64StringFromData:(NSData *)data
{
    if (data && data.length!=0) {
        char *characters = malloc((([data length] + 2) / 3) * 4);
        if (characters == NULL)
            return @"";
        NSUInteger length = 0;
        
        NSUInteger i = 0;
        while (i < [data length])
        {
            char buffer[3] = {0,0,0};
            short bufferLength = 0;
            while (bufferLength < 3 && i < [data length])
                buffer[bufferLength++] = ((char *)[data bytes])[i++];
            
            //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
            characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
            characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
            if (bufferLength > 1)
                characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
            else characters[length++] = '=';
            if (bufferLength > 2)
                characters[length++] = encodingTable[buffer[2] & 0x3F];
            else characters[length++] = '=';
        }
        
        return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    }
    else {
        return @"";
    }
}

+ (NSData *)dataFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:@""]) {
        if (base64 == nil || [base64 length] == 0)
            return nil;
        
        static char *decodingTable = NULL;
        if (decodingTable == NULL)
        {
            decodingTable = malloc(256);
            if (decodingTable == NULL)
                return nil;
            memset(decodingTable, CHAR_MAX, 256);
            NSUInteger i;
            for (i = 0; i < 64; i++)
                decodingTable[(short)encodingTable[i]] = i;
        }
        
        const char *characters = [base64 cStringUsingEncoding:NSASCIIStringEncoding];
        if (characters == NULL)     //  Not an ASCII string!
            return nil;
        char *bytes = malloc((([base64 length] + 3) / 4) * 3);
        if (bytes == NULL)
            return nil;
        NSUInteger length = 0;
        
        NSUInteger i = 0;
        while (YES)
        {
            char buffer[4];
            short bufferLength;
            for (bufferLength = 0; bufferLength < 4; i++)
            {
                if (characters[i] == '\0')
                    break;
                if (isspace(characters[i]) || characters[i] == '=')
                    continue;
                buffer[bufferLength] = decodingTable[(short)characters[i]];
                if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
                {
                    free(bytes);
                    return nil;
                }
            }
            
            if (bufferLength == 0)
                break;
            if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
            {
                free(bytes);
                return nil;
            }
            
            //  Decode the characters in the buffer to bytes.
            bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
            if (bufferLength > 2)
                bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
            if (bufferLength > 3)  
                bytes[length++] = (buffer[2] << 6) | buffer[3];  
        }  
        
        bytes = realloc(bytes, length);  
        NSData *data = [NSData dataWithBytesNoCopy:bytes length:length];
        
        return data;
//        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return nil;
    }
}

+(NSString *)getDeviceMoreInfo{
    UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;       //获取设备所有者的名称
    //NSString *model = device.model;      //获取设备的类别
    NSString *type = [[RPMDeviceManager sharedInstance] deviceModel]; //获取本地化版本
    NSString *systemName = device.systemName;   //获取当前运行的系统
    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
    return [NSString stringWithFormat:@"%@|%@ %@|%@",type,systemName,systemVersion,name];//@"iPhone Simulator|iPhone OS9.2|iPhone Simulator|iPhone"
    
}

#pragma mark- UUID string
+ (NSString *)getUUIDString
{
    NSString * uuidKey = @"VisitorUUIDString";
    NSString * uuidString = @"";
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    uuidString = [userDef objectForKey:uuidKey];
    if (uuidString.length == 0) {
        uuidString = [[NSUUID UUID] UUIDString];
        uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
        [userDef setObject:uuidString forKey:uuidKey];
    }
    return uuidString;
}

@end
