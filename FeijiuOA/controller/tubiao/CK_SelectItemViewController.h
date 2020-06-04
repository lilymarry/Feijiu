//
//  CK_SelectItemViewController.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/1.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSString *hwmc,NSString *zdmc,NSString *khjc,NSString *st ,NSString *et );
@interface CK_SelectItemViewController : UIViewController
@property(nonatomic ,strong)NSString *state;  //曲线图表进入 1、2、3、4  滚动图0
@property(nonatomic,copy) finishBlock block;
@property(nonatomic ,strong)NSString *st;
@property(nonatomic ,strong)NSString *et;
@property(nonatomic ,strong)NSString *hwmc;
@property(nonatomic ,strong)NSString *zdmc;
@property(nonatomic ,strong)NSString *khjc;
-(id)initWithBlock:(finishBlock)ablock;
@end
