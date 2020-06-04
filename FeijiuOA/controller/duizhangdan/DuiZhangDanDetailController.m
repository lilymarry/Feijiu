//
//  DuiZhangDanDetailController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/2/12.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "DuiZhangDanDetailController.h"
#import "AlertHelper.h"
#import "DuiZhangDanWebApi.h"
#import "DuiZhangDanDetailModel.h"
#import "DuiZhangDanDetailCell.h"
#import "DuiZhangDanDetailMainCell.h"
#import "UserPermission.h"
@interface DuiZhangDanDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UIButton *boHuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stateBtn;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DuiZhangDanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationItem setTitle:@"对账单详情"];
    dataArr=[NSMutableArray new];
    [self getData];
    
    [_stateBtn setTitle:_model.sh];
     NSLog(@"2Sss %@",_model.sh);
    if (![[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        _selectView.hidden=YES;
    }
    if ([_model.sh isEqualToString:@"已驳回"]) {
        [_boHuiBtn setBackgroundImage:[UIImage imageNamed:@"btn_queding3.png"] forState:UIControlStateNormal];
        [_boHuiBtn setEnabled:NO];
      
    }
    if ([_model.sh isEqualToString:@"已确认"]) {
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_queding3.png"] forState:UIControlStateNormal];
        [_sureBtn setEnabled:NO];
      
    }
}
-(void)getData
{
    [dataArr removeAllObjects];
    [dataArr addObject:_model];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [DuiZhangDanWebApi GetDuiZhangDanDetailWithdzdh:_model.dzdh  Success:^(NSArray *arr) {
        //          NSLog(@"1Sss %@",arr);
       
        [AlertHelper hideAllHUDsForView:self.view];
        
        for (NSDictionary *dict1 in arr) {
            DuiZhangDanDetailModel *model=[[DuiZhangDanDetailModel alloc]init];
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
    if (indexPath.row==0) {
        DuiZhangDanDetailMainCell*cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DuiZhangDanDetailMainCell" owner:self options:nil] lastObject];
        }
        DuizhangdanListModel*model=_model;
        cell.dzdh.text=model.dzdh;
        cell.gysdh.text=model.gysdh;
        cell.zje.text=model.zje;
        cell.xhf.text=model.xhf;
        cell.zjz.text=model.zjz;
        
        cell.gysjc.text=model.gysjc;
        cell.dh.text=model.dh;
        cell.qsrq.text=model.qsrq;
        cell.jzrq.text=model.jzrq;
        cell.dzrq.text=model.dzrq;
        cell.djr.text=model.djr;
        cell.spnr.text=model.spnr;
        
        cell.shr.text=model.shr;
        cell.xhf.text=model.xhf;
        
        cell.tjsj.text=model.tjsj;
        cell.zkz.text=model.zkz;
        cell.tjr.text=model.tjr;
        cell.shsj.text=model.shsj;
  
        return cell;
    }
    else
    {
    DuiZhangDanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DuiZhangDanDetailCell" owner:self options:nil] lastObject];
    }
    DuiZhangDanDetailModel *model=dataArr[indexPath.row];
    cell.rkdh.text=model.rkdh;
    cell.hwmc.text=model.hwmc;
    cell.cp.text=model.cp;
    cell.mz.text=model.mz;
    cell.mzsj.text=model.mzsj;
    
    cell.pz.text=model.pz;
    cell.pzsj.text=model.pzsj;
    cell.kl.text=model.kl;
    cell.kz.text=model.kz;
    cell.jsjz.text=model.jsjz;
    cell.dje.text=model.dje;
    
    
    cell.je.text=model.je;
    cell.xhf.text=model.xhf;
    cell.xhfdj.text=model.xhfdj;
    cell.bz.text=model.bz;
    cell.rkrq.text=model.rkrq;
    cell.dje.text=model.dje;
    
    cell.gys.text=model.gys;
    cell.shr.text=model.shr;
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
        // string = [date substringFromIndex:range.length+range.location];//截取范围类的字符串
        string = [date substringToIndex:range.location];//截取范围类的字符串
        
        return string;
    }
    else
    {
        return @"";
    }
    
    
}

-(void)refreshingDataList{
    // [self getData];
}
- (IBAction)reloadPress:(id)sender {
    [self getData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 229;
    }
    else
    {
    
    return 287;
    }
}

-(IBAction)surePress:(id)sender
{
    UIButton *but=(UIButton *)sender;
    if (but.tag==1000)
    {
        
        // NSLog(@"0");
        [self getfaBuDescribe1WithTag:@"0"];
    }
    else
        
    {
        
        // NSLog(@"1");
        [self getfaBuDescribe1WithTag:@"1"];
    }
    
    
}
-(void)getfaBuDescribe1WithTag:(NSString *)tagg
{
    NSString *beiZhu;
    if ([tagg isEqualToString:@"0"]) {
        beiZhu=@"您是否驳回该条信息";
    }
    else
    {
        beiZhu=@"您是否同意该条信息";
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
    
    
    
    if ([@"确定" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
        NSString *pingyuStr=@"";
        if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
            pingyuStr = [theAlert textFieldAtIndex:0].text;
        }
        
        if (theAlert.tag==0) {
            [self faBuPressWithState:@"0" andContent:pingyuStr];
            
        }
        
        else  {
            [self faBuPressWithState:@"1" andContent:pingyuStr];
            
            
        }
        
    }
    
}
- (void)faBuPressWithState:(NSString *)state andContent:(NSString *)content
{
    
    
    [AlertHelper singleMBHUDShow:@"提交中--" ForView:self.view];
    [DuiZhangDanWebApi checkupaccountWithdzdh:_model.dzdh state:state remark:content username:[UserPermission standartUserInfo].yhm Success:^(NSArray *userArr) {
        
        [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *userDic=userArr[0];
        if ([[userDic objectForKey:@"bool"]isEqualToString:@"1"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
          //  alert.tag=2000;
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


@end
