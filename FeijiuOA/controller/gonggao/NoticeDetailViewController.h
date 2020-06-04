//
//  NoticeDetailViewController.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeMainModel.h"
@interface NoticeDetailViewController : UIViewController
@property(strong,nonatomic)NoticeMainModel *mainModel;
@property(assign,nonatomic)BOOL isfirst;
@end
