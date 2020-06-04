//
//  SelectItemViewController.h
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSString *hwmc,NSString *gys,NSString *st ,NSString *et );
@interface SelectItemViewController : UIViewController
@property(nonatomic ,strong)NSString *state;  //曲线图表进入 1、2、3、4  滚动图0
@property(nonatomic,copy) finishBlock block;

@property(nonatomic ,strong)NSString *st;
@property(nonatomic ,strong)NSString *et;
@property(nonatomic ,strong)NSString *hwmc;
@property(nonatomic ,strong)NSString *gys;

//-(void)refreshDataSt:(NSString *)st et:(NSString *)et hwmc:(NSString *)hwmc gys:(NSString *)gys;
-(id)initWithBlock:(finishBlock)ablock;
@end
