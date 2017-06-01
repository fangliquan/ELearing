
#import "AccountInfo.h"
#import "MJExtension.h"
//#import "Goods.h"

#define kShoppingCarCount    @"kShoppingCarCount"   // 购物车数字提示

#pragma mark- GoodsShoppingOrder
@implementation GoodsShoppingOrder

+ (NSString *)getPrimaryKey {
    return @"goodsId";
}

+ (NSString *)getTableName {
    return @"GoodsShoppingOrder";
}

// 获取购物车数据
+ (NSArray *)getShoppingCarOrder {
    return [[DBManager sharedInstance] loadTableData:[GoodsShoppingOrder class] Condition:nil];
}

// 添加到购物车
+ (void)addShoppingCar:(NSObject *)addOrder {
    long long orderId = 0;
//    if ([addOrder isKindOfClass:[Goods class]]) {
//        Goods * picBook = (Goods *)addOrder;
//        orderId = (long long)picBook.goodsId;
//    } else
    if ([addOrder isKindOfClass:[GoodsShoppingOrder class]]) {
        GoodsShoppingOrder * addBookOrder = (GoodsShoppingOrder *)addOrder;
        orderId = addBookOrder.goodsId;
    }
    GoodsShoppingOrder * bookOrder = [GoodsShoppingOrder getPictureBookOrder:orderId];
    if (bookOrder) {    // 存在, 购买数量加1
        bookOrder.buyCount += 1;
        [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class] PrimaryKey:(long)orderId];
        [bookOrder save];
    } else {    // 不存在直接存储
//        if ([addOrder isKindOfClass:[Goods class]]) {
//            Goods * picBook = (Goods *)addOrder;
//            GoodsShoppingOrder * addBookOrder = [[GoodsShoppingOrder alloc] init];
//            addBookOrder.goodsId = picBook.goodsId;
//            addBookOrder.discountPrice = picBook.discountPrice;
//            addBookOrder.price = picBook.price;
//            addBookOrder.buyCount = 1;
//            addBookOrder.title = picBook.title;
//            addBookOrder.desp = picBook.purchaseNote;
//            addBookOrder.cover = picBook.thumb;
//            addBookOrder.name = picBook.name;
//            addBookOrder.isSelect = YES;
//            addBookOrder.type = picBook.type;
//            addBookOrder.shopId = picBook.shopId;
//            [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class] PrimaryKey:(long)orderId];
//            [addBookOrder save];
//        }
    }
    [GoodsShoppingOrder addShoppingCount];
}

// 减少订单数目
+ (void)reduceShoppingOrder:(long long)orderId {
    GoodsShoppingOrder * order = [GoodsShoppingOrder getPictureBookOrder:orderId];
    if (order.buyCount > 1) {
        order.buyCount -= 1;
        [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class] PrimaryKey:(long)orderId];
        [order save];
        [GoodsShoppingOrder reduceShoppingCount:1];
    }
}

// 删除订单
+ (void)deleteShoppingOrder:(long long)orderId {
     GoodsShoppingOrder * order = [GoodsShoppingOrder getPictureBookOrder:orderId];
    [GoodsShoppingOrder reduceShoppingCount:order.buyCount];
    [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class] PrimaryKey:(long)orderId];
}

// 退出登录清空购物车
+ (void)cleanShoppingCar {
    [[DBManager sharedInstance] cleanTableData:[GoodsShoppingOrder class]];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kShoppingCarCount];
}

//更新购物车
+(void)updateShoppingOrder:(BOOL)isSelect andGoodsId:(long long)goodsId{
    
    [[DBManager sharedInstance]updateTableData:[GoodsShoppingOrder class] UpdateColumns:[NSString stringWithFormat:@" isSelect = %d",isSelect?1 :0] Condition:[NSString stringWithFormat: @" goodsId = %lld",goodsId]];
}

+ (GoodsShoppingOrder *)getPictureBookOrder:(long long)orderId {
    return [[DBManager sharedInstance] loadTableFirstData:[GoodsShoppingOrder class] Condition:[NSString stringWithFormat:@" where goodsId = %lld", orderId]];
}

// 获取添加减少购物车数量
+ (void)addShoppingCount {
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:kShoppingCarCount];
    count ++;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:kShoppingCarCount];
}

+ (void)reduceShoppingCount:(NSInteger)reduceCount {
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:kShoppingCarCount];
    if (count > 0) {
        count -= reduceCount;
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:kShoppingCarCount];
    }
}

+ (NSInteger)getShoppingCount {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kShoppingCarCount];
}

// 获取总价格 (原价和现价)
+ (NSArray *)getPrice {
    double currentCostPrice = 0;
    double costPrice = 0;
    double buyCount = 0;
    NSArray * orders = [GoodsShoppingOrder getShoppingCarOrder];
    for (GoodsShoppingOrder * order in orders) {
        if (order.isSelect) {
            currentCostPrice += order.discountPrice * order.buyCount;
            costPrice += order.price * order.buyCount;
            buyCount +=1;
        }

    }
    return [NSArray arrayWithObjects:[NSNumber numberWithDouble:currentCostPrice], [NSNumber numberWithDouble:costPrice], [NSNumber numberWithDouble:buyCount],nil];
}


+ (NSArray *)getShoppingGoodsWithGoodsId:(long long)goodsId{
    
    return [[DBManager sharedInstance] loadTableData:[GoodsShoppingOrder class] Condition:[NSString stringWithFormat:@" where goodsId = %lld and isSelect = 1", goodsId]];
}

+ (NSArray *)getUnSelectedGoods{
    
    return [[DBManager sharedInstance] loadTableData:[GoodsShoppingOrder class] Condition:[NSString stringWithFormat:@" where  isSelect = 0"]];
}

+ (NSArray *)geBuyGoodsData{
    return [[DBManager sharedInstance] loadTableData:[GoodsShoppingOrder class] Condition:[NSString stringWithFormat:@" where  isSelect = 1"]];
}
@end


#pragma mark - Login Info
@implementation LoginInfo

@synthesize userId;
@synthesize deviceId;
@synthesize token;
@synthesize isLogined;

+(bool)isInSystemDB {
    return YES;
}

+(NSString *)getPrimaryKey
{
    return @"userId";
}

+(NSString *)getTableName
{
    return @"LoginInfo";
}

@end


@implementation AccountInfo



@end

@implementation UserLoginResponse



@end
