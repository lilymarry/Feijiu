//
//  SupplierAmountView.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "SupplierWeightView.h"
#import "URL.h"
@implementation SupplierWeightView
{
    
    SupplierWeightView *view;
    
}
-(SupplierWeightView *)instanceChooseView
{
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SupplierWeightView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
