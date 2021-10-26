//
//  SettingTableViewCell.h
//  OneTimePasswordExample
//
//  Created by MaiNakagami on 2021/09/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

NS_ASSUME_NONNULL_END
