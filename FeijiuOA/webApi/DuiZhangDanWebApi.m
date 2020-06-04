//
//  DuiZhangDanWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/11.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "DuiZhangDanWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"


#define DuiZhangDanAPi [NSString stringWithFormat:@"%@/Wap/PaperGlobal.ashx",kDomain]
@implementation DuiZhangDanWebApi
//对账单接口
+(void)GetDuiZhangDanListWithUserName:(NSString *)userName success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"checkupaccount",@"zdid":zdid,@"username":userName};
    [[NetRequestTool sharedRequest] request:param URL:DuiZhangDanAPi success:success  fail:fail ];
}
//对账单明细接口
+(void)GetDuiZhangDanDetailWithdzdh:(NSString *)dzdh Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"checkupaccountcontent",@"zdid":zdid,@"dzdh":dzdh};
    [[NetRequestTool sharedRequest] request:param URL:DuiZhangDanAPi success:success  fail:fail ];
}
//对账单确认
+(void)checkupaccountWithdzdh:(NSString *)dzdh state:(NSString *)state remark:(NSString *)remark username:(NSString *)username Success:(void (^)(NSArray *))success fail:(void (^)(void))fail
{
    NSDictionary * param = @{@"method":@"checkupaccountconfiginsert",@"zdid":zdid,@"dzdh":dzdh,@"state":state,@"remark":remark,@"username":username};
    [[NetRequestTool sharedRequest] request:param URL:DuiZhangDanAPi success:success  fail:fail ];
}


@end
