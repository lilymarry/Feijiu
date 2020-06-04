//
//  AddZhiJianViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/10.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "AddZhiJianViewController.h"
#import "ZhijianWebApi.h"
#import "AlertHelper.h"
#import  "SelectPIckView.h"
#import "UserPermission.h"
@interface AddZhiJianViewController ()<UIActionSheetDelegate,okButtonDelegate>
{
    
    SelectPIckView *select;
    NSMutableArray *data;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txf_zjsl;
@property (weak, nonatomic) IBOutlet UITextField *tf_kl;
@property (weak, nonatomic) IBOutlet UITextField *txf_dj;
@property (weak, nonatomic) IBOutlet UITextField *tf_price;

@property (weak, nonatomic) IBOutlet UILabel *lab_rkdh;

@property (weak, nonatomic) IBOutlet UILabel *lab_cph;
@property (weak, nonatomic) IBOutlet UILabel *lab_mz;
@property (weak, nonatomic) IBOutlet UILabel *lab_gys;
@property (weak, nonatomic) IBOutlet UILabel *lab_djsj;
@property (weak, nonatomic) IBOutlet UILabel *lab_shr;
//@property (weak, nonatomic) IBOutlet UILabel *lab_testman;


@property (weak, nonatomic) IBOutlet UILabel *lab_kl;



@end

@implementation AddZhiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
  //  NSLog(@"_____ %@",[UserPermission standartUserInfo].klz );
     self. automaticallyAdjustsScrollViewInsets=NO;
    data=[NSMutableArray array];
    _lab_rkdh.text=_model.rkdh;
    _lab_cph.text=_model.cph;
    _lab_mz.text=[NSString stringWithFormat:@"%@",_model.mz];
    _lab_gys.text=_model.gys;
    _lab_djsj.text=_model.djsj;
    _lab_shr.text=_model.shr;
    
    _txf_zjsl.text=@"1";
    
    if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
        _lab_kl.text=@"扣率%";
    }
    else{
        _lab_kl.text=@"扣重";
        
    }
    [_tf_kl becomeFirstResponder];
    //_lab_testman.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    
    
    [ZhijianWebApi getDengjiSuccess:^(NSArray *userArr) {
        
        NSArray *arr=     userArr[0][@"dj"];
        
      //  NSLog(@"WWW%@",userArr);
        if (arr.count>0) {
            for (int i=0; i<arr.count; i++)
            {   [data addObject:arr[i][@"name"]];
                
            }
            select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)WithMode:@"1"];
            select.state=1;
            select.delegate=self;
            _txf_dj.inputView=select;
            if (data.count>0) {
                  _txf_dj.text=data[0];
                  select.dataArr=data;
            }
            
        }
      
        
        
        
    } fail:^{
        
    }];
    
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    
    _txf_dj.text=row;
    [_txf_dj resignFirstResponder];
  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPress:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布" otherButtonTitles:nil, nil];
    sheet.delegate=self;
   
    
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
   
        if (buttonIndex==0)
        {
            
            [self faBuPress];
        }
    
        else
        {
            ;
        }
   
}
- (void)faBuPress
{
    
    [AlertHelper singleMBHUDShow:@"提交中--" ForView:self.view];
    [ZhijianWebApi addZhijianWithRkdh:_lab_rkdh.text zjsl:_txf_zjsl.text kl:_tf_kl.text dj:_txf_dj.text testman:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] price:_tf_price.text klz:[UserPermission standartUserInfo].klz  success:^(NSArray *userArr) {
         [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *userDic=userArr[0];
        if ([[userDic objectForKey:@"bool"]isEqualToString:@"1"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
          //  alert.tag=111;
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
  //  isEdit=NO;
    [self.view endEditing:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{  if (alertView.tag==111) {
   
      //  NSObject<CommonNotification> *tmpDele=self.refreshNotification;
       // [tmpDele refreshingDataList];
    
    
    [self.navigationController popViewControllerAnimated: YES];
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
