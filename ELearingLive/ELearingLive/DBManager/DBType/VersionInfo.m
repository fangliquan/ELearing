
#import "VersionInfo.h"

@implementation VersionInfo
@synthesize result;
@synthesize downfile;


+(bool)isInSystemDB {
    return YES;
}


+(NSString *)getTableName
{
    return @"VersionInfo";
}

@end
