//
//  FlowImageCollectionCell.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/25.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "FlowImageCollectionCell.h"

@implementation FlowImageCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-10, self.frame.size.height-10)];
       // _topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
     
    }
    
    return self;
}
@end
