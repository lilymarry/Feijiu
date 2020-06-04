//
//  ZhijianlistHistoryModel.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/29.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "OABaseModel.h"

@interface ZhijianlistHistoryModel : OABaseModel
@property (nonatomic,strong) NSString *cph;
@property (nonatomic,strong) NSString *dj;
@property (nonatomic,strong) NSString *gys;
@property (nonatomic,strong) NSString *jysj;
@property (strong, nonatomic) NSString *maxid;
@property (strong, nonatomic) NSString *mz;
@property (strong, nonatomic) NSString *mzsj;
@property (strong, nonatomic) NSString *rkdh;
@property (strong, nonatomic) NSString *rkrq;
@property (strong, nonatomic) NSString *shr;//质检状态
@end
