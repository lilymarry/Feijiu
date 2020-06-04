//
//  ZhiJianQueRenListController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/17.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "ZhiJianQueRenListController.h"
#import "ZhijianWebApi.h"
//#import "ZhijianQueRenModel.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import "ZhijianQueRenlistCell.h"
#import "ZhiJianQueRenDetailController.h"
#import "NewZhiJianListModel.h"
#import "NewZhiJianListViewController.h"
#import "ZhiJianQueRenListModel.h"
@interface ZhiJianQueRenListController ()
<UITableViewDelegate,UITableViewDataSource,CommonNotification>
{
    NSMutableArray *dataArr;
    NSString *zhijian_state;
    NSString *qupi_state;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZhiJianQueRenListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self. automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray new];
     [self getData];
}
-(void)getData
{
    [dataArr removeAllObjects];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi goodsinpriceconfiglistConfirmMan:[UserPermission standartUserInfo].gysjc success:^(NSArray *userArr) {
        
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in userArr) {
           ZhiJianQueRenListModel  *model=[[ZhiJianQueRenListModel alloc]init];
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
    ZhijianQueRenlistCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhijianQueRenlistCell" owner:self options:nil] lastObject];
    }
    ZhiJianQueRenListModel *model=dataArr[indexPath.row];
    cell.gys.text=model.gys;
 
    cell.cph.text=model.cph;
    cell.jysj.text=[self getTimeWithDate:model.jysj];
    cell.rkdh.text=model.rkdh;
    
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
    ZhiJianQueRenDetailController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ZhiJianQueRenDetail"];
    ZhiJianQueRenListModel *model=dataArr[indexPath.row];
    tab.model=model;
     tab.refreshNotification=self;
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
    
    
    return 68;
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // segue.identifier：获取连线的ID
//    if ([segue.identifier isEqualToString:@"newzhijianlist"]) {
//        // segue.destinationViewController：获取连线时所指的界面（VC）
//        NewZhiJianListViewController *Supplierflow = segue.destinationViewController;
//        Supplierflow.flag = 1;
//        
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
