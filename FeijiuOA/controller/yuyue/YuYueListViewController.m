//
//  YuYueListViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/11.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "YuYueListViewController.h"
#import "AlertHelper.h"
#import "NoticeWebApi.h"
#import "UserPermission.h"
#import "YueyueListCell.h"
#import "YuYueListModel.h"
@interface YuYueListViewController
()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YuYueListViewController
-(void)viewDidLoad
{
      self. automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray array];
    [self getData];
    
}
-(void)getData
{
    [dataArr removeAllObjects];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [NoticeWebApi GetbookingdeliveryWithgysmc:[UserPermission standartUserInfo].gysjc Success:^(NSArray *arr) {
        
   
        NSLog(@"WWW %@",arr);
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in arr) {
            YuYueListModel *model=[[YuYueListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
        
        
        [self.tableView reloadData];
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"cell";
    YueyueListCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YueyueListCell" owner:self options:nil] lastObject];
    }
    YuYueListModel *model=dataArr[indexPath.row];
    cell.cc.text=model.cc;
    cell.gysmc.text=model.gysmc;
    cell.shrq.text=[self getTimeWithDate:model.shrq];
    cell.zl.text=model.zl;
    cell.dj.text=model.dj;
    cell.djsj.text=model.djsj;
    cell.hwmc.text=model.hwmc;
    return cell;
    
}
-(NSString *)getTimeWithDate:(NSString *)date
{
    NSString *str=@" ";
    NSRange range = [date rangeOfString:str];//匹配得到的下标
    NSString *   string;
    
    if (range.location!=NSNotFound)
    {
       // string = [date substringFromIndex:range.length+range.location];//截取范围类的字符串
        string = [date substringToIndex:range.location];//截取范围类的字符串
        
        return string;
    }
    else
    {
        return @"";
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    AddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"ZhiJian" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"addZhiJian"];
    //    BdListModel *model=dataArr[indexPath.row];
    //    tab.model=model;
    //    // [tab setRefreshNotification:self];
    //    [self.navigationController pushViewController:tab animated:YES];
    
}
-(void)refreshingDataList{
    // [self getData];
}
- (IBAction)reloadPress:(id)sender {
    //  [self getData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 124;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
