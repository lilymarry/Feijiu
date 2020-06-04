//
//  SupplierAmountView.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "SupplierAmountView.h"
#import "URL.h"
@implementation SupplierAmountView
{
    
    SupplierAmountView *view;
    
}
-(SupplierAmountView *)instanceChooseView
{
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SupplierAmountView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
