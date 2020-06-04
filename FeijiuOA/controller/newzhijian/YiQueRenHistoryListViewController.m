//
//  YiQueRenListViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/29.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "YiQueRenHistoryListViewController.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import "MJRefresh.h"
#import "ZhijianWebApi.h"
#import "ZhijianlistHistoryModel.h"
#import "JXCCommonCell.h"
#import "YiQueRenHistoryDetailViewController.h"
@interface YiQueRenHistoryListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     NSMutableArray *dataArr;
    NSString *maxid;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YiQueRenHistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"已确认记录"];
     maxid=@"0";
    dataArr =[NSMutableArray array];
    [self setupRefresh];
}
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ZhijianWebApi zhijianlisthistoryMaxid:@"0" gysjc:[UserPermission standartUserInfo].gysjc page:@"0" success:^(NSArray *userArr) {
      [dataArr removeAllObjects];
        
        for (NSDictionary *dict1 in userArr) {
            ZhijianlistHistoryModel *model=[[ZhijianlistHistoryModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
         
            [dataArr addObject:model];
        }
        if (dataArr.count>0) {
              ZhijianlistHistoryModel *model=dataArr[0];
               maxid=model.maxid;
        }
     [self.tableView reloadData];
    //结束刷新状态
    [self.tableView headerEndRefreshing];
    
} fail:^{
    [self.tableView headerEndRefreshing];
    
    [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
}];
   
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        self.tableView.footerRefreshingText = @"无更新数据";
        [self.tableView footerEndRefreshing];
        return ;
    }
    else
    {
        [ZhijianWebApi zhijianlisthistoryMaxid:maxid gysjc:[UserPermission standartUserInfo].gysjc page:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count] success:^(NSArray *userArr) {
         
            for (NSDictionary *dict1 in userArr) {
                ZhijianlistHistoryModel *model=[[ZhijianlistHistoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dict1];
                
                [dataArr addObject:model];
            }
           
            [self.tableView reloadData];
            //结束刷新状态
            [self.tableView footerEndRefreshing];
            
        } fail:^{
            [self.tableView footerEndRefreshing];
            
            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
        }];
    }
       
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identfier=@"jxccommoncell";
    JXCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JXCCommonCell" owner:self options:nil] lastObject];
    }
    ZhijianlistHistoryModel *model=dataArr[indexPath.row];
    cell.lab_rkdh.text=model.rkdh;
    
   cell.lab_djsj.text=[self getTimeWithDate:model.jysj];
    cell.lab_cph.text=model.cph;
    cell.lab_gys.text=model.gys;
    cell.lab_state.text=@"";
    
    return cell;
    
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiQueRenHistoryDetailViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"YiQueRenHistoryDetail"];
    ZhijianlistHistoryModel *model=dataArr[indexPath.row];
    tab.model=model;
   
    [self.navigationController pushViewController:tab animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 84;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
