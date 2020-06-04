//
//  NoticeListViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NoticeListViewController.h"
#import "NoticeWebApi.h"
#import "NoticeMainModel.h"
#import "NoticeSubModel.h"
#import "NoticeListViewCell.h"
#import "AlertHelper.h"
#import "NoticeDetailViewController.h"

#import "NoticeDetailMainCell.h"
#import "NoticeYuYueView.h"
#import "ScreenHelper.h"
#import "UserPermission.h"
@interface NoticeListViewController ()<UITableViewDelegate,UITableViewDataSource,NoticeYuYueDelegate>
{
     NSMutableArray *dataArr;
     // NSMutableArray *sectionData;
    NoticeYuYueView *view;
    UIView *bgView ; //遮罩层
    BOOL yuyueMode;
    BOOL historyMode;

    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hisBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NoticeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    dataArr=[NSMutableArray new];
    historyMode=NO;
    yuyueMode=NO;
    [self getData];
}
-(void)getData
{
      [dataArr removeAllObjects];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [NoticeWebApi GetpricenoticedtWithSuccess:^(NSArray *arr) {
      //          NSLog(@"1Sss %@",arr);
        //NSLog(@"2Sss %@",arr[0]);
        [AlertHelper hideAllHUDsForView:self.view];
        for (int i=0;i<arr.count ;i++) {
            NSDictionary *dict1=arr[i][@"pric"];
            NoticeMainModel *model=[[NoticeMainModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            
            
            NSArray *coArr=arr[i][@"count"];
            NSMutableArray *subArr=[NSMutableArray array];
            for (NSDictionary *dict2 in coArr) {
                NoticeSubModel *mode2=[[NoticeSubModel alloc]init];
                [mode2 setValuesForKeysWithDictionary:dict2];
                [subArr addObject:mode2];
            }
            model.subLists=subArr;
            [dataArr addObject:model];
        }
        [self.tableView reloadData];

    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (historyMode) {
       return dataArr.count;

    }
    else
    {
        if (dataArr.count>0) {
             return 1;
        }
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (historyMode) {
        static NSString *identfier=@"cell";
        NoticeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeListViewCell" owner:self options:nil] lastObject];
        }
        NoticeMainModel *model=dataArr[indexPath.row];
       
        cell.lab_time.text=model.djsj;
        cell.lab_name.text=model.djr;
        cell.lab_content.text=model.fbgs;
        return cell;
        
    }
    else
    {
      
            static NSString *identfier=@"cell1";
            NoticeDetailMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeDetailMainCell" owner:self options:nil] lastObject];
            }
            NoticeMainModel *_mainModel=dataArr[indexPath.row];
            cell.mainModel=_mainModel;
            cell.lab_time.text=_mainModel.djsj;
            cell.lab_person.text=_mainModel.djr;
            cell.lab_content.text=_mainModel.fbgs;
            cell.cellHeight=_mainModel.subLists.count*47+170;
           [cell setCellTableViewHeight];
            return cell;
       
      
        
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UserPermission standartUserInfo].isgys isEqualToString:@"1"])
    {
      yuyueMode=YES;
      if (yuyueMode&&historyMode==NO)
       {
        [self showThebgview];
        view =[[ NoticeYuYueView alloc]  initWithFrame:CGRectMake(5, [ScreenHelper SCREEN_HEIGHT]/2-250, [ScreenHelper SCREEN_WIDTH]-10, 300) andMode:NO ];
        NoticeMainModel *_mainModel=dataArr[indexPath.row];
        view.mainModel=_mainModel;
        [view refresh];
        view.dDelegate=self;
        [self.view.window addSubview:view];
      }
        else
        {
            NoticeDetailViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NoticeDetail"];
            NoticeMainModel *model=dataArr[indexPath.row];
            tab.mainModel=model;
            if (indexPath.row==0) {
                tab.isfirst=YES;
            }
            else
            {
                tab.isfirst=NO;
            }
            [self.navigationController pushViewController:tab animated:YES];
            
        }
    }
    else
    {
       if (historyMode) {
            NoticeDetailViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NoticeDetail"];
            NoticeMainModel *model=dataArr[indexPath.row];
            tab.mainModel=model;
            [self.navigationController pushViewController:tab animated:YES];
        }
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (historyMode) {
        return 68;
    }
    else
    {
        NoticeDetailMainCell *cell = (NoticeDetailMainCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight+10;
        
       // return 324;
    }
  
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (historyMode==NO&&[[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        UIButton * bt_selectPerson1=[UIButton buttonWithType:UIButtonTypeCustom];
        bt_selectPerson1.frame=CGRectMake(20, 10,self.view.frame.size.width-40, 40);
        [bt_selectPerson1 setTitle:@"预约" forState:UIControlStateNormal];
        [bt_selectPerson1 addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
        [bt_selectPerson1 setBackgroundImage:[UIImage imageNamed:@"btn_queding1.png"] forState:UIControlStateNormal];
        bt_selectPerson1.tag=1002;
        bt_selectPerson1.titleLabel .font =[UIFont systemFontOfSize:14];
        [view addSubview:bt_selectPerson1];
        return view;
        
    }
    else
    {
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (historyMode==NO&&[[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        return 60;
    }
    else
    {
        return 0;
    }
    
}
- (IBAction)refresh:(id)sender {
    [self getData];
}
- (IBAction)histroyPress:(id)sender {
    historyMode=!historyMode;
    if (historyMode) {
        [_hisBtn setTitle:@"详情"];
    }
    else
    {
        [_hisBtn setTitle:@"历史"];
    }
    [self.tableView reloadData];
    
    
}
-(void)surePress
{
    yuyueMode=YES;
    [self showThebgview];
    view =[[ NoticeYuYueView alloc]  initWithFrame:CGRectMake(5, [ScreenHelper SCREEN_HEIGHT]/2-250, [ScreenHelper SCREEN_WIDTH]-10, 300) andMode:NO ];
    if (dataArr.count>0) {
          view.mainModel=dataArr[0];
         [view refresh];
          view.dDelegate=self;
    }
  
   
    [self.view.window addSubview:view];
    
}
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
  
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [view removeFromSuperview];
    yuyueMode =NO;
    
}
-(void)selectCancell
{
    [self removeTheView:nil];
    
}
-(void)selectSheHeWithDic:(NSDictionary *)dic
{
     [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [NoticeWebApi inbookingDIc:dic Success:^(NSArray * arr) {
        NSLog(@"%@",arr);
            [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *userDic=arr[0];
        if ([[userDic objectForKey:@"bool"]isEqualToString:@"1"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //  alert.tag=111;
            [alert show];
           [self removeTheView:nil];
           [self getData];
        }
        else {
            UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:userDic[@"content"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
    
}
@end
