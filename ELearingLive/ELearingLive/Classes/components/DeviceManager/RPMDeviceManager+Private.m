
#import "RPMDeviceManager+Private.h"

#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

// Cryptography
#include <CommonCrypto/CommonDigest.h>

@implementation RPMDeviceManager (Private)

-(NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
    
}

-(NSString*)getMacAddress {
    /* get Mac address first */
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    const struct sockaddr_dl *dlAddr;
    const unsigned char* base;
    int success = 0;
    NSMutableString *strRet = [[NSMutableString alloc] init];
    
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if (strcmp("en0",temp_addr->ifa_name)==0)
            {
                dlAddr = (const struct sockaddr_dl*)temp_addr->ifa_addr;
                if (dlAddr->sdl_type == 0x6/* IFT_ETHER*/)
                {
                    base = (const unsigned char*)&dlAddr->sdl_data[dlAddr->sdl_nlen];
                    for (int i =0; i<dlAddr->sdl_alen; i++)
                    {
                        if(i != 0)
                            [strRet appendString:@":"];
                        
                        [strRet appendFormat:@"%02X",base[i]];
                    }
                    break;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
        
        freeifaddrs(interfaces);
    }
    
    return strRet;
}

@end
