

#import "NetRequestTool.h"
#import <AFNetworking.h>
#import "URL.h"
#import <UIKit/UIKit.h>
@implementation NetRequestTool
-(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    //  manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}
+(NetRequestTool*)sharedRequest
{
    static NetRequestTool *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NetRequestTool alloc] init];
    });
    return _sharedManager;
    
}
+ (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"CACertificate-2" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
  //  AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
   // AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    
  
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
   NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
   securityPolicy.pinnedCertificates = set;
  
    return securityPolicy;
}
#pragma 通用请求 加密

-(void)request:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail   
{
    
    AFHTTPSessionManager *manager = [self manager];
  // [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
    
  
    @try {
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
            NSLog(@"______   %@",[NSString stringWithFormat:@"%@?%@",url,str1]);
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
   NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            id  arr;
            if (data) {
                arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
        
            
            if (arr) {
                success(arr);
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        fail();
        NSLog(@"请求失败：%@",error);
    }];
}
-(void)requestCommon:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail
{
    
    AFHTTPSessionManager *manager = [self manager];
    //  [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
     NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        if(responseObject){
            id  arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        fail();
    }];
    
}
//带有上传一张图片的请求
-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [self manager];
     // [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        if (imgData) {
            [formData appendPartWithFileData:imgData name:@"img" fileName:@"1.jpg" mimeType:@"image/jpeg"];
        }
        // [formData appendPartWithFileData:imgData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
    //  NSLog(@"@@@@+ %lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        // NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        //   NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}


-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail
{
    
    
    AFHTTPSessionManager *manager = [self manager];
   //   [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        if (imgData) {
            [formData appendPartWithFileData:imgData name:@"Pic" fileName:@"1.jpg" mimeType:@"image/jpeg"];
            
        }
        if (voi) {
            [formData appendPartWithFileData:voi name:@"Voi" fileName:@"1.wmv" mimeType:@"video/x-ms-wmv"];
        }
        // [formData appendPartWithFileData:imgData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
    //    NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //  NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        // NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}
-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail
{
    
    
    AFHTTPSessionManager *manager = [self manager];
    //   [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        for(int  i = 0; i <imageDataArray.count; i++)
        {   UIImage * image = [imageDataArray objectAtIndex:i];
            NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
            // NSData *imageData=imageDataArray[i];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic%d.jpg", i] fileName:[NSString stringWithFormat:@"pic%d.jpg", i] mimeType:@"image/jpeg"];
        }
//        if (imgData) {
//            [formData appendPartWithFileData:imgData name:@"Pic" fileName:@"1.jpg" mimeType:@"image/jpeg"];
//            
//        }
        if (voi) {
            [formData appendPartWithFileData:voi name:@"Voi" fileName:@"1.wmv" mimeType:@"video/x-ms-wmv"];
        }
        // [formData appendPartWithFileData:imgData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        //    NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //  NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        // NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}

-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail
{
    
    
    AFHTTPSessionManager *manager = [self manager];
    //   [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
    
        @try {
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
            if (url.length!=0&&str1.length!=0) {
                NSLog(@"______   %@",[NSString stringWithFormat:@"%@?%@",url,str1]);
            }

        } @catch (NSException *exception) {

        } @finally {

        }
    
//
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        for(int  i = 0; i <imageDataArray.count; i++)
        {   UIImage * image = [imageDataArray objectAtIndex:i];
            NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
            // NSData *imageData=imageDataArray[i];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic%d.jpg", i] fileName:[NSString stringWithFormat:@"pic%d.jpg", i] mimeType:@"image/jpeg"];
        }
       
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        //    NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //  NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        // NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}

//带有进度上传一张图片的请求
-(void)requestl:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail   progress:(void (^)(float))progress
{
    AFHTTPSessionManager *manager = [self manager];
   //   [manager setSecurityPolicy:[NetRequestTool customSecurityPolicy]];
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        if (imgData) {
            [formData appendPartWithFileData:imgData name:@"img" fileName:@"1.jpg" mimeType:@"image/jpeg"];
        }
        // [formData appendPartWithFileData:imgData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        float uploadProgressF=1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        //  NSLog(@"@@@@+ %lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        progress(uploadProgressF);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        // NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        //   NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}



-(void)requestMorePic:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail  progress:(void (^)(float))progress

{
    AFHTTPSessionManager *manager = [self manager];
    
      NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:utf parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        //   NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        for(int  i = 0; i <imageDataArray.count; i++)
        {   UIImage * image = [imageDataArray objectAtIndex:i];
            NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
            // NSData *imageData=imageDataArray[i];
            [formData appendPartWithFileData:imageData name:@"" fileName:[NSString stringWithFormat:@"img%d.jpg", i+1] mimeType:@"image/jpeg"];
        }
        // [formData appendPartWithFileData:imgData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        float uploadProgressF=1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
    
        progress(uploadProgressF);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        // NSLog(@"请求成功：%@",responseObject);
        if(responseObject){
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *urlencodeStr=[aString  stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            NSString *str =[urlencodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
            
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            id  arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (arr) {
                success(arr);
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        //   NSLog(@"请求失败：%@",error);
        fail();
    }];
    
}


@end
