//
//  DuiZhangDanListControllerViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/11.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "DuiZhangDanListControllerViewController.h"
#import "AlertHelper.h"
#import "DuiZhangDanWebApi.h"
#import "DuiZhangDanListCell.h"
#import "DuizhangdanListModel.h"
#import "DuiZhangDanDetailController.h"
#import "UserPermission.h"
@interface DuiZhangDanListControllerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
      NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DuiZhangDanListControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
      [self.navigationItem setTitle:@"对账单"];
    dataArr=[NSMutableArray new];
    [self getData];
}
-(void)getData
{
    [dataArr removeAllObjects];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [DuiZhangDanWebApi GetDuiZhangDanListWithUserName:[UserPermission standartUserInfo].yhm success:^(NSArray *arr) {
        //          NSLog(@"1Sss %@",arr);
        //NSLog(@"2Sss %@",arr[0]);
        [AlertHelper hideAllHUDsForView:self.view];
       
        for (NSDictionary *dict1 in arr) {
            DuizhangdanListModel *model=[[DuizhangdanListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
        
        
        [self.tableView reloadData];
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"cell";
    DuiZhangDanListCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DuiZhangDanListCell" owner:self options:nil] lastObject];
    }
    DuizhangdanListModel *model=dataArr[indexPath.row];
    cell.dzdh.text=model.dzdh;
    cell.gysjc.text=model.gysjc;
    cell.qsrq.text=[self getTimeWithDate:model.qsrq];
    cell.jzrq.text=model.jzrq;
    cell.zcc.text=model.zcc;
    cell.zje.text=model.zje;
    cell.sh.text=model.sh;
 
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
        DuiZhangDanDetailController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DuiZhangDanDetai"];
        DuizhangdanListModel *model=dataArr[indexPath.row];
        tab.model=model;
        [self.navigationController pushViewController:tab animated:YES];
    
}
-(void)refreshingDataList{
    // [self getData];
}
- (IBAction)reloadPress:(id)sender {
    [self getData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 120;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
