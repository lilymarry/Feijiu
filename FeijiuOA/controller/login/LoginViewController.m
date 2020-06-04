#import "LoginViewController.h"
//#import <MBProgressHUD.h>
#import "NetRequestTool.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "NullValueHelper.h"
#import "AlertHelper.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#import "LoginWebApi.h"
#define  kTextH 50
 
#define kUSERNAME @"username"
#define kPASSWORD @"password"

@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_userName;
    UITextField *_password;
    BOOL isEdit;
    UIButton *savaPw;
    UIImageView *remImage;
    MBProgressHUD *hud;
    NSString *versionStr;
    NSString *versionShortStr;
    NSString *appUrl;
    //  BOOL isappstore;
}
@property (strong, nonatomic) NSArray * TextArr;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    // _loginState=@"1";
    
    // isappstore= ((AppDelegate*)[[UIApplication sharedApplication] delegate]).isSubmiteToAppStore;
    [super viewDidLoad];
    CGRect  viewRect = CGRectMake(0, 0,[ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]);
    self.view.bounds=viewRect;
    
        versionStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        versionShortStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [self createSubview];
    _userName.text=[[NSUserDefaults standardUserDefaults]objectForKey:kUSERNAME];
    _password.text=[[NSUserDefaults standardUserDefaults]objectForKey:kPASSWORD];
}

//-(void)viewDidAppear:(BOOL)animated{
//
//        [[NetRequestTool sharedRequest]requestVersionFromURLsuccess:^(NSArray *arr){
//
//            NSString *updateVersion= [arr[0] valueForKey:@"version"];
//
//            appUrl = [arr[0] valueForKey:@"url"];
//
//            if ( (![updateVersion isEqualToString:versionStr])) {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有可用的更新！" message:[[NSString alloc] initWithFormat:@"检测到新版本 v%@",updateVersion] delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"现在升级", nil];
//                [alert show];
//            }
//        } fail:^(){}];
//  //  }
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if (buttonIndex ==1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
//    }
//}

//初始化登录界面
-(void)createSubview
{
    //视图背景
    UIImageView *b=[[UIImageView alloc]init];
    b.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    b.image=[UIImage imageNamed:@"denglubeijing-1242w2208h@3x.png"];
    [self.view addSubview:b];
    
    CGFloat iconWH=25;
    CGFloat y;
    if ( self.view.bounds.size.height==480)
    {
        y=170;
    }
    else
    {
        y=240;
    }
    CGFloat w=self.view.frame.size.width;
    
    
    UIButton *login1=[UIButton buttonWithType:UIButtonTypeCustom];
    login1.layer.cornerRadius = 10.0;//2.0是圆角的弧度，根据需求自己更改
    login1.layer.borderColor = [UIColor whiteColor].CGColor;//设置边框颜色
    login1.layer.borderWidth = 1.0f;
    login1.frame=CGRectMake(20, y-140, 80, kTextH-20 );
    [login1 setTitle:@"选择厂区" forState:UIControlStateNormal];
    [login1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login1 addTarget:self action:@selector(selectCompany) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login1];
    
    
    UIImageView *b11=[[UIImageView alloc]init];
    b11.frame=CGRectMake(55,y-100, 90, 85);
    b11.image=[UIImage imageNamed:@"ic_logo_zhong.png"];
    [self.view addSubview:b11];
   
    
    
    UILabel *savetext1=[[UILabel alloc]init];
    savetext1.text=@"中网科技";
    savetext1.textColor=[UIColor whiteColor];
    savetext1.font=[UIFont systemFontOfSize:25];
    savetext1.frame=CGRectMake(CGRectGetMaxX(b11.frame)+10,y-80, w/3, kTextH);
    [self.view addSubview:savetext1];
    
    
    
    _userName=[[UITextField alloc]init];
    _userName.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _userName.placeholder=@"输入工号";
    _userName.frame=CGRectMake(55,y, self.view.frame.size.width-110, kTextH);
    _userName.textColor=[UIColor whiteColor];
    _userName.delegate=self;
    [self.view addSubview:_userName];
    
    UIView *b1=[[UIView alloc]init];
    b1.frame=CGRectMake(55,  CGRectGetMaxY(_userName.frame), self.view.frame.size.width-110, 1);
    b1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:b1];
    
   
    

    _password=[[UITextField alloc]init];
    _password.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _password.placeholder=@"输入密码";
    _password.secureTextEntry=YES;
    _password.frame=CGRectMake(55, CGRectGetMaxY(b1.frame),  self.view.frame.size.width-110, kTextH);
    _password.delegate=self;
    [self.view addSubview:_password];
    
    UIView *b2=[[UIView alloc]init];
    b2.frame=CGRectMake(55,  CGRectGetMaxY(_password.frame), self.view.frame.size.width-110, 1);
    b2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:b2];
    //记住密码button
    savaPw=[UIButton buttonWithType:UIButtonTypeCustom];
    savaPw.frame=CGRectMake(55, CGRectGetMaxY(_password.frame), self.view.frame.size.width/2, kTextH);
    savaPw.showsTouchWhenHighlighted = NO;
    savaPw.selected=[[NSUserDefaults standardUserDefaults]boolForKey:@"savepw"];
    [savaPw addTarget:self action:@selector(savePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savaPw];
    
    remImage=[[UIImageView alloc]initWithFrame:CGRectMake(2,12, iconWH, iconWH)];
    if (savaPw.selected)
    {
        remImage.image=[UIImage imageNamed:@"remBtn.png"];
    }
    else
    {
        remImage.image=[UIImage imageNamed:@"unRemBtn.png"];
    }
    [savaPw addSubview:remImage];
    
    
    UILabel *savetext=[[UILabel alloc]init];
    savetext.text=@"记住密码";
    savetext.textColor=[UIColor whiteColor];
    savetext.frame=CGRectMake(CGRectGetMaxX(remImage.frame)+15,3, w/3, kTextH);
    [savaPw addSubview:savetext];
    
    //登陆按钮
    UIButton *login=[UIButton buttonWithType:UIButtonTypeCustom];
    login.layer.cornerRadius = 10.0;//2.0是圆角的弧度，根据需求自己更改
    login.layer.borderColor = [UIColor whiteColor].CGColor;//设置边框颜色
    login.layer.borderWidth = 1.0f;
    login.frame=CGRectMake(55, CGRectGetMaxY(savaPw.frame)+10, self.view.frame.size.width-110, kTextH-8);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    _TextArr=[NSArray arrayWithObjects:_userName,_password, nil];
}

