
#import "UserPermission.h"



static UserPermission *user;
@implementation UserPermission



+ (UserPermission *)standartUserInfo
{
    if (!user)
    {
        user = [[UserPermission alloc] init];
        
    }
    return  user;
}
-(void)setInfoArr:(NSArray *)infoArr
{
    self.klz = [infoArr[0] objectForKey:@"klz"];
    self.yhm = [infoArr[0] objectForKey:@"yhm"];
    self.isgys = [infoArr[0] objectForKey:@"isgys"];
     self.tsyhdh = [infoArr[0] objectForKey:@"tsyhdh"];
     self.yhdh = [infoArr[0] objectForKey:@"yhdh"];
     self.bm = [infoArr[0] objectForKey:@"bm"];
     self.gysdh = [infoArr[0] objectForKey:@"gysdh"];
     self.gysjc = [infoArr[0] objectForKey:@"gysjc"];
    
}

@end
