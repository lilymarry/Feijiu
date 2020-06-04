//
//  NoticeDetailMainCell.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/8.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NoticeDetailMainCell.h"
#import "NoticeDetailSubCell.h"
@implementation NoticeDetailMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code—
   
    
}
-(void)setCellTableViewHeight
{
    [_tableView removeFromSuperview];
    _tableView.frame=CGRectMake(0, 177, self.frame.size.width, _mainModel.subLists.count*47);
    [self.contentView  addSubview: _tableView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

        return _mainModel.subLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        static NSString *identfier=@"cell2";
        NoticeDetailSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeDetailSubCell" owner:self options:nil] lastObject];
        }
        NoticeSubModel *model1=_mainModel.subLists[indexPath.row];
        cell.lab_dengji.text=model1.dj;
        cell.lab_jine.text=model1.dje;
        if (indexPath.row!=0) {
            cell.lab_line.hidden=YES;
        }
        else
        {
            cell.lab_line.hidden=NO;
            
        }
        return cell;
        
        
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 47;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"jckdcds");
}

@end
