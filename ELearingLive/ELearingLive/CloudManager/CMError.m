
#import "CMError.h"

@implementation CMError

@synthesize errorInfo;
@synthesize httpStatus;
@synthesize serviceStatus;

+(CMError *)errorWithHttpStatus:(NSInteger)aHttpStatus
                  serviceStatus:(NSInteger)aServiceStatus
                   andErrorInfo:(NSString *)aErrorInfo {
    CMError *ret = nil;
    ret = [[CMError alloc] init];
    ret.httpStatus = aHttpStatus;
    ret.serviceStatus = aServiceStatus;
    ret.errorInfo = aErrorInfo;
    
    return ret;
}

@end
