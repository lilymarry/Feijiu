//
//  ZhijianWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/9.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "ZhijianWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"
#define shRequestList [NSString stringWithFormat:@"%@/wap/PaperGlobal.ashx",kDomain]

@implementation ZhijianWebApi

//质检列表
+(void)getzhiJianlistSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"zhiJianlist",@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//添加质检
+(void)addZhijianWithRkdh:(NSString *)rkdh zjsl:(NSString *)zjsl kl:(NSString *)kl dj:(NSString *)dj testman:(NSString *)testman price:(NSString *)price klz:(NSString *)klz  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"zhijianin",@"rkdh":rkdh,@"zjsl":zjsl ,@"kl":kl ,@"dj":dj,@"testman":testman,@"price":price,@"klz":klz,@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//获取等级
+(void)getDengjiSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
{
    NSDictionary *dic=@{@"method":@"dj",@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

#pragma mark new
//质检列表 new
+(void)getNewZhiJianlistdzj:(NSString *)dzj dqp:(NSString *)dqp gysjc:(NSString *)gysjc  Success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"newzhijianlist",@"dzj":dzj,@"dqp":dqp,@"zdid":zdid ,@"gysjc":gysjc };
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

//添加质检确认
+(void)insertGoodsinpriceconfigTypeDeduct:(NSString *)TypeDeduct InCode:(NSString *)InCode Supplier:(NSString *)Supplier GoodsName:(NSString *)GoodsName Degree:(NSString *)Degree WeightDeductRate:(NSString *)WeightDeductRate WeightDuduct:(NSString *)WeightDuduct Remark:(NSString *)Remark TestMan:(NSString *)TestMan CoID:(NSString *)CoID price:(NSString *)price zjsl:(NSString *)zjsl success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"goodsinpriceconfiginsert",@"TypeDeduct":TypeDeduct,@"InCode":InCode ,@"Supplier":Supplier ,@"GoodsName":GoodsName,@"Degree":Degree,@"WeightDeductRate":WeightDeductRate,@"WeightDuduct":WeightDuduct,@"Remark":Remark,@"TestMan":TestMan,@"CoID":CoID,@"zdid":zdid,@"price":price,@"zjsl":zjsl};
     [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//质检确认
+(void)goodsinpriceconfigqrState:(NSString *)State InCode:(NSString *)InCode ConfirmMan:(NSString *)ConfirmMan ConfirmRemark:(NSString *)ConfirmRemark SID:(NSString *)SID   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"goodsinpriceconfigqr",@"State":State,@"InCode":InCode ,@"ConfirmMan":ConfirmMan,@"zdid":zdid,@"ConfirmRemark":ConfirmRemark,@"SID":SID};
 ///   NSLog(@"WWW %@",dic);
  [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//质检确认列表
+(void)goodsinpriceconfiglistConfirmMan:(NSString *)ConfirmMan   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"goodsinpriceconfigdt",@"ConfirmMan":ConfirmMan,@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//质检确认历史详情
+(void)goodsinpriceconfigxqRkdh:(NSString *)rkdh   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"goodsinpriceconfigxq",@"rkdh":rkdh,@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

//质检确认历史
+(void)zhijianlisthistoryMaxid:(NSString *)maxid gysjc:(NSString *)gysjc page:(NSString *)page   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"zhijianlisthistory",@"maxid":maxid,@"zdid":zdid,@"page":page,@"gysjc":gysjc};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}


//质检确认列表详情
+(void)goodsinpriceconfigxqhistoryRkdh:(NSString *)rkdh   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"goodsinpriceconfigxqhistory",@"rkdh":rkdh,@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

//质检确认详情
+(void)goodsinpriceconfigxqhistoryRkdh:(NSString *)rkdh method:(NSString *)method   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":method,@"rkdh":rkdh,@"zdid":zdid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

@end
