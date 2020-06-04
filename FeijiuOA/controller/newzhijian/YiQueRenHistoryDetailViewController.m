//
//  YiQueRenHistoryDetailViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/29.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "YiQueRenHistoryDetailViewController.h"
#import "AlertHelper.h"
#import "ZhijianWebApi.h"
#import "ZhijianQueRenDetailModel.h"
#import "ZhiJianQuerenHistroyDetailCell.h"
#import "ZhijianQueRenDetailMainCell.h"
#import "UserPermission.h"

@interface YiQueRenHistoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
    NSString *sid;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YiQueRenHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray array];
    [self getData];
     [self.navigationItem setTitle:@"详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData
{
    [dataArr removeAllObjects];
    [dataArr addObject:_model];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi goodsinpriceconfigxqRkdh:_model.rkdh success:^(NSArray *userArr) {
        // NSLog(@"WWWW___%@",userArr);
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in userArr) {
            ZhijianQueRenDetailModel *model=[[ZhijianQueRenDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
        if (dataArr.count>1) {
            ZhijianQueRenDetailModel *model= dataArr[1];
            sid= model.SID;
            
        }
        
        // NSLog(@"QQQ1111 _ %@",dataArr);
        [self.tableView reloadData];
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        static NSString *identfier=@"jxccommoncell";
        ZhijianQueRenDetailMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhijianQueRenDetailMainCell" owner:self options:nil] lastObject];
        }
        cell.lab_rkdh.text=_model.rkdh;
        cell.lab_cph.text=_model.cph;
        cell.lab_mz.text=[NSString stringWithFormat:@"%@",_model.mz];
        cell.lab_gys.text=_model.gys;
        cell.lab_djsj.text=_model.mzsj;
        cell.lab_shr.text=_model.shr;
        
        return cell;
    }
    
    else
    {
        static NSString *identfier=@"cell";
        ZhiJianQuerenHistroyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhiJianQuerenHistroyDetailCell" owner:self options:nil] lastObject];
        }
        
        ZhijianQueRenDetailModel *model=dataArr[indexPath.row];
        cell.bz.text=model.bz;
        cell.dj.text=model.dj;
        cell.jyr.text=model.jyr;
        cell.jysj.text=[self getTimeWithDate:model.jysj];
        cell.qrr.text=model.qrr;
        cell.qrsj.text=model.qrsj;
        cell.kzbl.text=model.kzbl;
        cell.spnr.text=model.spnr;
         cell.dje.text=model.dje;
          cell.qrzt.text=model.qrzt;
        if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
              cell.lab_iskl.text=@"扣      率%:";
            
          
        }
        else{
            cell.lab_iskl.text=@"扣        重:";
            
            
        }
        
        return cell;
        
        
    }
    
    
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
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ZhiJianQueRenDetailController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ZhiJianQueRenDetail"];
//    ZhijianQueRenModel *model=dataArr[indexPath.row];
//    tab.model=model;
//    // [tab setRefreshNotification:self];
//    [self.navigationController pushViewController:tab animated:YES];
//
//}
-(void)refreshingDataList{
    [self getData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 202;
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
