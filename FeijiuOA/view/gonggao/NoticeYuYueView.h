//
//  NoticeYuYueView.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/10.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeMainModel.h"
@protocol NoticeYuYueDelegate <NSObject>
@optional
-(void)selectSheHeWithDic:(NSDictionary *)dic;


-(void)selectCancell;
@end

@interface NoticeYuYueView : UIView

@property(strong,nonatomic)NoticeMainModel *mainModel;
@property(weak,nonatomic) id <NoticeYuYueDelegate>dDelegate;
- (id)initWithFrame:(CGRect)frame andMode:( BOOL) pilaing;
-(void)refresh;
@end
