
#import <Foundation/Foundation.h>

@interface NetRequestTool : NSObject
+(NetRequestTool*)sharedRequest;

-(void)request:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail;
-(void)requestCommon:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail;

-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail;
//带有进度上传一张图片的请求
-(void)requestl:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail   progress:(void (^)(float))progress;

-(void)requestMorePic:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail  progress:(void (^)(float))progress;


-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail;
 
-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail;

-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail;
@end
