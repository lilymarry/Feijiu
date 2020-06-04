#import "NullValueHelper.h"

@implementation NullValueHelper
+(BOOL)textViewNotNullOrNull:(UITextView *)textView
{
    if (textView.text.length==0)
    {
        return YES;//表示空
    }
    else
    {
        return NO;
    }
}
+(BOOL)textFeildNotNullOrNull:(UITextField *)textField
{
    if (textField.text.length==0)
    {
        return YES;//表示空
    }
    else
    {
        return NO;
    }
}
+(BOOL)textViewAndtextFeildNotNullOrNull:(NSArray *)text
{
    for (UIView *view in text)
    {
     if ([view isKindOfClass:[UIControl class]])
        {
            UITextField *feild=(UITextField *)view;
            if (feild.text.length==0)
            {
                return YES;
            }
            else
            {
                ;
            }
        }else{
            UITextView *textView=(UITextView *)view;
            if (textView.text.length==0)
            {
                return YES;
            }
            else
            {
                ;
            }
        }
    }
    return NO;
}
@end
