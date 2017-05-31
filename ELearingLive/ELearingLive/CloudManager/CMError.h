
#import <Foundation/Foundation.h>

@interface CMError : NSObject

@property (nonatomic, copy) NSString *errorInfo;
@property (nonatomic) NSInteger httpStatus;
@property (nonatomic) NSInteger serviceStatus;

+(CMError *)errorWithHttpStatus:(NSInteger)httpStatus
                  serviceStatus:(NSInteger)serviceStatus
                   andErrorInfo:(NSString *)errorInfo;

@end
