#ifndef Re_OA_URL_h
#define Re_OA_URL_h

#endif

#pragma mark 外网端口

#define scrollViewWidth 101
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//局域网测试
//#define kDomain @"http://192.168.0.253:4000" //数据表
//#define kDomain @"http://192.168.0.253:8011"//下单测试
//#define kDomain @"http://192.168.0.108"
//#define kDomain @"http://nengyuan.xiexukj.com"
//#define kDomain @"https://nengyuan.xiexukj.com"

//#define versionUrl @"http://221.122.101.109:8088"
//#define kDomainn @"http://221.122.101.109:8086"//特殊摄像 的URL 的（发改委）


#define versionUrl @"http://versions.xiexukj.com"
#define kDomainn @"http://fagaiwei.xiexukj.com"
//#define isProductionKey false
#define isProductionKey TRUE
//#define zdid @"2"//单位代号 广聚源 1  宁河 2 国再 3 //管理员 质检
#define zdid [[NSUserDefaults standardUserDefaults]objectForKey:@"stationid"]



#define kDomain @"http://218.241.17.97:5037"
#define JpuchKey @"934737b47972cb9553993ac3"


//#define kDomain @"http://218.241.17.97:5008/"
//#define JpuchKey @"411ee2534185f489207bf3f7"
//#define dituKey @"5ln3uMItk66Bex9RWPjtqjY7"
//#define kVersion_API [NSString stringWithFormat:@"%@/Wap/DataProcessing.ashx?id=2",versionUrl]


//兴阳包装
//#define kDomain @"http://xingyang.xiexukj.com"
#define dituKey @"bb0HoI4L7virdlEQSROikfn5RTajl2g5"
#define kVersion_API [NSString stringWithFormat:@"%@/Wap/DataProcessing.ashx?id=8",versionUrl]






