//
//  NoticeWebApi.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/4.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeWebApi : NSObject
//公告列表
+(void)GetpricenoticedtWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//添加预约
+(void)inbookingDIc:(NSDictionary *)dic  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//货物名称
+(void)GethwmcdtWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail;

//预约列表
+(void)GetbookingdeliveryWithgysmc:(NSString *)gysmc Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//预约统计
+(void)GetbookingdeliveryWithPriceNoticesid:(NSString *)PriceNoticesid date:(NSString *)date Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;

@end
