//
//  SettingController.m
//  OneTimePasswordExample
//
//  Created by Mai Nakagami on 2021/09/28.
//

#import "SettingController.h"
#import "SettingsTableViewCell.h"
#import "ViewController.h"

#pragma mark - Settings item

typedef NS_ENUM(UInt8, SettingsItem) {
    SettingsItem1,
    SettingsItem2,
    SettingsItme3,
};

extern SettingsItem SettingsItemUnknown;


#pragma mark - Settings table view controller

@interface SettingController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) SettingsItem settingsItem;

@property (nonatomic) UIPickerView *pickerView;

@property (nonatomic) NSArray *test1Patterns;
@property (nonatomic) NSArray *test2Patterns;
@property (nonatomic) NSArray *test3Patterns;

@end

@implementation SettingController {
    NSIndexPath * pickerIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.center = self.view.center;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview: self.pickerView];

    self.test1Patterns = @[@"SHA1", @"SHA256", @"SHA512"];
    self.test2Patterns = @[@"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.test3Patterns = @[@"30", @"60"];

    self.test1 = self.test1Patterns[0];
    self.test2 = self.test2Patterns[0];
    self.test3 = self.test3Patterns[0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"SettingsTableViewCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"アルゴリズム";
            cell.valueLabel.text = self.test1;
            break;
        case 1:
            cell.titleLabel.text = @"OTP桁数";
            cell.valueLabel.text = self.test2;
            break;
        case 2:
            cell.titleLabel.text = @"タイムステップ数";
            cell.valueLabel.text = self.test3;
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.settingsItem = indexPath.row;
    [self.pickerView selectRow:0 inComponent:0 animated:true];
    [self.pickerView reloadAllComponents];
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case SettingsItem1:
            return self.test1Patterns.count;
        case SettingsItem2:
            return self.test2Patterns.count;
        case SettingsItme3:
            return self.test3Patterns.count;
        default:
            return 0;
    }
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case SettingsItem1:
            return self.test1Patterns[row];
        case SettingsItem2:
            return self.test2Patterns[row];
        case SettingsItme3:
            return self.test3Patterns[row];
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UIStoryboardSegue *segue;
    ViewController *viewController = segue.destinationViewController;
    switch (self.settingsItem) {
        case SettingsItem1:
            self.test1 = self.test1Patterns[row];
            viewController.test.text = self.test1;
            break;
        case SettingsItem2:
            self.test2 = self.test2Patterns[row];
            break;
        case SettingsItme3:
            self.test3 = self.test3Patterns[row];
            break;
    }
 
    [self.tableView reloadData];
}

@end
