//
//  Baobiao_ckWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/1.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "Baobiao_ckWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"

#define jcxx_APi [NSString stringWithFormat:@"%@/wap/WapGoodsOut.ashx",kDomain]
@implementation Baobiao_ckWebApi
//获取基础信息
+(void)ck_GetNewsWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"jcxx",@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}

#pragma mark
//供应商流水(出库)接口
+(void)ck_supplierflowWithDate:(NSString *)date kh:(NSString*)kh hwmc:(NSString *)hwmc method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":method,@"hwmc":hwmc,@"date":date,@"kh":kh,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}
//供应商金额统计(出库)接口
+(void)ck_supplieramountstatisticsWithDate:(NSString *)date kh:(NSString*)kh hwmc:(NSString *)hwmc method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param =@{@"method":method,@"hwmc":hwmc,@"date":date,@"kh":kh,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}
//供应商重量统计(出库)接口
+(void)ck_supplierweightstatisticsWithDate:(NSString *)date kh:(NSString*)kh hwmc:(NSString *)hwmc method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param =@{@"method":method,@"hwmc":hwmc,@"date":date,@"kh":kh,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}
@end
