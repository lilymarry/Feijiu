//
//  SupplierWeightViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/21.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "CK_SupplierWeightViewController.h"
#import "Baobiao_ckWebApi.h"
#import "CK_SupplierWeightCell.h"
#import "CK_SupplierWeightView.h"
#import "CK_SupplierWeightModel.h"
#import "AlertHelper.h"
#import "CK_SelectItemViewController.h"
#import "AppDelegate.h"
#import "URL.h"
#import "UserPermission.h"
#define tittleWidth 480
@interface CK_SupplierWeightViewController ()
<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    CK_SupplierWeightView *view2;
    NSString *hwmcc;
    NSString *zdmcc;
    NSString *khjcc;
     int indexy;
}


@property (strong, nonatomic)  UIButton *btn_time;
//@property (weak, nonatomic) IBOutlet UILabel *lab_zgys;
//@property (weak, nonatomic) IBOutlet UILabel *lab_hwgs;
//@property (weak, nonatomic) IBOutlet UILabel *lab_zje;
@property (strong, nonatomic)  UILabel *titleLab;
@property (strong, nonatomic)  UIButton *stBtn;
@property (strong, nonatomic)  UIButton *etBtn;

@property (weak, nonatomic) IBOutlet UILabel *lab_tittle;

@end

@implementation CK_SupplierWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:YES];//调用转屏代码
    
    [self setNavigationView];
    
    if(kDevice_Is_iPhoneX)
    {
        indexy=46;
    }
    else
    {
        indexy=0;
    }
    
    
    if ([self.flag isEqualToString:@"0"]) {
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        [_btn_time setTitle:[dateFormatter1 stringFromDate:date] forState:UIControlStateNormal];
        
        
        
    }
    else
    {
        
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM"];
        [_btn_time setTitle:[dateFormatter1 stringFromDate:date] forState:UIControlStateNormal];
     
        
    }
    hwmcc=@"";
    khjcc=@"";
    zdmcc=@"";
    
    dataArr =[NSMutableArray array];
    view2 = [[CK_SupplierWeightView alloc]instanceChooseView];
   [view2 setFrame:CGRectMake(indexy, scrollViewWidth, tittleWidth,50)];
    [self.view addSubview:view2];
    
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,scrollViewWidth, self.view.frame.size.height,self.view.frame.size.width-scrollViewWidth)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.width-scrollViewWidth);
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, tittleWidth, CGRectGetHeight(rightScrollView.frame)-50)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    [rightScrollView addSubview:rightTableView];
    
   
    if ([self.flag isEqualToString:@"0"]) {
         _titleLab.text=@"每日重量统计";
    }
    else
    {
         _titleLab.text=@"每月重量统计";
    }
    [self getDataWithTime:_btn_time.titleLabel.text];
}

