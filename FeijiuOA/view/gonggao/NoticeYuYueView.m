//
//  NoticeYuYueView.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/10.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//
#import "SelectPIckView.h"
#import "ChooseDateView.h"
#import "NoticeYuYueView.h"
#import "NoticeWebApi.h"
#import "BaoBiaoWebApi.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import "NoticeSubModel.h"
#import "URL.h"
@interface NoticeYuYueView

()<okButtonDelegate,dateChooseDelegate>
{
    SelectPIckView *lvpickView;
    SelectPIckView *pickView1;
    
    
    ChooseDateView *date1;
    ChooseDateView *date2;
    
    
}
@property (strong, nonatomic)  UITextField *tf_hwmc;
@property (strong, nonatomic)  UILabel *tf_gys;

@property (strong, nonatomic)  UITextField *tf_stime;
@property (strong, nonatomic)  UITextField *tf_lv;

@property (strong, nonatomic)  UITextField *tf_weight;
@property (strong, nonatomic)  UITextField *tf_checi;
@end
@implementation NoticeYuYueView

- (id)initWithFrame:(CGRect)frame andMode:( BOOL) pilaing
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(5, 10 ,80, 17)];
        lab.textColor = [UIColor darkGrayColor];
        lab.text=@"供   应    商";
        lab.font=[UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        _tf_gys=[[UILabel alloc]init];
        _tf_gys.frame=CGRectMake(CGRectGetMaxX(lab.frame)+2, 5,  self.frame.size.width-100, 30);
        _tf_gys.text=[UserPermission standartUserInfo].gysjc;
        [self addSubview:_tf_gys];
        
        
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *date=[format stringFromDate:[NSDate date]];
        NSString *stitle=[NSString stringWithFormat:@"%@",date];
        
        
        UILabel *abb=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_gys.frame)+10 ,80, 17)];
        abb.textColor = [UIColor darkGrayColor];
        abb.text=@"送 货  日 期";
        abb.font=[UIFont systemFontOfSize:14];
        [self addSubview:abb];
        
        
        
        _tf_stime=[[UITextField alloc]init];
        _tf_stime.frame=CGRectMake(CGRectGetMaxX(abb.frame)+2, CGRectGetMaxY(_tf_gys.frame)+10, CGRectGetWidth(_tf_gys.frame), 30);
        _tf_stime.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _tf_stime.layer.borderWidth=0.5;
        _tf_stime.placeholder=@"点此选择";
        _tf_stime.text=stitle;
        _tf_stime.font=[UIFont systemFontOfSize:14];
        [self addSubview:_tf_stime];
        
        
        
        UILabel *labb=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_stime.frame)+10 ,80, 17)];
        labb.textColor = [UIColor darkGrayColor];
        labb.text=@"货 物  名 称";
        
        labb.font=[UIFont systemFontOfSize:14];
        [self addSubview:labb];
        
        
        
        _tf_hwmc=[[UITextField alloc]init];
        _tf_hwmc.frame=CGRectMake(CGRectGetMaxX(labb.frame)+2, CGRectGetMaxY(_tf_stime.frame)+5, CGRectGetWidth(_tf_gys.frame), 30);
        _tf_hwmc.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _tf_hwmc.layer.borderWidth=0.5;
        _tf_hwmc.placeholder=@"点此选择";
        _tf_hwmc.font=[UIFont systemFontOfSize:14];
        [self addSubview:_tf_hwmc];
        
        UILabel *ab=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_hwmc.frame)+10 ,80, 17)];
        ab.textColor = [UIColor darkGrayColor];
        ab.text=@"等           级";
        ab.font=[UIFont systemFontOfSize:14];
        [self addSubview:ab];
        
        
        
        _tf_lv=[[UITextField alloc]init];
        _tf_lv.frame=CGRectMake(CGRectGetMaxX(ab.frame)+2, CGRectGetMaxY(_tf_hwmc. frame)+5, CGRectGetWidth(_tf_gys.frame), 30);
        _tf_lv.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _tf_lv.layer.borderWidth=0.5;
        _tf_lv.placeholder=@"点此选择";
        _tf_lv.font=[UIFont systemFontOfSize:14];
        [self addSubview:_tf_lv];
        
        
        
        UILabel *weig=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_lv.frame)+10 ,80, 17)];
        weig.textColor = [UIColor darkGrayColor];
        weig.text=@"重       量(t)";
        weig.font=[UIFont systemFontOfSize:14];
        [self addSubview:weig];
        
        
        
        _tf_weight=[[UITextField alloc]init];
        _tf_weight.frame=CGRectMake(CGRectGetMaxX(labb.frame)+2, CGRectGetMaxY(_tf_lv.frame)+5, CGRectGetWidth(_tf_gys.frame), 30);
        _tf_weight.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _tf_weight.layer.borderWidth=0.5;
        _tf_weight.placeholder=@"点此选择";
        [_tf_weight setKeyboardType:UIKeyboardTypeDecimalPad];
        _tf_weight.font=[UIFont systemFontOfSize:14];
        [self addSubview:_tf_weight];
        
        
        UILabel *weigh=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY(_tf_weight.frame)+10 ,80, 17)];
        weigh.textColor = [UIColor darkGrayColor];
        weigh.text=@"车次(大于1)";
        weigh.font=[UIFont systemFontOfSize:14];
        [self addSubview:weigh];
        
        
        
        _tf_checi=[[UITextField alloc]init];
        _tf_checi.frame=CGRectMake(CGRectGetMaxX(ab.frame)+2, CGRectGetMaxY(_tf_weight. frame)+5, CGRectGetWidth(_tf_gys.frame), 30);
        [_tf_checi setKeyboardType:UIKeyboardTypeDecimalPad]; _tf_checi.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _tf_checi.layer.borderWidth=0.5;
        _tf_checi.text=@"1";
        _tf_checi.placeholder=@"点此选择";
        _tf_checi.font=[UIFont systemFontOfSize:14];
        [self addSubview:_tf_checi];
        
        
        UILabel *weigh1=[[UILabel alloc ] initWithFrame:CGRectMake(0,  CGRectGetMaxY(_tf_checi. frame)+40 ,self.frame.size.width, 2)];
        weigh1.backgroundColor = [UIColor redColor];
        [self addSubview:weigh1];
        
        
        UILabel *weigh2=[[UILabel alloc ] initWithFrame:CGRectMake((self.frame.size.width)/2, CGRectGetMaxY(_tf_checi. frame)+40 ,2,45)];
        weigh2.backgroundColor = [UIColor redColor];
        [self addSubview:weigh2];
        
        
        UIButton * bt_selectPerson=[UIButton buttonWithType:UIButtonTypeCustom];
        
        bt_selectPerson.frame=CGRectMake(CGRectGetMaxX (weigh2.frame), CGRectGetMaxY (_tf_checi.frame)+45,self.frame.size.width/2, 39);
        
        
        
        [bt_selectPerson setTitle:@"确定" forState:UIControlStateNormal];
        [bt_selectPerson addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        //  [bt_selectPerson setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        [bt_selectPerson setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        bt_selectPerson.titleLabel .font =[UIFont systemFontOfSize:17];
        [self addSubview:bt_selectPerson];
        
        
        UIButton * bt_selectPerson1=[UIButton buttonWithType:UIButtonTypeCustom];
        
        bt_selectPerson1.frame=CGRectMake(0, CGRectGetMaxY (_tf_checi.frame)+45,self.frame.size.width/2, 39);
        
        
        
        [bt_selectPerson1 setTitle:@"取消" forState:UIControlStateNormal];
        [bt_selectPerson1 addTarget:self action:@selector(canllePress:) forControlEvents:UIControlEventTouchUpInside];
        //  [bt_selectPerson setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        [bt_selectPerson1 setTitleColor:[UIColor  darkGrayColor] forState:UIControlStateNormal];
        bt_selectPerson1.titleLabel .font =[UIFont systemFontOfSize:17];
        [self addSubview:bt_selectPerson1];
        
        date1 = [ChooseDateView instanceChooseDateView];
        date1.chooseDateDelegate=self;
        date1.dateId=@"1";
        _tf_stime.inputView=date1;
        
        
        
        
        
        lvpickView=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,    self.frame.size.width, 166)WithMode:@"1"];
        lvpickView.state=0;
        lvpickView.delegate=self;
        _tf_lv.inputView=lvpickView;
        
        
        
        
        pickView1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.frame.size.width, 166) WithMode:@"1"];
        pickView1.state=1;
        pickView1.delegate=self;
        _tf_hwmc.inputView=pickView1;
        
        
        [self getData];
        
        
    }
    return self;
    
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        _tf_lv.text=row;
        
        [_tf_lv resignFirstResponder];
    }
    else
    {
        _tf_hwmc.text=row;
        [_tf_hwmc resignFirstResponder];
        
    }
}
-(void)doCancellWithState:(int)state
{
    
}
- (void)surePress:(id)sender {
    if (_tf_weight.text.length==0) {
        [AlertHelper singleMBHUDShow:@"输入重量！" ForView:self.superview AndDelayHid:2];
    }else if (_tf_checi.text.length==0) {  [AlertHelper singleMBHUDShow:@"输入车次！" ForView:self.superview AndDelayHid:2];}
    //    else if (_tf_lv.text.length==0) {  [AlertHelper singleMBHUDShow:@"输入等级！" ForView:self.superview AndDelayHid:2];}
    
    else
    {
        NSDictionary * param = @{@"method":@"inbookingdelivery",@"PriceNoticesid":_mainModel.sid,@"suppliername":_tf_gys.text,@"date":_tf_stime.text,@"goodsname":_tf_hwmc.text,@"degree":_tf_lv.text,@"weight":_tf_weight.text,@"cc":_tf_checi.text,@"zdid":zdid};
        
        if ([self.dDelegate respondsToSelector:@selector(selectSheHeWithDic:)])
        {
            [self.dDelegate selectSheHeWithDic:param];
            
        }
        
    }
}
- (void)canllePress:(id)sender {
    if ([self.dDelegate respondsToSelector:@selector(selectCancell)])
    {
        [self.dDelegate selectCancell];
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid
{
    _tf_stime.text= dateStr;
    
    [_tf_stime resignFirstResponder];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self endEditing:YES];
}
-(void)getData
{
    [NoticeWebApi GethwmcdtWithSuccess:^(NSArray *arr) {
        NSMutableArray *hw=[NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<[arr count]; i++)
        {
            [hw addObject:arr[i][@"hwmc"] ];
        }
        
        
        if (hw.count>0) {
            pickView1.dataArr=hw;
            
            _tf_hwmc.text=hw[0];
        }
    } fail:^{
        
    }];
    
    
}
-(void)refresh
{
    NSMutableArray *arr=  [NSMutableArray array];
    for (int i=0; i<_mainModel .subLists.count; i++)
    {
        NoticeSubModel *model=_mainModel .subLists[i];
        [arr addObject:model. dj];
    }
    if (arr.count>0) {
        lvpickView.dataArr=arr;
        _tf_lv.text=arr[0];
        [lvpickView reloaPickView];
    }
}
@end
