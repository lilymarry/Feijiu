//
//  CompanyViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/3/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "CompanyViewController.h"
#import "LoginWebApi.h"
#import "AlertHelper.h"
#import "CompanyModel.h"
#import "URL.h"
@interface CompanyViewController ()
{
    
        NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      dataArr=[NSMutableArray new];
     [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [LoginWebApi getCompanySuccess:^(NSArray *arr) {
      [AlertHelper hideAllHUDsForView:self.view];
        NSLog(@"AAA %@",arr);
        for (NSDictionary *dict1 in arr) {
            CompanyModel *model=[[CompanyModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [dataArr addObject:model];
        }
        [self.tableView reloadData];
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
}
- (IBAction)lastPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return dataArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        static NSString *identfier=@"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        }
       cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
       CompanyModel*model=dataArr[indexPath.row];
       if ([model.stationid isEqualToString:zdid]) {
        cell.textLabel .textColor=[UIColor blueColor];
        }
       cell.textLabel.text=model.stationname;
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CompanyModel*model=dataArr[indexPath.row];
   
    [[NSUserDefaults standardUserDefaults ]setObject:model.stationid forKey:@"stationid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults ]setObject:model.stationname forKey:@"stationname"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
