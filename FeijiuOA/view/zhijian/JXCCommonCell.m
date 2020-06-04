

#import "JXCCommonCell.h"

@implementation JXCCommonCell

+(instancetype)initWithNib{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCCommonCell" owner:nil options:nil];
    return  [nibView lastObject];
}

- (void)awakeFromNib {
   [super awakeFromNib ]; 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
