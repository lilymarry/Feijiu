//
//  SupplierAmountView.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "CK_SupplierAmountView.h"
#import "URL.h"
@implementation CK_SupplierAmountView
{
    
    CK_SupplierAmountView *view;
    
}
-(CK_SupplierAmountView *)instanceChooseView
{
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CK_SupplierAmountView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
