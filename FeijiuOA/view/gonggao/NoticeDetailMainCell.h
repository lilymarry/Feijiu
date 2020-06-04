//
//  NoticeDetailMainCell.h
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/8.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeMainModel.h"
@interface NoticeDetailMainCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_person;
@property (weak, nonatomic) IBOutlet UITextView *lab_content;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NoticeMainModel *mainModel;
@property(nonatomic,assign)CGFloat cellHeight;
-(void)setCellTableViewHeight;

@end
