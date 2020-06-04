//
//  BoardReturnTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "CK_SupplierflowView.h"
@implementation CK_SupplierflowView

{
  
   CK_SupplierflowView *view;
    
}
-(CK_SupplierflowView *)instanceChooseView
{

    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CK_SupplierflowView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
