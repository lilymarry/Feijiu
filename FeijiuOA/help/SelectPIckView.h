#import <UIKit/UIKit.h>
@protocol okButtonDelegate <NSObject>
@optional
-(void)doButtonWithSelectRow:(NSString *)row state:(int )state selectRow:(int)selectrow;
-(void)doCancellWithState:(int)state;
@end


@interface SelectPIckView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic)id<okButtonDelegate>delegate;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic)int  state;
@property(nonatomic)int selectRow;
@property (strong, nonatomic)  UIPickerView *pickView;
@property(weak,nonatomic)NSString *selected;
- (id)initWithFrame:(CGRect)frame WithMode:(NSString *)mode;
- (void)sureBtnPress:(id)sender;
-(void)reloaPickView;
@end

