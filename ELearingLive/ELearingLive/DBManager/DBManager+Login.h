
#import "DBManagerBase.h"

@class LoginInfo;
@class AccountInfo;
@class UserLoginResponse;


@interface DBManager (Login)

- (LoginInfo *)loadOldLoginInfo;

- (UserLoginResponse *)loadLoginInfo;

- (AccountInfo *)loadAccountInfo;


/**
 *  登录后 更新数据后存储
 *
 *  @param result UserLoginResponse
 */
- (void)saveSyncDataLoginResultInfoWithUserLoginReslut:(UserLoginResponse *)result;
//退出登录清空数据
-(void)loginOutClearUserData;

@end
