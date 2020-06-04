

#import "ImageHelper.h"

#import "ScreenHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ImageHelper



///对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//缩列图
+(UIImage*)zipFlowImageWithImage:(UIImage*)image {

        
        //设置image的尺寸
        CGSize imagesize = image.size;
        
        //iphone5
        CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
        
    //iphone6
    if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
        a=(imagesize.height>imagesize.width)?375:667;
        
    }
    else if ([ScreenHelper checkWhichIphoneScreen] == iphoneX){
        a=(imagesize.height>imagesize.width)?375:812;
    }
    else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
        a=(imagesize.height>imagesize.width)?414:736;
    }
        float XX=imagesize.width/a;//宽度比
        float VY=imagesize.height/XX;//在屏幕上的高度
        
        imagesize.width = a/4;//放大倍数100
        imagesize.height =VY/4;
        
        UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];
        
        return ima;


}
+(UIImage *)zipLargImagWithImage:(UIImage *)image
{
    //设置image的尺寸
    CGSize imagesize = image.size;
    
    //iphone5
    CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
    
    //iphone6
    if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
        a=(imagesize.height>imagesize.width)?375:667;
        
    }
    else if ([ScreenHelper checkWhichIphoneScreen] == iphoneX){
        a=(imagesize.height>imagesize.width)?375:812;
    }
    else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
        a=(imagesize.height>imagesize.width)?414:736;
    }
    float XX=imagesize.width/a;//宽度比
    float VY=imagesize.height/XX;//在屏幕上的高度
    
    imagesize.width = a*10;//放大倍数100
    imagesize.height =VY*10;
    
    UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];
    
    return ima;


}
@end