-(void)getDataWithTime:(NSString *)time
{
    NSString *method=@"supplierdailyflow";
    if ([self.flag isEqualToString:@"0"]) {
        
        method=@"supplierdailyweightstatistics";
    }
    else
    {
        method=@"suppliermonthlyweightstatistics";
        
    }
    [dataArr removeAllObjects];
    _lab_tittle.text=@"客户总个数:0 货物个数:0 总重量:0";
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [Baobiao_ckWebApi ck_supplierweightstatisticsWithDate:time kh:khjcc hwmc:hwmcc  method:method Success:^(NSArray *arr) {
        [AlertHelper hideAllHUDsForView:self.view];
      //  NSLog(@"SSSS %@",arr);
        @try {
            
            for (NSDictionary *dict in arr[0][@"lls"]) {
                CK_SupplierWeightModel *model=[[CK_SupplierWeightModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [dataArr addObject:model];
            }
            
            
            NSArray *data=arr[0][@"tj"];
            if (data.count>0) {
                NSDictionary *dic=arr[0][@"tj"][0];
                
                NSMutableString *str=[NSMutableString string];
                [str appendFormat:@"客户总个数:%@ 货物个数:%@ 总重量:%@ ",dic[@"zkh"],dic[@"hwgs"],dic[@"zzl"]];
                _lab_tittle.text=str;
                
            }
            
            
            
            [rightTableView reloadData];
            
        }
        @catch (NSException *exception) {
            [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectItemPress:(id)sender {

    CK_SelectItemViewController *changyongController=  [ [CK_SelectItemViewController alloc] initWithBlock:^(NSString *hwmc,NSString *zdmc,NSString *khjc,NSString *st ,NSString *et )
                                                        {
                                                            hwmcc=hwmc;
                                                            zdmcc=zdmc;
                                                            khjcc=khjc;
                                                            [self getDataWithTime:_btn_time.titleLabel.text];
                                                        }];
    changyongController.state=@"0";
    changyongController.st=@"";
    changyongController.et=@"";
    changyongController.hwmc=hwmcc;
    changyongController.zdmc=zdmcc;
    changyongController.khjc=khjcc;
    [self.navigationController pushViewController:changyongController animated:YES];
}

- (void)back

{
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    
    [self setNewOrientation:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)setNavigationView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(100, 0,self.view.frame.size.height-200, 30)];
    self.navigationItem.titleView=view;
    
    _titleLab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 0,100, 30)];
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font=[UIFont systemFontOfSize:14];
    [view addSubview:_titleLab];
    
    
    _stBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _stBtn. frame=CGRectMake(CGRectGetMaxX (_titleLab.frame)+9, 0,43, 30);
    [_stBtn setImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal];
    [_stBtn addTarget:self action:@selector(timePress:) forControlEvents:UIControlEventTouchUpInside];
    _stBtn.tag=1000;
    _stBtn.titleLabel .font =[UIFont systemFontOfSize:12];
    [view addSubview:_stBtn];
    
    _btn_time=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn_time. frame=CGRectMake(CGRectGetMaxX (_stBtn.frame)+9,0,80, 30);
    // [_btn_time addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
    //  _btn_time.tag=1000;
    [_btn_time setTitle:@"2014-01-01" forState:UIControlStateNormal];
    _btn_time.titleLabel .font =[UIFont systemFontOfSize:12];
    [view addSubview:_btn_time];
    
    _etBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _etBtn. frame=CGRectMake(CGRectGetMaxX (_btn_time.frame)+9,0,43, 30);
    [_etBtn setImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal];
    [_etBtn addTarget:self action:@selector(timePress:) forControlEvents:UIControlEventTouchUpInside];
    _etBtn.tag=1001;
    _etBtn.titleLabel .font =[UIFont systemFontOfSize:12];
    [view addSubview:_etBtn];
}


- (void)timePress:(id)sender {
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([self.flag isEqualToString:@"0"]) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:_btn_time.titleLabel.text];
        NSDate *lastDay;
        if (but.tag==1000) {//时区问题 +8
            lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
            
        }
        else
        {
            lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
        }
        
        [_btn_time setTitle:[dateFormatter stringFromDate:lastDay] forState:UIControlStateNormal];
         [self getDataWithTime:[dateFormatter stringFromDate:lastDay]];
    }
    else
    {
        
        
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSDate *currentDate = [dateFormatter dateFromString:_btn_time.titleLabel.text];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
        //1表示1年后的时间 year = -1为1年前的日期，month day 类推
        if (but.tag==1000) {
            [lastMonthComps setMonth:-1];
        }
        else{
            
            [lastMonthComps setMonth:1];
        }
        
        NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
        [_btn_time setTitle:[dateFormatter stringFromDate:newdate] forState:UIControlStateNormal];
         [self getDataWithTime:[dateFormatter stringFromDate:newdate]];
        
    }
    
 //   [self getData];
    
}

#pragma mark ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新布下局
    view2.frame = CGRectMake(indexy, scrollViewWidth, tittleWidth, 50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, tittleWidth, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [rightTableView reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.0];
    view2.frame = CGRectMake(indexy,scrollViewWidth, tittleWidth,50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, tittleWidth, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [UIView commitAnimations];
    
    
}
//防止滑动过程中锁定方向不让滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate)
        [self scrollViewDidEndDecelerating:scrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return dataArr.count;
   // return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identfier=@"cell";
    CK_SupplierWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CK_SupplierWeightCell" owner:self options:nil] lastObject];
        
    }
    CK_SupplierWeightModel *model=[dataArr objectAtIndex:indexPath.row];
    cell.hwmc.text=model.hwmc;
    cell.zl.text=model.zl;
    cell.kh.text=model.kh;
    cell.shrq.text=model.shrq;
//    cell.hwmc.text=@"1";
//  //  cell.je.text=@"2";
//    cell.kh.text=@"3";
//    cell.shrq.text=@"4";
    return cell;
    
    
}

- (void)setNewOrientation:(BOOL)fullscreen

{
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}

@end