//保存密码130
-(void)savePassword:(UIButton *)sender
{
    sender.selected=!sender.selected;
    remImage.image=(!sender.selected)?[UIImage imageNamed:@"unRemBtn.png"]:[UIImage imageNamed:@"remBtn.png"];
    [[NSUserDefaults standardUserDefaults]setBool:sender.selected forKey:@"savepw"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)endHUD{
    hud.hidden = YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)selectCompany
{
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Company" bundle:[NSBundle mainBundle]];
    UIViewController *changyongController = [s instantiateViewControllerWithIdentifier:@"Company"];
    
    [self presentViewController:changyongController animated:YES completion:nil];
    
    
}
//登陆
-(void)login
{
    isEdit=NO;
    [self.view endEditing:YES];
   
    NSString *pwd=@"";
    if (_password.text.length!=0) {
        pwd=_password.text;
    }
    NSString *name=@"";
    if (_userName.text.length!=0) {
        name=_userName.text;
    }
    
        
    NSString *stationid= zdid;
    if (stationid.length==0) {
        UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"选择厂区" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [AlertHelper MBHUDShow:@"登录中..." ForView:self.view AndDelayHid:30];
        [LoginWebApi requestLogin:name andPassword:pwd success:^(NSArray *userInfo)
         {   NSLog(@"__________%@",userInfo);
             [AlertHelper hideAllHUDsForView:self.view];
             NSDictionary *userDic=nil;
             if (userInfo) {
                 userDic=(NSDictionary*)userInfo[0];
             }
             
             if ([[userDic objectForKey:@"bool"]isEqualToString:@"0"])
             {
                 UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"用户名不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
             else if ([[userDic objectForKey:@"bool"]isEqualToString:@"2"])
             {
                 UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
             else
             {
                 UserPermission *user = [UserPermission standartUserInfo];
                 
                 NSMutableArray *userData=[[NSMutableArray alloc] init ];
                 [userData addObject:userDic];
                 [user setInfoArr:userData];
                 
                 __autoreleasing NSMutableSet *tags = [NSMutableSet set];
                 [self setTags:&tags addTag:@""];
             //   UserPermission *user = [UserPermission standartUserInfo];
              //   NSLog(@"QQQ %@",user.tsyhdh);
                 NSString *str=  [ NSString stringWithFormat:@"%d",[user.tsyhdh intValue]];
                 //  NSString *str=  [ NSString stringWithFormat:@"%@",user.ID ];
                 __autoreleasing NSString *alias =str;
                 [self analyseInput:&alias tags:&tags];
                 
                 if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
                     [JPUSHService setAlias:alias
                           callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                     object:self];
                     
#endif
                 }  else {
                     [JPUSHService setTags:tags
                                     alias:alias
                          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                    target:self];
                 }
                 
                 
                 [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:kUSERNAME];
                 if (savaPw.selected)
                 {
                     [[NSUserDefaults standardUserDefaults ]setObject:_password.text forKey:kPASSWORD];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                 }else
                 {
                     [[NSUserDefaults standardUserDefaults]removeObjectForKey:kPASSWORD];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                 }
                 //  _loginState=@"2";
                 UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                 UIViewController *changyongController = [s instantiateViewControllerWithIdentifier:@"Main"];
                 
                 [self presentViewController:changyongController animated:YES completion:nil];
                 
                 
             }
         } fail:^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
             [alert show];
         }];
       
   }
}
- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
    //  if ([tag isEqualToString:@""]) {
    // }
    [*tags addObject:tag];
}
- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =[NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,[self logSet:tags], alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}
- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    if (!isEdit)
    {
        frame.origin.y-= window.frame.size.height==568?130:158;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
    isEdit=YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    if (!isEdit) {
        frame.origin.y=0;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isEdit=NO;
    [self.view endEditing:YES];
}
@end
