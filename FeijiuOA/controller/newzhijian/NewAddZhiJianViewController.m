//
//  NewAddZhiJianViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/16.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NewAddZhiJianViewController.h"
#import "ZhijianWebApi.h"
#import "AlertHelper.h"
#import  "SelectPIckView.h"
#import "UserPermission.h"
@interface NewAddZhiJianViewController ()
<UIAlertViewDelegate,okButtonDelegate>
{
    
    SelectPIckView *select;
    NSMutableArray *data;
    
    BOOL isEdit;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txf_zjsl;
@property (weak, nonatomic) IBOutlet UITextField *tf_kl;
@property (weak, nonatomic) IBOutlet UITextField *txf_dj;
@property (weak, nonatomic) IBOutlet UITextField *tf_price;
@property (weak, nonatomic) IBOutlet UITextField *tf_beizhu;


@property (weak, nonatomic) IBOutlet UILabel *lab_rkdh;

@property (weak, nonatomic) IBOutlet UILabel *lab_cph;
@property (weak, nonatomic) IBOutlet UILabel *lab_mz;
@property (weak, nonatomic) IBOutlet UILabel *lab_gys;
@property (weak, nonatomic) IBOutlet UILabel *lab_djsj;
@property (weak, nonatomic) IBOutlet UILabel *lab_shr;
//@property (weak, nonatomic) IBOutlet UILabel *lab_testman;


@property (weak, nonatomic) IBOutlet UILabel *lab_kl;

@end

@implementation NewAddZhiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self. automaticallyAdjustsScrollViewInsets=NO;
    data=[NSMutableArray array];
    
    [ZhijianWebApi getDengjiSuccess:^(NSArray *userArr) {
        
        @try {
            NSArray *arr=     userArr[0][@"dj"];
            if (arr.count>0) {
                for (int i=0; i<arr.count; i++)
                {   [data addObject:arr[i][@"name"]];
                    
                }
                
                if (data.count>0) {
                    _txf_dj.text=data[0];
                    select.dataArr=data;
                }
                
            }   }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } fail:^{
        
    }];
    
    
   
    _lab_rkdh.text=_model.rkdh;
    _lab_cph.text=_model.cph;
    _lab_mz.text=[NSString stringWithFormat:@"%@",_model.mz];
    _lab_gys.text=_model.gys;
    _lab_djsj.text=_model.djsj;
    _lab_shr.text=_model.shr;
    _txf_zjsl.text=@"1";
    
    if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
        _lab_kl.text=@"扣        率%:";
    }
    else{
        _lab_kl.text=@"扣         重:";
        
    }
    
    select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)WithMode:@"1"];
    select.state=1;
    select.delegate=self;
    _txf_dj.inputView=select;


    

    NSString *gys;
    if ([[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        gys=[UserPermission standartUserInfo].gysjc;
    }
    else
    {
        gys=@"";
        
    }
     isEdit=YES;
     [_tf_kl becomeFirstResponder];
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    
    _txf_dj.text=row;
     isEdit=NO;
    [_txf_dj resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPress:(id) sender {
    isEdit=NO;
    [self.view endEditing:YES];
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                       message:@"您是否确定提交该条质检信息"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.tag=1000;
    [theAlert show];
    
    
}
- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (theAlert.tag==1000) {
        if (buttonIndex==1) {
            
            [self faBuPress];
            
        }
    }
    else
    {
        NSObject<CommonNotification> *tmpDele=self.refreshNotification;
         [tmpDele refreshingDataList];
        [self.navigationController popViewControllerAnimated: YES];
    }
    
}


- (void)faBuPress
{
    NSString *kl;
    NSString *klStr;
     NSString *kzStr;
    if ([[UserPermission standartUserInfo].klz isEqualToString:@"1"]) {
        kl=@"1";
        klStr=_tf_kl.text;//扣率
        kzStr=@"0";
    }
    else{
        kl=@"0";
        klStr=@"0";
        kzStr=_tf_kl.text;
        
        
    }
    [AlertHelper singleMBHUDShow:@"提交中--" ForView:self.view];
    [ZhijianWebApi insertGoodsinpriceconfigTypeDeduct:kl InCode:_lab_rkdh.text Supplier:_lab_gys.text GoodsName:_model.hwmc Degree:_txf_dj.text WeightDeductRate:klStr WeightDuduct:kzStr Remark:_tf_beizhu.text TestMan:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] CoID:[UserPermission  standartUserInfo].yhdh price:_tf_price.text zjsl:_txf_zjsl.text success:^(NSArray *userArr) {
        
        [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *userDic=userArr[0];
        if ([[userDic objectForKey:@"bool"]isEqualToString:@"1"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
              alert.tag=1001;
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    if (!isEdit)
    {
        frame.origin.y-= window.frame.size.height==568?130:158;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
    isEdit=YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    if (!isEdit) {
        frame.origin.y=0;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isEdit=NO;
    [self.view endEditing:YES];
}

@end
