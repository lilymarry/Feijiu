//
//  SelectItemViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "SelectItemViewController.h"
#import "SelectPIckView.h"
#import "BaoBiaoWebApi.h"
#import "AlertHelper.h"

#import "UserPermission.h"
#import "HooDatePicker.h"
@interface SelectItemViewController ()<okButtonDelegate,HooDatePickerDelegate,UITextFieldDelegate>
{

    SelectPIckView *pickView;
    SelectPIckView *pickView1;
}
@property (strong, nonatomic)  UITextField *tf_hwmc;
@property (strong, nonatomic)  UITextField *tf_gys;

@property (strong, nonatomic)  UIButton *tf_st;
@property (strong, nonatomic)  UIButton *tf_et;

@property (nonatomic, strong) HooDatePicker *datePicker1;
@property (nonatomic, strong) HooDatePicker *datePicker2;
@end

@implementation SelectItemViewController
-(id)initWithBlock:(finishBlock)ablock
{
    if (self=[super init]) {
        
        
        _block=[ablock copy];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  NSLog(@"WW!!!!! %@",_state);
    
    UILabel *labb=[[UILabel alloc ] initWithFrame:CGRectMake(5, 95 ,80, 17)];
    labb.textColor = [UIColor darkGrayColor];
    labb.text=@"货 物 名称";
    labb.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:labb];
    
    
    
    _tf_hwmc=[[UITextField alloc]init];
    _tf_hwmc.frame=CGRectMake(CGRectGetMaxX(labb.frame)+2, 90, self.view.frame.size.width-100, 30);
    _tf_hwmc.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _tf_hwmc.layer.borderWidth=0.5;
    _tf_hwmc.placeholder=@"点此选择";
    _tf_hwmc.text=_hwmc;
 
    _tf_hwmc.delegate=self;
    _tf_hwmc.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_tf_hwmc];
    
    
    UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_hwmc.frame)+10 ,80, 17)];
    lab.textColor = [UIColor darkGrayColor];
    lab.text=@"供应商名称";
    lab.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
    
    
    
    _tf_gys=[[UITextField alloc]init];
    _tf_gys.frame=CGRectMake(CGRectGetMaxX(lab.frame)+2, CGRectGetMaxY(_tf_hwmc.frame)+5, CGRectGetWidth(_tf_hwmc.frame), 30);
    _tf_gys.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _tf_gys.layer.borderWidth=0.5;
    _tf_gys.placeholder=@"点此选择";
     _tf_gys.delegate=self;
    _tf_gys.font=[UIFont systemFontOfSize:14];
    _tf_gys.text=_gys;
  
    [self.view addSubview:_tf_gys];
    if ([_state isEqualToString:@"0"]) {
      if ([[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
          _tf_gys.enabled=NO;
          _tf_gys.layer.borderWidth=0;
         _tf_gys.text=[UserPermission standartUserInfo].gysjc;
       }
     }
    
    
  
    //曲线图表
    if (![_state isEqualToString:@"0"])
    {
        

    
    UILabel *abb=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_gys.frame)+10 ,80, 17)];
    abb.textColor = [UIColor darkGrayColor];
    abb.text=@"起止时间";
    abb.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:abb];
    
    
    
    _tf_st=[UIButton buttonWithType:UIButtonTypeCustom];
    _tf_st.frame=CGRectMake(CGRectGetMaxX(abb.frame)+2, CGRectGetMaxY(_tf_gys.frame)+10, self.view.frame.size.width-100, 30);
    [_tf_st setImage:[UIImage imageNamed:@"输入款.png"] forState:UIControlStateNormal];
        _tf_st.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _tf_st.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);//文字距离做边框保持10个像素的距离。
        [_tf_st setTitle:_st forState:UIControlStateNormal];
       // _tf_st.layer.cornerRadius = 10.0;//2.0是圆角的弧度，根据需求自己更改
        _tf_st.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
        _tf_st.layer.borderWidth = 1.0f;
        
        [_tf_st setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_tf_st addTarget:self action:@selector(selectStime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tf_st];
    
    
    UILabel *ab=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_st.frame)+10 ,80, 17)];
    ab.textColor = [UIColor darkGrayColor];
    ab.text=@"终止时间";
    ab.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:ab];
    
    
    
    _tf_et=[UIButton buttonWithType:UIButtonTypeCustom];
    _tf_et.frame=CGRectMake(CGRectGetMaxX(ab.frame)+2, CGRectGetMaxY(_tf_st.frame)+5, CGRectGetWidth(_tf_hwmc.frame), 30);
        _tf_et.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _tf_et.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);//文字距离做边框保持10个像素的距离。
        _tf_et.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
        _tf_et.layer.borderWidth = 1.0f;
              [_tf_et setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_tf_et setImage:[UIImage imageNamed:@"输入款.png"] forState:UIControlStateNormal];
          [_tf_et addTarget:self action:@selector(selectEtime) forControlEvents:UIControlEventTouchUpInside];
    [_tf_et setTitle:_et forState:UIControlStateNormal];
    [self.view addSubview:_tf_et];
        

        self.datePicker1 = [[HooDatePicker alloc] initWithSuperView:self.view];
        self.datePicker1.delegate = self;
        self.datePicker1.flag=@"1";
        if ([_state isEqualToString:@"1"]||[_state isEqualToString:@"3"]) {
             self.datePicker1.datePickerMode = HooDatePickerModeDate;
            
        }
        else
        {
             self.datePicker1.datePickerMode = HooDatePickerModeYearAndMonth;
        }
        NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
        [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
        NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
        NSDate *minDate = [dateFormatter dateFromString:@"2016-01-01"];
        [ self.datePicker1 setDate:[NSDate date] animated:YES];
          self.datePicker1.minimumDate = minDate;
          self.datePicker1.maximumDate = maxDate;
        
        self.datePicker2 = [[HooDatePicker alloc] initWithSuperView:self.view];
        self.datePicker2.delegate = self;
        self.datePicker2.flag=@"2";
        if ([_state isEqualToString:@"1"]||[_state isEqualToString:@"3"]) {
            self.datePicker2.datePickerMode = HooDatePickerModeDate;
            
        }
        else
        {
            self.datePicker2.datePickerMode = HooDatePickerModeYearAndMonth;
        }
        NSDateFormatter *dateFormatter1 = [NSDate shareDateFormatter];
        [dateFormatter1 setDateFormat:kDateFormatYYYYMMDD];
        NSDate *maxDate1 = [dateFormatter1 dateFromString:@"2050-01-01"];
        NSDate *minDate1 = [dateFormatter1 dateFromString:@"2016-01-01"];
        [ self.datePicker2 setDate:[NSDate date] animated:YES];
        self.datePicker2.minimumDate = minDate1;
        self.datePicker2.maximumDate = maxDate1;
       
        
    }

    
   UIButton * bt_selectPerson=[UIButton buttonWithType:UIButtonTypeCustom];
    if ([_state isEqualToString:@"0"]) {
      
           bt_selectPerson.frame=CGRectMake(90, CGRectGetMaxY (_tf_gys.frame)+20,self.view.frame.size.width-180, 39);
    }
    else
    {
            bt_selectPerson.frame=CGRectMake(90, CGRectGetMaxY (_tf_et.frame)+20,self.view.frame.size.width-180, 39);
        
    }
  
    [bt_selectPerson setTitle:@"确定" forState:UIControlStateNormal];
    [bt_selectPerson addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
    [bt_selectPerson setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
    bt_selectPerson.titleLabel .font =[UIFont systemFontOfSize:12];
    [self.view addSubview:bt_selectPerson];
    
    
    
    
    pickView=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view. frame.size.width, 166)WithMode:@"1"];
    pickView.state=0;
    pickView.delegate=self;
    _tf_hwmc.inputView=pickView;
    
    pickView1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.view.frame.size.width, 166) WithMode:@"1"];
    pickView1.state=1;
    pickView1.delegate=self;
    _tf_gys.inputView=pickView1;
    

    
     [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData
{
  
    
    
    [BaoBiaoWebApi GetNewsWithSuccess:^(NSArray *arr) {
        @try {
            
            NSMutableArray *hw=[NSMutableArray arrayWithCapacity:10];
            NSMutableArray *hz=[NSMutableArray arrayWithCapacity:10];
            for (int i=0; i<[arr[0][@"lhwmc"]count]; i++)
            {
                [hw addObject:arr[0][@"lhwmc"][i][@"hwmc"] ];
            }
            
            pickView.dataArr=hw;
            for (int i=0; i<[arr[0][@"lgysmc"]count]; i++)
            {
                [hz addObject:arr[0][@"lgysmc"][i][@"gysmc"]];
            }
            pickView1.dataArr=hz;
 
        }
        @catch (NSException *exception) {
            [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
    } fail:^{
        
    }];
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        _tf_hwmc.text=row;
        
        [_tf_hwmc resignFirstResponder];
    }
    else
    {
        _tf_gys.text=row;
        [_tf_gys resignFirstResponder];
        
    }
}
-(void)doCancellWithState:(int)state
{
//    if (state==0)
//    {
//        _tf_hwmc.text=@"";
//        
//        [_tf_hwmc resignFirstResponder];
//    }
//    else
//    {
//        _tf_gys.text=@"";
//        [_tf_gys resignFirstResponder];
//        
//    }
}
- (void)surePress:(id)sender {
    if (_block)
    {
        NSString *st=_tf_st.titleLabel.text;
        NSString *et=_tf_et.titleLabel.text;
        NSString *gys=_tf_gys.text;
        NSString *hw=_tf_hwmc.text;
        if ([_tf_hwmc.text isEqualToString:@"全部"]) {
            hw=@"";
        }
        if ([_tf_gys.text isEqualToString:@"全部"]) {
            gys=@"";
        }
        if ([_state isEqualToString:@"0"]) {
            
            if (_tf_st.titleLabel.text.length==0) {
                st=@"";
                
            }
            if (_tf_et.titleLabel.text.length==0) {
                et=@"";
            }
            
            _block(hw,gys,st,et);
            [self.navigationController popViewControllerAnimated:YES];
            
           
            
        }
        else
        {
            if (_tf_st.titleLabel.text.length==0) {
                [AlertHelper singleMBHUDShow:@"选择起始时间！" ForView:self.view AndDelayHid:2];
            }
            else if (_tf_et.titleLabel.text.length==0) {
                [AlertHelper singleMBHUDShow:@"选择终止时间！" ForView:self.view AndDelayHid:2];
            }
            else
            {
                _block(hw,gys,st,et);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
      
    }
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
     [self.datePicker1 dismiss];
    [self.datePicker2 dismiss];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
  
    
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date WithFlag:(NSString *)flag {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    
    NSString *value = [dateFormatter stringFromDate:date];
  
    if ([flag isEqualToString:@"1"]) {
         [_tf_st setTitle:value forState:UIControlStateNormal];
    }
    else
    {
        [_tf_et setTitle:value forState:UIControlStateNormal];
    }
    
    
}
-(void)selectStime
{
     [self.view endEditing:YES];
    [self.datePicker1 show];
    
}
-(void)selectEtime
{
     [self.view endEditing:YES];
     [self.datePicker2 show];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.datePicker1 dismiss];
    [self.datePicker2 dismiss];
    
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
