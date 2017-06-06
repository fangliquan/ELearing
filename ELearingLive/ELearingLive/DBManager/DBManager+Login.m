
#import "DBManager+Login.h"

#import "MJExtension.h"

//#import "XGPush.h"
@implementation DBManager (Login)

- (LoginInfo *)loadOldLoginInfo
{
    return [self loadTableFirstData:[LoginInfo class] Condition:nil];
}

- (UserLoginResponse *)loadLoginInfo {
    return [self loadTableFirstData:[UserLoginResponse class] Condition:nil];
}


- (AccountInfo *)loadAccountInfo
{
    AccountInfo *ret = [[AccountInfo alloc] init];
    
    UserLoginResponse *userLoginResponse = [self loadTableFirstData:[UserLoginResponse class] Condition:nil];
    ret.userLoginResponse = userLoginResponse;
    
    LoginInfo *loginInfo = [self loadTableFirstData:[LoginInfo class] Condition:nil];
   
     ret.loginInfo = loginInfo;
    return ret;
}

/**
 *  登录后 更新数据后存储
 *
 *  @param result UserLoginResponse
 */
- (void)saveSyncDataLoginResultInfoWithUserLoginReslut:(UserLoginResponse *)result{
    LoginInfo *loginInfo = [[LoginInfo alloc]init];
    loginInfo.token = result.token;
    loginInfo.phone = result.phone;
    loginInfo.userId = result.userId;
    loginInfo.isLogined = 1;
    loginInfo.deviceId = result.token;
    [[DBManager sharedInstance] cleanTableData:[LoginInfo class]];
    
    result.isLogined = 1;
    //[XGPush setAccount:result.phone];//  注册信鸽用户
    
    [self saveData:loginInfo];

    
    [[DBManager sharedInstance] cleanTableData:[UserLoginResponse class]];
    [self saveData:result];
    
    
}

-(void)loginOutClearUserData{
    LoginInfo *loginInfo = [[LoginInfo alloc]init];
    loginInfo.token = @"";
    loginInfo.phone = @"";
    loginInfo.userId = 0;
    loginInfo.deviceId = @"";
    loginInfo.isLogined = 0;
    [[DBManager sharedInstance] cleanTableData:[LoginInfo class]];
    
    [self saveData:loginInfo];
    
    
    [[DBManager sharedInstance] cleanTableData:[UserLoginResponse class]];
    
    //[[DBManager sharedInstance] cleanTableData:[UserAddressInfo class]];
    
    [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class]];

}



@end
