//
//  BoardReturnTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "SupplierflowView.h"
#import "URL.h"

@implementation SupplierflowView

{
  
   SupplierflowView *view;
    
}
-(SupplierflowView *)instanceChooseView
{

    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SupplierflowView" owner:nil options:nil];
    view= [nibView lastObject];
    return view;
}

@end
