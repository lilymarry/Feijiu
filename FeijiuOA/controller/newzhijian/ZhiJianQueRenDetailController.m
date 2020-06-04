//
//  ZhiJianQueRenDetailController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/17.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "ZhiJianQueRenDetailController.h"
#import "AlertHelper.h"
#import "ZhijianWebApi.h"
#import "ZhijianQueRenDetailModel.h"
#import "ZhijianQueRenDetailSubCell.h"
#import "ZhijianQueRenDetailMainCell.h"
#import "UserPermission.h"
#import "NewAddZhiJianViewController.h"
#import "ZhijianQueRenDetailSubCell1.h"
@interface ZhiJianQueRenDetailController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
     NSMutableArray *dataArr;
    NSString *sid;
  //  NSString *method;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZhiJianQueRenDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     dataArr=[NSMutableArray array];
  //  if (_flag==1) {
         [self.navigationItem setTitle:@"待审核"];
 //        method=@"goodsinpriceconfigxqhistory";
        
//    }
//    else
//    {
//         [self.navigationItem setTitle:@"详情"];
//         method=@"goodsinpriceconfigxq";
//    }
//
    
    self.automaticallyAdjustsScrollViewInsets=NO;

   
    [self getData];
    

    
    
}
-(void)getData
{
    [dataArr removeAllObjects];
    [dataArr addObject:_model];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [ZhijianWebApi goodsinpriceconfigxqhistoryRkdh:_model.rkdh method:@"goodsinpriceconfigxqhistory"  success:^(NSArray *userArr) {
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
        cell.lab_shr.text=_model.shr;
 
         cell.lab_djsj.text=_model.mzsj;;
      

        return cell;
    }
    
    else
    {
      
            static NSString *identfier=@"cell";
            ZhijianQueRenDetailSubCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhijianQueRenDetailSubCell1" owner:self options:nil] lastObject];
            }
            
            ZhijianQueRenDetailModel *model=dataArr[indexPath.row];
            cell.bz.text=model.bz;
            cell.dj.text=model.dj;
            cell.jyr.text=model.jyr;
            cell.jysj.text=[self getTimeWithDate:model.jysj];
            cell.kz.text=model.kzbl;
            cell.dje.text=model.dje;
            cell.qrzt.text=model.qrzt;
        if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
            cell.lab_iskl.text=@"扣率%:";
            
        }
        else{
            cell.lab_iskl.text=@"扣重:";
            
        }
            
            
            return cell;
 
    }

    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
 
   
    
  
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIButton * bt_selectPerson=[UIButton buttonWithType:UIButtonTypeCustom];
        bt_selectPerson.frame=CGRectMake(70, 10,(self.view.frame.size.width-160)/2, 40);
        [bt_selectPerson setTitle:@"驳回" forState:UIControlStateNormal];
        [bt_selectPerson addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        [bt_selectPerson setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        bt_selectPerson.tag=1000;
        bt_selectPerson.titleLabel .font =[UIFont systemFontOfSize:14];
        [view addSubview:bt_selectPerson];
        
        
        UIButton * bt_selectPerson1=[UIButton buttonWithType:UIButtonTypeCustom];
        bt_selectPerson1.frame=CGRectMake(CGRectGetMaxX(bt_selectPerson.frame)+20, 10,(self.view.frame.size.width-160)/2, 40);
        [bt_selectPerson1 setTitle:@"同意" forState:UIControlStateNormal];
        [bt_selectPerson1 addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        [bt_selectPerson1 setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        bt_selectPerson1.tag=1001;
        bt_selectPerson1.titleLabel .font =[UIFont systemFontOfSize:14];
        [view addSubview:bt_selectPerson1];
        return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
       return 60;
    
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
- (void)selectPress:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"驳回" otherButtonTitles:@"同意", nil];
    sheet.delegate=self;
    
    
    [sheet showInView:self.view];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0) {
        return 200;
    }
    else
    {return 234;}
}

-(void)surePress:(id)sender
{
    UIButton *but=(UIButton *)sender;
    if (but.tag==1000)
    {
        
        // NSLog(@"0");
        [self getfaBuDescribe1WithTag:@"2"];
    }
    else
        
    {
        
        // NSLog(@"1");
        [self getfaBuDescribe1WithTag:@"1"];
    }
//    else
//    {
//        NewAddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewAddZhiJian"];
//        tab.model=_model;
//        [self.navigationController pushViewController:tab animated:YES];
//
//    }
    
}
-(void)getfaBuDescribe1WithTag:(NSString *)tagg
{
    NSString *beiZhu;
    if ([tagg isEqualToString:@"2"]) {
        beiZhu=@"您是否驳回该条质检信息";
    }
    else
    {
          beiZhu=@"您是否同意该条质检信息";
    }
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: beiZhu
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    UITextField * text1 = [theAlert textFieldAtIndex:0];
     text1.placeholder=@"输入备注";
    theAlert.tag=[tagg intValue];
    [theAlert show];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (theAlert.tag==2000)
    {
        NSObject<CommonNotification> *tmpDele=self.refreshNotification;
        [tmpDele refreshingDataList];
        [self.navigationController popViewControllerAnimated: YES];
    }
    else
    {
        
        if ([@"确定" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
            NSString *pingyuStr=@"";
            if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
                pingyuStr = [theAlert textFieldAtIndex:0].text;
            }
            
            if (theAlert.tag==2) {
                [self faBuPressWithState:@"2" andContent:pingyuStr];
                
            }
            
            else  {
                [self faBuPressWithState:@"1" andContent:pingyuStr];
                
                
            }
            
        }
    }
}
- (void)faBuPressWithState:(NSString *)state andContent:(NSString *)content
{
    
   
    if(sid.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"唯一标识为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      
        [alert show];
    }
    else
    {
    [AlertHelper singleMBHUDShow:@"提交中--" ForView:self.view];
    [ZhijianWebApi goodsinpriceconfigqrState:state InCode:_model.rkdh ConfirmMan:[UserPermission standartUserInfo].gysjc ConfirmRemark:content SID:  sid success:^(NSArray *userArr) {
        
        [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *userDic=userArr[0];
        if ([[userDic objectForKey:@"bool"]isEqualToString:@"1"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             alert.tag=2000;
            [alert show];
        }
        else {
            UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:userDic[@"content"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];
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
