//
//  NoticeListViewCell.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;

@end
