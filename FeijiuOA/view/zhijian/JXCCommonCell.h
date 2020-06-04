
#import <UIKit/UIKit.h>

@interface JXCCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_rkdh;
@property (weak, nonatomic) IBOutlet UILabel *lab_djsj;
@property (weak, nonatomic) IBOutlet UILabel *lab_cph;

@property (weak, nonatomic) IBOutlet UILabel *lab_gys;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;




+(instancetype)initWithNib;

@end
