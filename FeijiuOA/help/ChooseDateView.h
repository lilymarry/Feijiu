
#import <UIKit/UIKit.h>
#import "CommonDelegate.h"

@interface ChooseDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic)  NSString *dateId;
@property (nonatomic) id<dateChooseDelegate> chooseDateDelegate;
+(ChooseDateView *)instanceChooseDateView;
@end
