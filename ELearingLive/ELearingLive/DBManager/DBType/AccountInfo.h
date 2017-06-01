
#import <Foundation/Foundation.h>
#import "LKDB+Mapping.h"
#import "NSObject+LKModel.h"
#import "BaseModel.h"


#pragma mark- GoodsShoppingOrder
@interface GoodsShoppingOrder : BaseModel

@property(nonatomic,assign) long long goodsId;
@property(nonatomic,assign) long long shopId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger type;
@property (nonatomic) double price;
@property (nonatomic) double discountPrice;
@property (nonatomic, strong) NSString *purchaseNote;
@property (nonatomic, assign) int buyCount;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desp;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, assign) int isSelect;

// 获取购物车数据
+ (NSArray *)getShoppingCarOrder;
// 添加到购物车
+ (void)addShoppingCar:(NSObject *)addOrder;
// 减少订单数目
+ (void)reduceShoppingOrder:(long long)orderId;
// 删除订单
+ (void)deleteShoppingOrder:(long long)orderId;
// 退出登录清空购物车
+ (void)cleanShoppingCar;
//更新购物车
+(void)updateShoppingOrder:(BOOL)isSelect andGoodsId:(long long)goodsId;
// 获取添加减少购物车数量
+ (void)addShoppingCount;
+ (void)reduceShoppingCount:(NSInteger)reduceCount;
+ (NSInteger)getShoppingCount;

// 获取总价格 (原价和现价)
+ (NSArray *)getPrice;
//获取要购买商品
+ (NSArray *)getShoppingGoodsWithGoodsId:(long long)goodsId;
//获取所有要购买的商品
+ (NSArray *)geBuyGoodsData;

+ (NSArray *)getUnSelectedGoods;
@end

#pragma mark - Login Info
@interface LoginInfo : BaseModel
@property (nonatomic, assign) long userId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, copy)   NSString * token;

@property(nonatomic,assign) NSInteger isLogined;

@end



@interface AccountInfo : NSObject

@property(nonatomic,strong) UserLoginResponse *userLoginResponse;

@property(nonatomic,strong) LoginInfo *loginInfo;

@property(nonatomic,strong) NSArray * userOrders;


@end

@interface UserLoginResponse : BaseModel

@property(nonatomic,assign) long long  userId;

@property(copy,nonatomic) NSString *nickname;

@property(copy,nonatomic) NSString *avatar;

@property(nonatomic,assign) int  is_teacher;

@end







