//
//  ZhiJianDetailMainCell.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/6.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "ZhiJianDetailMainCell.h"

@implementation ZhiJianDetailMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn_gys.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btn_gys.contentEdgeInsets = UIEdgeInsetsMake(0,2, 0, 0);//文字距离做边框保持10个像素的距离。
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)surepress:(id)sender {
    if (self.dDelegate!=nil &&[self.dDelegate respondsToSelector:@selector(selectTelWithtel:)]) {
        [self.dDelegate selectTelWithtel:_btn_gys.titleLabel.text];
    }
}

@end
