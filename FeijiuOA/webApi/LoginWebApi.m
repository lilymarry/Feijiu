//
//  LoginWebApi.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/8.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "LoginWebApi.h"
#import "URL.h"
#import "NetRequestTool.h"

#define kLogin_API [NSString stringWithFormat:@"%@/Wap/PaperGlobal.ashx",kDomain]
@implementation LoginWebApi
#pragma  登陆
+(void)requestLogin:(NSString *)username andPassword:(NSString *)password success:(void (^)(NSArray *))success fail:(void(^)())fail;
{
    NSDictionary * param = @{@"name":username,@"pwd":password,@"method":@"login",@"zdid":zdid};
    [[NetRequestTool sharedRequest] request:param URL:kLogin_API success:success  fail:fail ];
}
//获取厂区
+(void)getCompanySuccess:(void (^)(NSArray *))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"method":@"zd"};
    [[NetRequestTool sharedRequest] request:param URL:kLogin_API success:success  fail:fail ];
}
@end
