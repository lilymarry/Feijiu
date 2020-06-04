//
//  AppDelegate.h
//  FeijiuOA
//
//  Created by imac-1 on 2017/11/8.
//  Copyright © 2017年 魏艳丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URL.h"
static NSString *appKey = JpuchKey;
static NSString *channel = @"Publish channel";
static BOOL isProduction = isProductionKey;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (assign , nonatomic) BOOL isForceLandscape;
//@property (assign , nonatomic) BOOL isForcePortrait;
@property(nonatomic,assign)BOOL allowRotation;//是否允许转向
@end

