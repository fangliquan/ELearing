
#import <Foundation/Foundation.h>
#import "BaseModel.h"

#define KEY_DB_CREATE_TIMESTAMP @"KEY_DB_CREATE_TIMESTAMP"

//是否提示过开启定位服务
#define KEY_LOCATION_ENABLE_TIP @"KEY_LOCATION_ENABLE_TIP"

//是否提示过开启消息通知
#define KEY_NOTIFICATION_ENABLE_TIP @"KEY_NOTIFICATION_ENABLE_TIP"

//鸽推 用户标签
#define KEY_GETUI_USER_TAGS @"KEY_GETUI_USER_TAGS"


@interface Informations : BaseModel

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemValue;
@property (nonatomic, assign) long classId;//家长端绘本借阅条目专用

+(id)getValueByName:(NSString*)name;

@end


