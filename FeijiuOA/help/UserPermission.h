

#import <Foundation/Foundation.h>

@interface UserPermission : NSObject
@property (strong, nonatomic) NSString *klz;

@property (strong, nonatomic) NSString *yhm;
@property (strong, nonatomic) NSString *isgys;
@property (strong, nonatomic) NSString *tsyhdh;
@property (strong, nonatomic) NSString *yhdh;
@property (strong, nonatomic) NSString *bm;
@property (strong, nonatomic) NSString *gysdh;
@property (strong, nonatomic) NSString *gysjc;

@property (strong, nonatomic) NSArray *infoArr;


+ (UserPermission *) standartUserInfo;
@end
