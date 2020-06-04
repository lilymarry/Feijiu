//
//  ZhiJianListViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/14.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "ZhiJianListViewController.h"
#import "ZhijianWebApi.h"
#import "BdListModel.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import "MJRefresh.h"
#import  "JXCCommonCell.h"
//#import "YzjDetailViewController.h"
#import "AddZhiJianViewController.h"
@interface ZhiJianListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZhiJianListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self. automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray new];
    
    [self getData];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;    //让rootView禁止滑动
    //    }
}
-(void)getData
{
       [dataArr removeAllObjects];
      [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi getzhiJianlistSuccess:^(NSArray *userArr) {
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in userArr) {
            BdListModel *model=[[BdListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
        
        
        [self.tableView reloadData];
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];
    
}
-(IBAction)lastPress:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"jxccommoncell";
    JXCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JXCCommonCell" owner:self options:nil] lastObject];
    }
    BdListModel *model=dataArr[indexPath.row];
    cell.lab_rkdh.text=model.rkdh;
  //  cell.lab_djsj.text=[self getTimeWithDate:model.djsj];
      cell.lab_djsj.text=model.djsj;
    cell.lab_cph.text=model.cph;
    cell.lab_gys.text=model.gys;
    
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
    AddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"ZhiJian" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"addZhiJian"];
    BdListModel *model=dataArr[indexPath.row];
    tab.model=model;
    // [tab setRefreshNotification:self];
    [self.navigationController pushViewController:tab animated:YES];
    
}
-(void)refreshingDataList{
    [self getData];
}
- (IBAction)reloadPress:(id)sender {
    [self getData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 84;
}
- (IBAction)seletPress:(id)sender {
}



@end
