//
//  DuiZhangDanWebApi.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/11.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuiZhangDanWebApi : NSObject
//对账单接口
+(void)GetDuiZhangDanListWithUserName:(NSString *)userName success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//对账单明细接口
+(void)GetDuiZhangDanDetailWithdzdh:(NSString *)dzdh Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;
//对账单确认
+(void)checkupaccountWithdzdh:(NSString *)dzdh state:(NSString *)state remark:(NSString *)remark username:(NSString *)username Success:(void (^)(NSArray *))success fail:(void (^)(void))fail;

@end
