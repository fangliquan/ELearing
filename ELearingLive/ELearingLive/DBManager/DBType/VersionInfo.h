
#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface VersionInfo : BaseModel

@property (nonatomic, copy) NSString *lastversion;
@property (nonatomic, copy) NSString *lastfile;
@property (copy, nonatomic) NSString *token;

@end
