
#import <Foundation/Foundation.h>
#import "LKDB+Mapping.h"
#import "NSObject+LKModel.h"



@interface BaseModel : NSObject

@property (nonatomic) long long updateTime;
@property (nonatomic) bool deleted;

@property(copy,nonatomic) NSString *error_code;
@property(copy,nonatomic) NSString *error_desc;
+(bool)isInSystemDB;

+(bool)isOrderDesc;

+(BaseModel*)createModelFromDic:(NSDictionary*)dic;

+(id)loadDataById:(long)pkId;

-(void)save;

@end


@interface NSObject(PrintSQL)

+(NSString*)getCreateTableSQL;

+(NSString*)getInsertDataSQL:(BaseModel*)model;

+(NSDictionary*)getDictionaryForModel:(BaseModel*)model;
@end
