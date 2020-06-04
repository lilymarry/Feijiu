//
//  BaoBiaoWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/8.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "BaoBiaoWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"

#define jcxx_APi [NSString stringWithFormat:@"%@/wap/WapGoodsIn.ashx",kDomain]


@implementation BaoBiaoWebApi

//获取基础信息
+(void)GetNewsWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"jcxx",@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}


#pragma mark
//供应商流水(入库)接口
+(void)supplierflowWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":method,@"hwmc":hwmc,@"date":date,@"gys":gys,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}
//供应商金额统计(入库)接口
+(void)supplieramountstatisticsWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":method,@"hwmc":hwmc,@"date":date,@"gys":gys,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}
//供应商重量统计(入库)接口
+(void)supplierweightstatisticsWithDate:(NSString *)date hwmc:(NSString*)hwmc gys:(NSString *)gys method:(NSString *)method  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":method,@"hwmc":hwmc,@"date":date,@"gys":gys,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:jcxx_APi success:success  fail:fail ];
}




@end
    
