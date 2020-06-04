//
//  ZhijianWebApi.h
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/9.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhijianWebApi : NSObject

//质检列表
+(void)getzhiJianlistSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//添加质检
+(void)addZhijianWithRkdh:(NSString *)rkdh zjsl:(NSString *)zjsl kl:(NSString *)kl dj:(NSString *)dj testman:(NSString *)testman price:(NSString *)price klz:(NSString *)klz  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//获取等级
+(void)getDengjiSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

#pragma mark new
//质检列表 new
+(void)getNewZhiJianlistdzj:(NSString *)dzj dqp:(NSString *)dqp gysjc:(NSString *)gysjc Success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//添加质检确认
+(void)insertGoodsinpriceconfigTypeDeduct:(NSString *)TypeDeduct InCode:(NSString *)InCode Supplier:(NSString *)Supplier GoodsName:(NSString *)GoodsName Degree:(NSString *)Degree WeightDeductRate:(NSString *)WeightDeductRate WeightDuduct:(NSString *)WeightDuduct Remark:(NSString *)Remark TestMan:(NSString *)TestMan CoID:(NSString *)CoID price:(NSString *)price zjsl:(NSString *)zjsl success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//质检确认
+(void)goodsinpriceconfigqrState:(NSString *)State InCode:(NSString *)InCode ConfirmMan:(NSString *)ConfirmMan ConfirmRemark:(NSString *)ConfirmRemark SID:(NSString *)SID   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//质检确认列表
+(void)goodsinpriceconfiglistConfirmMan:(NSString *)ConfirmMan   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//质检确认列表详情
+(void)goodsinpriceconfigxqRkdh:(NSString *)rkdh   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//质检确认历史
+(void)zhijianlisthistoryMaxid:(NSString *)maxid gysjc:(NSString *)gysjc page:(NSString *)page   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//质检确认列表详情
+(void)goodsinpriceconfigxqhistoryRkdh:(NSString *)rkdh   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//质检确认详情
+(void)goodsinpriceconfigxqhistoryRkdh:(NSString *)rkdh method:(NSString *)method   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
