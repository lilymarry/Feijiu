//
//  LineAmountViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2017/12/29.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import "CK_LineAmountViewController.h"
#import "BaoBiaoWebApi.h"
#import "AlertHelper.h"
//#import "HooDatePicker.h"
#import "CK_SelectItemViewController.h"
//#import <JavaScriptCore/JavaScriptCore.h>
#import "URL.h"
#import "ScreenHelper.h"

//每日线图
#define daliyline_APi [NSString stringWithFormat:@"%@/Wap/ckdailypic.aspx",kDomain]
//每月金额
#define monthlyline_APi [NSString stringWithFormat:@"%@/Wap/ckmonthlypic.aspx",kDomain]
//每日结算净重
#define dailyweightline_APi [NSString stringWithFormat:@"%@/Wap/ckdailyweight.aspx",kDomain]
//每月结算重量
#define monthlyweightline_APi [NSString stringWithFormat:@"%@/Wap/ckmonthlyweight.aspx",kDomain]

@interface CK_LineAmountViewController ()<UIWebViewDelegate>
{
        
        NSString *hwmcc;
        NSString *khjcc;
        NSString *zdmcc;
        NSString *stime;
        NSString *etime;
    
 
        
}
@property (strong, nonatomic)  UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btn_time;
@property (nonatomic, strong) NSURLRequest *request;
    
    
@end

