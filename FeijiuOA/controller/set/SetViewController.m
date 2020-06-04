//
//  SetViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/25.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "SetViewController.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
@interface SetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_version;
@property (weak, nonatomic) IBOutlet UILabel *lab_yue;
@property (weak, nonatomic) IBOutlet UILabel *lab_tian;

@property (weak, nonatomic) IBOutlet UILabel *lab_company;


@end

@implementation SetViewController
- (IBAction)setPress:(id)sender {
    [[NSUserDefaults standardUserDefaults ]setObject:_tf_time.text forKey:@"time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
      [AlertHelper singleAlertShowAndMBHUDHid:@"保存成功" ForView:self.view];
    
}
- (void)setYuePress:(id)sender {
    
    
    
}
- (void)setTianPress:(id)sender {
    
    
}
-(IBAction)surePress:(id)sender
{
    UIButton *but=(UIButton *)sender;
    if (but.tag==1000)
    {
        
        // NSLog(@"0");
        [self setDateWithTag:@"0"];
    }
    else
        
    {
        
        // NSLog(@"1");
        [self setDateWithTag:@"1"];
    }
    //    else
    //    {
    //        NewAddZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewAddZhiJian"];
    //        tab.model=_model;
    //        [self.navigationController pushViewController:tab animated:YES];
    //
    //    }
    
}

-(void)setDateWithTag:(NSString *)tagg
{
    NSString *beiZhu;
    if ([tagg isEqualToString:@"0"]) {
        beiZhu=@"设置报表默认月数";
    }
    else
    {
        beiZhu=@"设置报表默认天数";
    }
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: beiZhu
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    UITextField * text1 = [theAlert textFieldAtIndex:0];
   [text1 setKeyboardType:UIKeyboardTypeNumberPad];
    text1.placeholder=@"点此输入";
    theAlert.tag=[tagg intValue];
    [theAlert show];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *pingyuStr=@"";
    if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
        pingyuStr = [theAlert textFieldAtIndex:0].text;
       
        if (pingyuStr.length==0) {
             [AlertHelper singleMBHUDShow:@"不能为空" ForView:self.view AndDelayHid:1];
        }
        else
        {
            if ([@"确定" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
                
                if (theAlert.tag==0) {
                    
                    [self saveDataWithState:@"0" andContent:pingyuStr];
                    
                }
                
                else  {
                    [self saveDataWithState:@"1" andContent:pingyuStr];
                    
                    
                }
                
            }
            
        }
        
    }
    
   
    
}

-(void)saveDataWithState:(NSString *)state andContent:(NSString *)content{
    if ([state isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults ]setObject:content forKey:@"month"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [AlertHelper singleMBHUDShow:@"保存成功" ForView:self.view AndDelayHid:1];
        _lab_yue.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"month"];
       
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults ]setObject:content forKey:@"day"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [AlertHelper singleMBHUDShow:@"保存成功" ForView:self.view AndDelayHid:1];
         _lab_tian.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"day"];
        
    }
    
    
}
- (IBAction)setCompany:(id)sender {
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Company" bundle:[NSBundle mainBundle]];
    UIViewController *changyongController = [s instantiateViewControllerWithIdentifier:@"Company"];
    
    [self presentViewController:changyongController animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lab_version.text =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    
//    date1 = [ChooseDateView instanceChooseDateView];
//    date1.chooseDateDelegate=self;
//    date1.dateId=@"1";
//    _tf_time.inputView=date1;
    
     _lab_yue.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"month"];
     _lab_tian.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"day"];
    
 //   _lab_company.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"stationname"];
    
    
//    if (_tf_time.text.length==0) {
//        NSDate *date=[NSDate date];
//        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
//        _tf_time.text= [self convertStringToDate:[dateFormatter1 stringFromDate:date] Withformat:@"yyyy-MM-dd"];
//
//    }
  

}
-(void)viewWillAppear:(BOOL)animated
{
       _lab_company.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"stationname"];
    
}
//- (NSString *)convertStringToDate:(NSString *)string Withformat:(NSString *)fromat  {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:fromat];
//    NSDate *currentDate = [dateFormatter dateFromString:string];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
//    //1表示1年后的时间 year = -1为1年前的日期，month day 类推
//
//    [lastMonthComps setMonth:-6];
//
//    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
//    NSString *str=[dateFormatter stringFromDate:newdate];
//    return str;
//}
//-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid
//{
//    _tf_time.text= dateStr;
//
//    [_tf_time resignFirstResponder];
//
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//    [self.view endEditing:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
