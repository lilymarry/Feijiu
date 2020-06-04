//
//  NoticeMainModel.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "OABaseModel.h"
#import "NoticeSubModel.h"
@interface NoticeMainModel : OABaseModel
@property(strong,nonatomic)NSMutableArray *subLists;
@property(strong,nonatomic)NSString *djr;
@property(strong,nonatomic)NSString *djsj;
@property(strong,nonatomic)NSString *fbgs;
@property(strong,nonatomic)NSString *fbsj;
@property(strong,nonatomic)NSString *sid;




@end
