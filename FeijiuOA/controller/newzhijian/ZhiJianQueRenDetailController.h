//
//  ZhiJianQueRenDetailController.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/17.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiJianQueRenListModel.h"
#import "CommonDelegate.h"
@interface ZhiJianQueRenDetailController : UIViewController
@property(strong,nonatomic)ZhiJianQueRenListModel *model;
@property (weak,nonatomic) id<CommonNotification> refreshNotification;
@end
