//
//  NoticeDetailViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/5.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "UserPermission.h"
#import "NoticeDetailMainCell.h"
#import "NoticeYuYueView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
#import "NoticeWebApi.h"
@interface NoticeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,NoticeYuYueDelegate>
{
    NSMutableArray *dataArr;
    NoticeYuYueView *view;
    UIView *bgView ; //遮罩层
     BOOL yuyueMode;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    yuyueMode=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{return  2;
//
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (section==0) {
//        return 1;
//    }
//    else
//    return _mainModel.subLists.count;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identfier=@"cell1";
    NoticeDetailMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeDetailMainCell" owner:self options:nil] lastObject];
    }
 //   NoticeMainModel *_mainModel=dataArr[indexPath.row];
    cell.mainModel=_mainModel;
    cell.lab_time.text=_mainModel.djsj;
    cell.lab_person.text=_mainModel.djr;
    cell.lab_content.text=_mainModel.fbgs;
    cell.cellHeight=_mainModel.subLists.count*47+170;
    [cell setCellTableViewHeight];
    return cell;
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeDetailMainCell *cell = (NoticeDetailMainCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight+10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"jckdcds");
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_isfirst&&[[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
   
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
    
    if (_isfirst&&[[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {
        return 60;
    }
    else
    {
        return 0;
    }
    
}
-(void)surePress
{
    yuyueMode=YES;
    [self showThebgview];
    view =[[ NoticeYuYueView alloc]  initWithFrame:CGRectMake(5, [ScreenHelper SCREEN_HEIGHT]/2-250, [ScreenHelper SCREEN_WIDTH]-10, 300) andMode:NO ];

    view.mainModel=_mainModel;
    [view refresh];
    view.dDelegate=self;
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
          //  [self getData];
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
