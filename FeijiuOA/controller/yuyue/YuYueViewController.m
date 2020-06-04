//
//  YuYueViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/11.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "YuYueViewController.h"
#import "NoticeWebApi.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import "YuYueModel.h"
#import "YuYueCell.h"
@interface YuYueViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_time;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YuYueViewController

- (void)viewDidLoad {     [super viewDidLoad];
    // Do any additional setup after loading the view.
    self. automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray new];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [NSDate dateWithTimeInterval :24*60*60+8 sinceDate:date];
    [_btn_time setTitle:[dateFormatter1 stringFromDate:date1] forState:UIControlStateNormal];
    [self getDataWithTime:[dateFormatter1 stringFromDate:date1]];
    
    
}
- (IBAction)timePress:(id)sender {
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:_btn_time.titleLabel.text];
        NSDate *lastDay;
        if (but.tag==1000) {//时区问题 +8
            lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
            
        }
        else
        {
            lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
        }
        
        [_btn_time setTitle:[dateFormatter stringFromDate:lastDay] forState:UIControlStateNormal];
      [self getDataWithTime:[dateFormatter stringFromDate:lastDay]];
   
   
    
    
    
    
}
-(void)getDataWithTime:(NSString *)time
{
    [dataArr removeAllObjects];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [NoticeWebApi GetbookingdeliveryWithPriceNoticesid:@"0" date:time Success:^(NSArray *arr) {
        NSLog(@"WWW %@",arr);
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in arr) {
            YuYueModel *model=[[YuYueModel alloc]init];
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
    YuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YuYueCell" owner:self options:nil] lastObject];
    }
    YuYueModel *model=dataArr[indexPath.row];
    cell.cc.text=model.cc;
    cell.gysmc.text=model.gysmc;
    cell.shrq.text=model.shrq;
    cell.zl.text=model.zl;
    
    return cell;
    
}
-(NSString *)getTimeWithDate:(NSString *)date
{
    NSString *str=@" ";
    NSRange range = [date rangeOfString:str];//匹配得到的下标
    NSString *   string;
    
    if (range.location!=NSNotFound)
    {
        string = [date substringFromIndex:range.length+range.location];//截取范围类的字符串
        
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
    
    
    return 77;
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
