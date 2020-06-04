//
//  NoticeWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/4.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NoticeWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"

#define notice_APi [NSString stringWithFormat:@"%@/Wap/WapPriceNoticeHandler.ashx",kDomain]
#define hwmn_notice_APi [NSString stringWithFormat:@"%@/Wap/PaperGlobal.ashx",kDomain]
@implementation NoticeWebApi
//公告列表
+(void)GetpricenoticedtWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"pricenoticedt",@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:notice_APi success:success  fail:fail ];
}

//添加预约
+(void)inbookingDIc:(NSDictionary *)dic  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
   
    [[NetRequestTool sharedRequest] request:dic URL:notice_APi success:success  fail:fail ];
}
//货物名称
+(void)GethwmcdtWithSuccess:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"hwmcdt",@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:hwmn_notice_APi success:success  fail:fail ];
}

//预约列表
+(void)GetbookingdeliveryWithgysmc:(NSString *)gysmc Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"bookingdeliverylist",@"gysmc":gysmc,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:notice_APi success:success  fail:fail ];
}
//预约统计
+(void)GetbookingdeliveryWithPriceNoticesid:(NSString *)PriceNoticesid date:(NSString *)date  Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"bookingdelivery",@"PriceNoticesid":PriceNoticesid,@"date":date,@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:notice_APi success:success  fail:fail ];
    
}

@end
