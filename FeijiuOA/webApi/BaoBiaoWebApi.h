//
//  BaoBiaoWebApi.h
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/8.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoBiaoWebApi : NSObject
//获取基础信息
+(void)GetNewsWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail;

#pragma mark
//供应商流水(入库)接口
+(void)supplierflowWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//供应商金额统计(入库)接口
+(void)supplieramountstatisticsWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//供应商重量统计(入库)接口
+(void)supplierweightstatisticsWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;



@end