@implementation CK_LineAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hwmcc=@"全部";
    khjcc=@"全部";
    zdmcc=@"全部";
    self. webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,139, self.view.frame.size.width, self.view.frame.size.height-139)];
    self.webView.delegate=self;
   self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
  
    if ([self. flag isEqualToString:@"0"]||[self.flag isEqualToString:@"2"]) {
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        
        stime=[self convertStringToDate:[dateFormatter1 stringFromDate:date] Withformat:@"yyyy-MM-dd" isDay:YES];
        etime=[dateFormatter1 stringFromDate:date];
        [self getDataWithst:stime andEt:etime];
    }
    else
    {
        
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM"];
        stime=[self convertStringToDate:[dateFormatter1 stringFromDate:date] Withformat:@"yyyy-MM" isDay:NO];
        etime=[dateFormatter1 stringFromDate:date];
        [self getDataWithst:stime andEt:etime];
        
        
    }
    if ([self.flag isEqualToString:@"0"]) {
      [self.navigationItem setTitle:@"每日金额图"];
    }
    else if ([self.flag isEqualToString:@"1"])
    {
     
        [self.navigationItem setTitle:@"每月金额图"];
    }
    else if ([self.flag isEqualToString:@"2"])
    {
     
        [self.navigationItem setTitle:@"每日结算净重图"];
      
    }
    else
    {
      
        [self.navigationItem setTitle:@"每月结算净重图"];
    
    }
    
}
-(void)getDataWithst:(NSString *)stim andEt:(NSString *)etim
    {
        NSString *method;
        NSString *st=stim;
        NSString *et=etim;
        NSString *url;
        if ([self.flag isEqualToString:@"0"]) {
            
            method=@"supplierdailylinegraphamount";
            url=daliyline_APi;
            
        }
        else if ([self.flag isEqualToString:@"1"])
        {
            method=@"suppliermonthlykinegraphamount";
            url=monthlyline_APi;
            
        }
        else if ([self.flag isEqualToString:@"2"])
        {
            method=@"supplierdailylinegraphweight";
            url=dailyweightline_APi;
            
        }
        else
        {
            method=@"suppliermonthlylinegraphweight";
            url=monthlyweightline_APi;
            
        }
      NSLog(@"____ %@ %@",st,et);
       
        if ([hwmcc isEqualToString:@"全部"]) {
            hwmcc=@"";
            
        }
        if ([khjcc isEqualToString:@"全部"]) {
            khjcc=@"";
            
        }
        if ([zdmcc isEqualToString:@"全部"]) {
            zdmcc=@"";
            
        }
        [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
        NSDictionary * parm = @{@"method":method,@"getsupplier":khjcc,@"getnameofgoods":hwmcc,@"getstartdate":st,@"getenddate":et,@"zdid":zdid};
         NSLog(@"WWWWW____ %@",parm);
            NSMutableString *str1=[NSMutableString string];
            NSArray *arr=parm.allKeys;
            for (int i=0 ;i<arr.count ;i++) {
        
                [str1 appendString: [NSString stringWithFormat:@"%@",arr[i]]];
                [str1 appendString:@"="];
                [str1 appendString:[NSString stringWithFormat:@"%@",parm[arr[i]]]];
                if (i!=arr.count-1) {
                    [str1 appendString:@"&"];
                }
            }
            if (url.length!=0&&str1.length!=0  ) {
   
                NSString *str= [NSString stringWithFormat:@"%@?%@",url,str1];
                NSString *encodedString=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *weburl = [NSURL URLWithString:encodedString];
                NSURLRequest * request = [NSURLRequest requestWithURL:weburl];
                [self.webView loadRequest:request];
                
            }

}
- (IBAction)selectItemPress:(id)sender {

    CK_SelectItemViewController *changyongController=  [ [CK_SelectItemViewController alloc] initWithBlock:^(NSString *hwmc,NSString *zdmc,NSString *khjc,NSString *st ,NSString *et )
                                                        {
                                                            stime=st;
                                                            etime=et;
                                                            hwmcc=hwmc;
                                                            zdmcc=zdmc;
                                                            khjcc=khjc;
                                                             [self getDataWithst:stime andEt:etime];
                                                        }];
    if ([hwmcc isEqualToString:@""]) {
        hwmcc=@"全部";
        
    }
    if ([khjcc isEqualToString:@""]) {
        khjcc=@"全部";
        
    }
    if ([zdmcc isEqualToString:@""]) {
        zdmcc=@"全部";
        
    }
    changyongController.state=[NSString stringWithFormat:@"%d",[self.flag intValue]+1];
    changyongController.st=stime;
    changyongController.et=etime;
    changyongController.hwmc=hwmcc;
    changyongController.zdmc=zdmcc;
    changyongController.khjc=khjcc;
    [self.navigationController pushViewController:changyongController animated:YES];
    
}


- (NSString *)convertStringToDate:(NSString *)string Withformat:(NSString *)fromat isDay:(BOOL)isday  {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fromat];
    NSDate *currentDate = [dateFormatter dateFromString:string];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //1表示1年后的时间 year = -1为1年前的日期，month day 类推
    if (isday) {
        NSString *day=  [[NSUserDefaults standardUserDefaults]objectForKey:@"day"];
        [lastMonthComps setDay:-[day integerValue]];
    }
    else
    {
        NSString *month=  [[NSUserDefaults standardUserDefaults]objectForKey:@"month"];
        [lastMonthComps setMonth:-[month integerValue]];
    }
    
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *str=[dateFormatter stringFromDate:newdate];
    return str;
}

//-(NSString *)getTimeWithDate:(NSString *)date
//{
//    NSString *str=@"MM";
//    NSRange range = [date rangeOfString:str];//匹配得到的下标
//    NSString *   string;
//
//    if (range.location!=NSNotFound)
//    {
//       // string = [date substringFromIndex:range.length+range.location];//截取范围类的字符串
//         string = [date substringToIndex:range.location];//截取范围类的字符串
//
//        return string;
//    }
//    else
//    {
//        return @"";
//    }
//
//
//}
#pragma mark - UIWebViewDelegate
//设置webview的title为导航栏的title
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [AlertHelper hideAllHUDsForView:self.view];
    //网页加载完成调用此方法
    NSLog(@"succed");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
    NSLog(@"123");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
     NSLog(@"WWWXXHAX %@",error);
    
    
}

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
