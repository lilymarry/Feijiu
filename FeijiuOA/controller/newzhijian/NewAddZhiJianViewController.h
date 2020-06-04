//
//  NewAddZhiJianViewController.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/16.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewZhiJianListModel.h"
#import "CommonDelegate.h"
@interface NewAddZhiJianViewController : UIViewController
@property (weak,nonatomic) id<CommonNotification> refreshNotification;
@property(strong,nonatomic)NewZhiJianListModel* model;
@end
