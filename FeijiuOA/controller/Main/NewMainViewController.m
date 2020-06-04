//
//  NewMainViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/29.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "NewMainViewController.h"
#import "MainCollectionViewCell.h"
#import "BaseViewController.h"
#import "UserPermission.h"
@interface NewMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSMutableArray *mianArr;
}

@end

@implementation NewMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets=NO;
    
    //[self.navigationItem setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
    [self.navigationItem setTitle:@"金费一期"];
    NSString *month=[[NSUserDefaults standardUserDefaults]objectForKey:@"month"];
    NSString *day=[[NSUserDefaults standardUserDefaults]objectForKey:@"day"];
    
    if (month.length==0) {
        [[NSUserDefaults standardUserDefaults ]setObject:@"6" forKey:@"month"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if (day.length==0) {
        [[NSUserDefaults standardUserDefaults ]setObject:@"30" forKey:@"day"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MainItem" ofType:@"plist"];
    mianArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    if ([[UserPermission standartUserInfo].isgys isEqualToString:@"1"]) {

        [mianArr removeObjectAtIndex:3];
      [mianArr removeObjectAtIndex:0];


    }
    else
    {
        [mianArr removeObjectAtIndex:4];
       [mianArr removeObjectAtIndex:1];


    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mianArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.tittleLab.text =mianArr[indexPath.row][@"name"];
      cell.topImage.image =[UIImage imageNamed:mianArr[indexPath.row][@"ima"]];
   // cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 130);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


////通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//    headerView.backgroundColor =[UIColor grayColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//    label.text = @"这是collectionView的头部";
//    label.font = [UIFont systemFontOfSize:20];
//    [headerView addSubview:label];
//    return headerView;
//}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
   
   // NSLog(@"%@",mianArr[indexPath.row]);
    
    [self gotoViewControllWithNum:mianArr[indexPath.row][@"flag"] AndStoryboardID:mianArr[indexPath.row][@"bundid"] ];
   
    
}
-(void)gotoViewControllWithNum:(NSString *)num AndStoryboardID:(NSString *)storyboardId
{
      BaseViewController *tab=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:storyboardId];
        tab.flag=num;
       [self.navigationController pushViewController:tab animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
