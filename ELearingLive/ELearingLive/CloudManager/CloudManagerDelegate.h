
#import <Foundation/Foundation.h>
@class UserLoginResponse;

@protocol CloudManagerDelegate <NSObject>

@optional

-(void)didUpdateUserInfoWithUserInfoResponse:(UserLoginResponse *)userLoginResponse;

//重新刷新购物车列表
-(void)didUpdateShopCarListViewController;
//添加或删除商品数量
-(void)didUpdateAddAndRemoveGoods;

-(void)didGetNewDefaultAddress;
@end
