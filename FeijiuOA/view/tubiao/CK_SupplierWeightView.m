//
//  SupplierAmountView.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "CK_SupplierWeightView.h"
#import "URL.h"
@implementation CK_SupplierWeightView
{
    
    CK_SupplierWeightView *view;
    
}
-(CK_SupplierWeightView *)instanceChooseView
{
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CK_SupplierWeightView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
