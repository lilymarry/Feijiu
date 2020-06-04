//
//  LoginWebApi.h
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/8.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginWebApi : NSObject
// 登录
+(void)requestLogin:(NSString *)username andPassword:(NSString *)password success:(void (^)(NSArray *))success fail:(void(^)())fail;
+(void)getCompanySuccess:(void (^)(NSArray *))success fail:(void(^)())fail;
@end
