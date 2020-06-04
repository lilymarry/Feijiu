//
//  ZhiJianDetailViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/6.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "ZhiJianDetailViewController.h"
#import "AlertHelper.h"
#import "ZhijianWebApi.h"
#import "ZhijianQueRenDetailModel.h"
#import "ZhijianQueRenDetailSubCell.h"
#import "ZhijianQueRenDetailMainCell.h"
#import "UserPermission.h"
#import "NewAddZhiJianViewController.h"
#import "ZhijianQueRenDetailSubCell1.h"

#import "ZhiJianDetailMainCell.h"
@interface ZhiJianDetailViewController ()
<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,telDelegate>
{
    NSMutableArray *dataArr;
  

    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZhiJianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

      dataArr=[NSMutableArray array];
      [self.navigationItem setTitle:@"审核详情"];

    
    
  //  self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    [self getData];
    
    
}
-(void)getData
{
    [dataArr removeAllObjects];
    [dataArr addObject:_model];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi goodsinpriceconfigxqhistoryRkdh:_model.rkdh method:@"goodsinpriceconfigxq"  success:^(NSArray *userArr) {
        // NSLog(@"WWWW___%@",userArr);
        [AlertHelper hideAllHUDsForView:self.view];
        for (NSDictionary *dict1 in userArr) {
            ZhijianQueRenDetailModel *model=[[ZhijianQueRenDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
       
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
        ZhiJianDetailMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhiJianDetailMainCell" owner:self options:nil] lastObject];
        }
        cell.lab_rkdh.text=_model.rkdh;
        cell.lab_cph.text=_model.cph;
        cell.lab_mz.text=[NSString stringWithFormat:@"%@",_model.mz];
        cell.lab_gys.text=_model.gys;
        cell.lab_shr.text=_model.shr;
       
        cell.lab_djsj.text=_model.mzsj;
      
        cell.lab_telState.hidden=NO;
      [ cell.btn_gys setTitle:_model.dh forState:UIControlStateNormal];
        cell.dDelegate =self;
        
       
        return cell;
    }
    
    else
    {
       ZhijianQueRenDetailModel *model=dataArr[indexPath.row];
        if ([model.qrzt isEqualToString:@"待确认"])
        {
            static NSString *identfier=@"cell";
            ZhijianQueRenDetailSubCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhijianQueRenDetailSubCell1" owner:self options:nil] lastObject];
            }
            cell.bz.text=model.bz;
            cell.dj.text=model.dj;
            cell.jyr.text=model.jyr;
            cell.jysj.text=[self getTimeWithDate:model.jysj];
            cell.kz.text=model.kzbl;
            cell.dje.text=model.dje;
            cell.qrzt.text=model.qrzt;
            if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
                cell.lab_iskl.text=@"扣       率%:";
                
            }
            else{
                cell.lab_iskl.text=@"扣         重:";
                
            }
            
            
            return cell;
        }
        else
        {
            static NSString *identfier=@"cell";
            ZhijianQueRenDetailSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhijianQueRenDetailSubCell" owner:self options:nil] lastObject];
            }
            cell.bz.text=model.bz;
            cell.dj.text=model.dj;
            cell.jyr.text=model.jyr;
            cell.jysj.text=[self getTimeWithDate:model.jysj];
            cell.kz.text=model.kzbl;
            cell.dje.text=model.dje;
            cell.qrzt.text=model.qrzt;
            cell.qrr.text=model.qrr;
            cell.qrsj.text=[self getTimeWithDate:model.qrsj];
            cell.spnr.text=model.spnr;
            if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
                   cell.lab_iskl.text=@"扣       率%:";
              
            }
            else{
                   cell.lab_iskl.text=@"扣         重:";
                
            }
            
            
            return cell;
            
        }
        
    }
  
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_model.zjzt isEqualToString:@"驳回"]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        UIButton * bt_selectPerson1=[UIButton buttonWithType:UIButtonTypeCustom];
        bt_selectPerson1.frame=CGRectMake(20, 10,self.view.frame.size.width-40, 40);
        [bt_selectPerson1 setTitle:@"重新提交质检" forState:UIControlStateNormal];
        [bt_selectPerson1 addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        [bt_selectPerson1 setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        bt_selectPerson1.tag=1002;
        bt_selectPerson1.titleLabel .font =[UIFont systemFontOfSize:14];
        [view addSubview:bt_selectPerson1];
        return view;
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if ([_model.zjzt isEqualToString:@"驳回"]) {
        return 60;
    }
    else
    {
        return 0;
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

-(void)refreshingDataList{
    [self getData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0) {
        return 277;
    }
    else
    {
        ZhijianQueRenDetailModel *model=dataArr[indexPath.row];
        if ([model.qrzt isEqualToString:@"待确认"])
        {
            return 150;
        }
        else
        {
          return 234;
        }
        
    }
    return 0;
}

-(void)surePress:(id)sender
{

        NewAddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewAddZhiJian"];
        tab.model=_model;
        [self.navigationController pushViewController:tab animated:YES];
        
  
    
}


- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

    if (theAlert.tag==100)
    {
        if (buttonIndex==1)
        {
            if (theAlert.message.length==0) {
                [AlertHelper singleAlertShowAndMBHUDHid:@"手机号为空" ForView:self.view];
                
            }
            
            else  {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",theAlert.message]]];
                
                
            }
            
            
        }
    }
    
}

-(void)selectTelWithtel:(NSString *)tel
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否拨打电话" message:tel delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"拨打", nil];
    alert.tag=100;
    [alert show];
    
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
