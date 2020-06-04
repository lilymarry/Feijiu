//
//  NewZhiJianListViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/13.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NewZhiJianListViewController.h"
#import "ZhijianWebApi.h"
#import "NewZhiJianListModel.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import  "JXCCommonCell.h"
#import "NewAddZhiJianViewController.h"
#import "ZhiJianDetailViewController.h"

@interface NewZhiJianListViewController ()
<UITableViewDelegate,UITableViewDataSource,CommonNotification>
{
    NSMutableArray *dataArr;
    NSString *zhijian_state;
    NSString *qupi_state;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewZhiJianListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self. automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray new];
    zhijian_state= @"dzj";
    qupi_state=@"";

    [self getData];
    
    
    
}

-(void)getData
{
    [dataArr removeAllObjects];
    NSString *gys;
    if ([[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        gys=[UserPermission standartUserInfo].gysjc;
    }
    else
    {
        gys=@"";
        
    }
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi getNewZhiJianlistdzj:zhijian_state dqp:qupi_state gysjc:gys Success: ^(NSArray *userArr) {
        
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in userArr) {
            NewZhiJianListModel *model=[[NewZhiJianListModel alloc]init];
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
    NewZhiJianListModel *model=dataArr[indexPath.row];
    cell.lab_rkdh.text=model.rkdh;
    cell.lab_djsj.text=model.djsj;
    cell.lab_cph.text=model.cph;
    cell.lab_gys.text=model.gys;
    cell.lab_state.text=model.zjzt;
    
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
    NewZhiJianListModel *model=dataArr[indexPath.row];
    
    if (![model.zjzt isEqualToString:@"待质检"]) {
        
       
        ZhiJianDetailViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ZhiJianDetail"];
        tab.model=model;
        [self.navigationController pushViewController:tab animated:YES];
        
        
    }
    else
    {
        NewAddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewAddZhiJian"];
        tab.model=model;
        tab.refreshNotification=self;
        [self.navigationController pushViewController:tab animated:YES];
       
    }

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


@end
