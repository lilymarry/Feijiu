//
//  MainCollectionViewCell.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/29.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 80, 80)];
       // _topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
        
        _tittleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 90, 30)];
        _tittleLab.textAlignment = NSTextAlignmentCenter;
        //_tittleLab.textColor = [UIColor blueColor];
        _tittleLab.font = [UIFont systemFontOfSize:13];
       // _tittleLab.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_tittleLab];
    }
    
    return self;
}


@end
