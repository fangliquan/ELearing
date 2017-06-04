
#import "VersionInfo.h"

@implementation VersionInfo
@synthesize lastversion;
@synthesize lastfile;
@synthesize token;


+(bool)isInSystemDB {
    return YES;
}


+(NSString *)getTableName
{
    return @"VersionInfo";
}

@end
