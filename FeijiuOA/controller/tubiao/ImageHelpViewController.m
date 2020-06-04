//
//  ImageHelpViewController.m
//  FeijiuOA
//
//  Created by imac-1 on 2018/1/25.
//  Copyright © 2018年 魏艳丽. All rights reserved.
//

#import "ImageHelpViewController.h"
//#import "SupplierflowImagViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageHelper.h"
#import "AppDelegate.h"
#import "FlowImageCollectionCell.h"
#import "LargeImageView.h"
@interface ImageHelpViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
}


@end

@implementation ImageHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

      NSLog(@"1AAAA_ %@",_model.piclist);
   

     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[FlowImageCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
}
- (void)back

{
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = YES;//关闭横屏仅允许竖屏
    
    [self setNewOrientation:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _model.piclist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    FlowImageCollectionCell *cell = (FlowImageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSString *imgurlstr= _model.piclist[indexPath.row][@"pic"];
    NSURL *url=[NSURL URLWithString:imgurlstr];
    
    [cell.topImage   sd_setImageWithURL:url                                placeholderImage:[UIImage imageNamed:@"nopicture"]
                            options:0
                          completed:^(UIImage *image,
                                      NSError *error,
                                      SDImageCacheType cacheType,
                                      NSURL *imageURL){
                              cell.topImage.image=[ImageHelper zipFlowImageWithImage:image];
                              
                          }];
   
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2-50, 130);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imgurlstr= _model.piclist[indexPath.row][@"pic"];
   // NSURL *url=[NSURL URLWithString:imgurlstr];
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
}
//查看任务图片


@end
