//
//  SettingController.m
//  OneTimePasswordExample
//
//  Created by Mai Nakagami on 2021/09/28.
//

#import "SettingController.h"
#import "SettingsTableViewCell.h"
#import "OneTimePasswordSettings.h"

#pragma mark - Settings item

typedef NS_ENUM(UInt8, SettingsItem) {
    AlgorithmItem,
    DigitsItem,
    PeriodItem,
};

extern SettingsItem SettingsItemUnknown;


#pragma mark - Settings table view controller

@interface SettingController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) OneTimePasswordSettings *settings;

@property (nonatomic) SettingsItem settingsItem;

@property (nonatomic) UIPickerView *pickerView;

@property (nonatomic) NSArray *algorithmPatterns;
@property (nonatomic) NSArray *digitsPatterns;
@property (nonatomic) NSArray *periodPatterns;

@end

@implementation SettingController {
    NSIndexPath * pickerIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [OneTimePasswordSettings sharedInstance];

    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.center = self.view.center;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview: self.pickerView];

    self.algorithmPatterns = @[@"SHA1", @"SHA256", @"SHA512"];
    self.digitsPatterns = @[@"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.periodPatterns = @[@"30", @"60"];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow: 0 inSection: 0]];
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
            cell.valueLabel.text = [self.settings algorithmString];
            break;
        case 1:
            cell.titleLabel.text = @"OTP桁数";
            cell.valueLabel.text = [self.settings digitsString];
            break;
        case 2:
            cell.titleLabel.text = @"タイムステップ数";
            cell.valueLabel.text = [self.settings periodString];
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.settingsItem = indexPath.row;
    NSInteger selectRow = [self pickerSelectRowWithItem:self.settingsItem];
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:selectRow inComponent:0 animated:true];
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            return self.algorithmPatterns.count;
        case DigitsItem:
            return self.digitsPatterns.count;
        case PeriodItem:
            return self.periodPatterns.count;
        default:
            return 0;
    }
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            return self.algorithmPatterns[row];
        case DigitsItem:
            return self.digitsPatterns[row];
        case PeriodItem:
            return self.periodPatterns[row];
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            [self.settings saveAlgorithmString:self.algorithmPatterns[row]];
            break;
        case DigitsItem:
            [self.settings saveDigitsString:self.digitsPatterns[row]];
            break;
        case PeriodItem:
            [self.settings savePeriodString:self.periodPatterns[row]];
            break;
    }
 
    [self.tableView reloadData];
}

#pragma mark - Settigns Index

- (NSInteger)pickerSelectRowWithItem:(SettingsItem)item{
    switch (item) {
        case AlgorithmItem:
            return [self indexWithAlgorithmString:[self.settings algorithmString]];
        case DigitsItem:
            return [self indexWithDigitsString:[self.settings digitsString]];
        case PeriodItem:
            return [self indexWithPeriodString:[self.settings periodString]];
    }
    return 0;
}

- (NSInteger)indexWithAlgorithmString:(NSString *)algorithmString {
    for (int i = 0; i < self.algorithmPatterns.count; i++) {
        if ([self.algorithmPatterns[i] isEqual:algorithmString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexWithDigitsString:(NSString *)digitsString {
    for (int i = 0; i < self.digitsPatterns.count; i++) {
        if ([self.digitsPatterns[i] isEqual:digitsString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexWithPeriodString:(NSString *)periodString {
    for (int i = 0; i < self.periodPatterns.count; i++) {
        if ([self.periodPatterns[i] isEqual:periodString]) {
            return i;
        }
    }
    return 0;
}

@end
