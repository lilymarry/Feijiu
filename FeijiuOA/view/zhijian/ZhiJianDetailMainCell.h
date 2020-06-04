//
//  ZhiJianDetailMainCell.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/6.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol telDelegate <NSObject>
@optional
-(void)selectTelWithtel:(NSString *)tel;
@end
@interface ZhiJianDetailMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_rkdh;
@property (weak, nonatomic) IBOutlet UILabel *lab_cph;
@property (weak, nonatomic) IBOutlet UILabel *lab_mz;
@property (weak, nonatomic) IBOutlet UILabel *lab_gys;
@property (weak, nonatomic) IBOutlet UILabel *lab_djsj;
@property (weak, nonatomic) IBOutlet UILabel *lab_shr;

@property (weak, nonatomic) IBOutlet UILabel *lab_telState;
@property (weak, nonatomic) IBOutlet UIButton *btn_gys;
@property(weak,nonatomic) id <telDelegate>dDelegate;
@end
